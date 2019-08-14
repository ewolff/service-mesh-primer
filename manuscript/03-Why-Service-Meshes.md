# Why Service Meshes? {#chapter-why}

By adding proxies to the data plane, service meshes make it possible
to solve some basic problems for microservices infrastructures. This
chapter explains the features services meshes provide in more
details.

## Monitoring {#section-why-monitoring}

A microservices system should include a monitoring infrastructure that
collects information from all microservices and makes them
accessible. This is required to keep track of the metrics for the huge
number of distributed microservices. You can implement alarms and
further analysis based on these metrics.

The proxies in the data plane can measure basic information about the
network traffic such as latencies or throughput. However, it is also
possible to get more information from the network traffic. The service
mesh needs to understand the protocol and interpret it. For example,
HTTP has some defined status codes that enable the service mesh to
determine whether a request was successful or not. That way the
service mesh can also measure error rates and the like.

Of course, the service mesh cannot look into the microservices. So
internal metrics about thread pools, database connection pools, and
the like are beyond what the service mesh can provide. However, it is
possible for the service mesh to use metrics that a platform like
Kubernetes provides and measure these, too.

Relying on a service mesh for monitoring has some benefits:

* It has no impact on the code of the microservice whatsoever. Metrics
  are measured only by the proxy, so any microservice will report the
  same metrics -- no matter in what programming language they are
  written or which framework they use.

* The metrics give a good impression about the state of the
  microservice. The metrics show the performance and reliability that
  a user or client would see. This is enough to ensure that service
  level agreements and quality of service is met.
  

So metrics provided by a service mesh might be enough to manage a
microservices system. However, for a root cause analysis additional
metrics from inside the microservices might be useful. In that case,
the service mesh is still helpful because it provides a standardized
monitoring environment that the service mesh already uses for its own
metrics.

#### Tracing 

Tracing solves a common problem in microservices systems.  A request
to a microservice might result in other requests.  Tracing helps to
understand these dependencies, thus facilitating root cause analysis.

The proxies are able to intercept each request. But to do tracing, it
is important to figure out which incoming request caused which
outgoing requests. This can only be done inside the
microservices. Usually, each request has some meta data such as a
unique ID e.g. as part of HTTP headers and that information is then
transferred to each outgoing request. The data for each request is
then stored in a centralized infrastructure.

A unique ID is not just valuable for tracing but it is also useful to
mark log entries that belong to one original request across all
microservices.

The code of the microservices has to transfer the IDs of each
request. So the service mesh cannot add tracing transparently to
microservices. This compromises an important benefit of service
meshes.

Also tracing is only useful for very specific cases. Most errors can
be analyzed by looking into just one microservice and treating the
other ones as black boxes. Tracing only adds value in very complex
scenarios.

The tracing data can also be used to create dependency
graphs. However, such a graph can be generated by observing the
traffic between microservices. There is no need for an ID in each
request and therefore no need to change the code of the
microservices.

## Logging {#section-why-logging}

Logging is another important technology to gain more insight into a
system. A service mesh collects information about the network
communication. It could write that information also to a log
file. Access logs that contain entries for each HTTP access were an
important source of information to evaluate the success of web
sites. So a log that contains only information about network traffic
might be useful.

However, oftentimes log files are used to analyze errors in
microservices. To do that, the log files have to include detailed
information. The microservices will need to provide that information
and log it. So just like with tracing, the microservice need to be
modified. In fact, for logging the service mesh adds little value
because usually the information about the network traffic is not that
useful to understand problems in the system.

The logging support of a service mesh has the advantage that
developers do not have to care about these logs at all. Also, the logs
are uniform no matter what kind of technology is used in the
microservices and how they log. Enforcing a common logging approach
and logging format takes some effort. This is particularly true for
microservices that use different technologies. So although the logs of
the service mesh might not include information from inside the
microservices, they are easy to get. Such a log might be better than
no log at all or no uniform log.

## Resilience {#section-why-resilience}

Resilience means that microservices still work even if other
microservices fail. If a microservices calls another microservice and
the called microservice fails, it will have some impact. Otherwise, the
microservice would not need to be called at all. So the calling
microservice will behave differently and might not be able to respond
successfully to each request. However, the microservice must still
respond. It must not block a request because then other microservices
might be blocked and an error cascade might occur. Also delays in the
network communication might lead to such problems.

A typical microservices architecture has a lot of microservices. So it
is quite likely that at least one microservice fails. If this leads to
a cascade of error, the system will become quite unstable.

### Circuit Breaker

*Circuit breakers* are one way to add some resilience to a
microservices system. A conventional circuit breaker would cut a
circuit if the circuit is shorten. That protects the circuit from
overheating. Circuit breakers in software systems do something
similar: They protect a part of the system by cutting off some of the
traffic.  Because service meshes add proxies to the communication
between the microservices, you can add a circuit breaker without
changing the code.

### Retry

*Retries* repeat the failed requests. They are an obvious way to
increase resilience: If the failure is transient, the retry can make
the request succeed. However, retries also increase the number of
requests. So the called microservice will have a higher load and might
become unstable. A circuit breaker might be used to solve this problem.
  
### Timeout

*Timeouts* make sure that the calling microservice is not blocked for
too long. Otherwise, if all threads are blocked, the calling
microservice might not be able to accept any more requests. So a
timeout will not make it more likely that a request succeeds but it
makes the request fail faster and therefore block less resources.

## Routing {#section-why-routing}

Any microservices system needs some way to route requests between
microservices and route a request from the outside to the correct
microservice. Implementing these features can be very simple. A
reverse proxy might be enough to route requests from the outside to
the correct microservices.

However, more advanced routing capabilities are useful, too:

* *Canary releasing* is a deployment process. First one instance of the
  new version of a microservice is deployed while there are still some
  instances of the old version around. Stepwise more and more traffic
  is routed to the new version. At the same time, the new version is
  monitored. So if there is a problem with the new version, it will
  become obvious while some instances of the old version are still
  around and it is therefore easy to roll back. Advanced routing
  supports this process by splitting the traffic between the two
  versions. This might be done randomly or according to specific
  segments like devices or geo regions.
  
* Another way to mitigate the risk of a deployment is *mirroring*. In
  that case the new and the old version of a microservice run in
  parallel. Both receive the traffic and respond to it. It is possible
  to look at different behavior in detail and determine whether the
  new version works correctly. Istio automatically discards the
  responses of the new service. In that case, the risk for
  deploying a new version is essential non-existent.

  * *A/B testing* gives different users access to different versions of
  a microservices. The test helps to determine which version generates
  more revenue, for example. Again randomly routing requests or
  routing requests for specific customer segments is a prerequisite
  for this approach.
  

Again, it is quite easy to implement these features once the proxies
of the service mesh are in place. The only difference might be that
not just traffic between microservices must be handled but also
traffic from the outside.

## Security {#section-why-security}

Obviously it is possible to *encrypt* the network traffic between the
proxies. However, there is still the network traffic between the proxy
and the microservice. Usually the proxy and the microservice run on
the same machine. So while the traffic might look like network traffic
it really goes through a loop-back device and not through a real
network. Therefore, service meshes can implement encryption and
confidentiality transparently.

To enable the encryption, a public key infrastructure is useful. If
each microservice receives a certificate, it is easy to set up
encrypted communication. It is even possible to use mTLS (mutual TLS
authentication). That way, each microservice has a unique
certificate. It is therefore possible to implement *authentication*
and ensure that a call actually originates from a specific
microservices.

Of course, it is then possible to limit what a microservice can
do. For example, the proxies might not allow specific requests to
other microservices. That means that the service mesh can implement
*authorization* for microservices.

Finally, it is possible to add a token to the HTTP
communication. Standards like [JWT](https://jwt.io/) (JSON Web Token)
define how information about a user and its roles can be transferred
with each HTTP request. The proxy of the service mesh can examine the
token and implement authorization based on the data provided.

## Performance Impact {#section-why-performance}

While services meshes have many benefits, they also add some
challenges. For example, they add proxies to the communication. This
increases the latency for network communication as the communication
goes through more hops. In some cases, latency is very important. For
example, for e-commerce applications a slightly higher latency can
already impact revenue.

For that reason, it is important to make the additional latency of the
proxies as small as possible. For example, it is possible to collect
data about requests in the proxy and send it to the service mesh
infrastructure later. That way sending the information does not
increase the latency even further.
Also updates -- for example, to security policies, are distributed asychronously
to the proxies. That means updates to such policies might take some time
until they are actually enforced in every proxy.
So Istio is optimized for low
latency.

Of course, the service mesh itself needs to run. This will consume
memory and CPU. However, hardware is becoming cheaper constantly and
adding some hardware resources to improve the reliability of a system
might be acceptable.

## Legacy {#section-why-legacy}

Service meshes are very useful for microservices architectures because
they solve many challenges of distributed systems.  Microservice
architecture has been around for years and its popularity is still
growing.  But many teams have experienced that slicing their
monolithic application takes a long time.  A service mesh can add
monitoring, routing, resilience, and security features to legacy parts
of the appication and facilitate integrating legacy and hybrid
applications in modern architectures. Of all service mesh
implementations, Istio offers the best support for this scenario
because it is not limited to Kubernetes. It can integrate legacy
system that run on different infrastructure using [service mesh
expansion](https://istio.io/docs/setup/kubernetes/additional-setup/mesh-expansion/).

## Alternatives to Service Meshes {#section-why-alternatives}

While services meshes provide a lot of features, there are also
alternatives. Monitoring, logging, and resilience can be implemented
as part of a microservice. There are numerous libraries that support
the implementation of these features. However, an infrastructure to
collect the monitoring and logging data still has to be setup. Also
libraries are only available for specific programming languages or
platforms. So if a microservice should be implemented in a different
programming language or on a different platform, another library must
be used. That is an additional effort and makes it harder to use
different technologies in the microservices. However, because there
are no proxies involved, the performance might be better. Also
libraries don't rely on a modification to the infrastructure. So if
just a few microservices should include the features mentioned above,
libraries might be the better solution because the behavior of the
infrastructure and therefore of all other microservices are not
modified at all. Also in same cases developers can not modify the
infrastructure because a different part of the organization or even a
different organization manages it.

For routing technologies such as reverse proxies or API gateways might
be alternatives. They are specialized in providing just these
features. Limiting the feature set might make them easier to handle
than a service mesh. However, it also means that they do not provide
all the other features a service mesh has to offer.

For security, an infrastructure that provides certificates must be set
up, certificates must be distributed, and the communication must be
encrypted. While there are alternatives, they also require a
modification to the infrastructure and have a limited set of
features. Also non-authorized microservices must not be able to get
certificates from the infrastructure. Service meshes control the
proxies that need to receive the certificates. So it is quite easy for
a service mesh to ensure that certificates are distributed securely
because the control all of parts of the communication infrastructure.

## Conclusion {#section-why-conclusion}

Service meshes are based on a rather simple idea: Add proxies to the
communication between microservices and add an infrastructure to
configure the proxy and evaluate the data the proxies send. However,
it turns out that this idea is quite powerful. It provides basic
monitoring, security, analysis of the dependencies, and resilience. It
is not necessary to change and code to enjoy these benefits.

However, for tracing the microservices have to forward the unique IDs
for each call. So in that case some changes to the code are
needed. Service meshes can provide only basic logging for the network
traffic. That might be of little value. And of course the additional
infrastructure comes with a cost: The latency increases and the also
the additional infrastructure consumes memory and CPU.

But still service meshes solve challenges that are quite important for
microservices systems and are therefore a good addition to a
microservices system.