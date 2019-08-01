# Why Service Meshes? {#chapter-why}

## Monitoring {#section-why-monitoring}

Tracing (part of monitoring)

Do we actually need tracing?

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
overheating.  Circuit breakers in software systems do something
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

incl canary

## Security {#section-why-security}

## Performance Impact {#section-why-performance}

Mention optimizations i.e. async communication in the control plane
