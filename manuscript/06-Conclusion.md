# Conclusion

Microservices are here to stay. And service meshes are likely to be their long-term companions. Many monitoring, routing, resilience, and security features implemented inside each microservice can and will be taken over by a service mesh over time.
These concepts have already proven themselves in the Google infrastructure.
In some cases, the service mesh cannot -- and should not -- fully implement the desired functionalities.
A service mesh has a black box view on the microservice. So internal information
of the microservice is hidden from it. For example, the service mesh can only provide
metrics about requests but not internal metrics like thread or database pool sizes.
Therefore, in the example in [chapter 4](#chapter-example) logging had to be implemented in
the microservices despite the service mesh.

#### Asynchronous Communication

A service mesh is not limited to traditional microservices following the request-response paradigm. Microservices that communicate asynchronously  also benefit from monitoring and security features
as well as from tools like Prometheus, Grafana, Jaeger, or Kiali.

However, asynchronous microservices
will probably not use HTTP at all so routing is of little use. Also the resilience features
are not useful. Asynchronous microservices will work on a message queue eventually. So if the
microservice is currently not available, processing the message will take more time - until 
the microservice is available again. The system should be able to deal with that, though.

#### Maturity

Current implementations such as Istio, Linkerd, Consul, and AWS App Mesh are already mature and stable enough to be considered for production systems. However, it is essential to carefully test and compare the technologies with regard to the individual use case. As the example in [chapter 3](#chapter-example) shows, a service mesh is a piece of infrastructure and can be added and removed easily without changing application code.
So it is relatively easy to test a service mesh for a concrete application without
investing too much effort.

#### Overhead

One of the few drawbacks of service meshes is the mental overhead they add for the developers. 
But the challenges service meshes solve must be dealt with in a microservices system anyway, 
which raises the question whether there is any simpler alternative to a service mesh. 
Compared to other available solutions, the mental overhead of a service mesh appears to be 
the smaller problem. The complexity of a service mesh seems rather necessary to deal with the 
complexity of the distributed microservice architecture itself.

However, not all service meshes have the same complexity. Istio provides many advanced features.
That increases complexity but might only pay off in very few scenarios. Linkerd 2 on the other hand
has less features, but is also less complex. For example, Linkerd 2 just defines one Kubernetes CRD (Custom
Resource Definition) while Istio has many. These add to the complexity
of the configuration of the service mesh. However, Istio can also be stripped down. It
is possible to exclude any part of the system from the installation. 

Recent efforts such as the SMI (Service Mesh Interface) intend to reduce mental overhead, standardize service 
mesh features, and will pave the way for even more tools on top of service mesh capabilities.

The second drawback is the technical overhead: A service mesh adds to the latency and the resource 
demands. However, this overhead will decrease since all current service mesh implementations are constantly 
improved. 

#### Service Mesh: Hype or Real?

So even though service meshes are a hype and there are some
drawbacks, the advantages prevail in most cases. As the impact on the
code is quite low, it is not too hard to give a service mesh a try and
determine its value. Even if you decide not to use it in production,
you will still learn something and understand modern infrastructure
even better.
