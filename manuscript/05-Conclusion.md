# Conclusion

Microservices are here to stay. And service meshes are likely to be their long-term companions. Many monitoring, routing, resilience, and security features implemented inside each microservice can and will be taken over by a service mesh over time.
These concepts have already proven themselves in the Google infrastructure.
In some cases, the service mesh cannot fully implement the required functionalities.
A service mesh has a black box view on the microservice. So internal information
of the microservice is hidden from it. For example, the service mesh can only provide
metrics about requests but not internal metrics like thread or database pool sizes.
Therefore in the example in [chapter 4](#chapter-example) logging had to be implemented in
the microservices despite the service mesh.

A service mesh is not limited to traditional microservices following the request-response paradigm. Microservices that communicate asynchronously  also benefit from monitoring and security features
as well as the tools like Grafana, Prometheus, Jaeger, or Kiali.
<!-- I don't see why SCS won't profit from all features mentioned above so I removed them -->
However, asynchronous microservices
will probably not use HTTP at all so routing is of little use. Also the resilience features
are not useful. Asynchronous microservices will work on a message eventually. So if the
microservice is currently not available, processing the message will take more time - until 
the microservice is available again. The system should be able to deal with that, though.

Current implementations such as Istio, Linkerd, Consul, and AWS App Mesh are already mature and stable enough to be considered for production systems. However, carefully testing and comparing the technologies with regard to the individual use case is essential. As the example in [chapter 3](#chapter-example) shows, a service mesh is a piece of infrastructure and can be added and removed easily without changing application code.
So it is relatively easy to test a service mesh for a concrete application without
investing too much effort.

The few drawbacks a service mesh has are the mental overhead it adds for the developers.
However, the feature the service mesh provides would need to be implemented differently
if no service mesh is used. So the mental overhead is probably the smaller problem.
There is also the technical overhead: A service mesh adds to the latency and the resource demands. However, those drawbacks will decrease since all current service mesh implementations are constantly improved. Recent efforts such as the SMI (Service Mesh Interface) will reduce mental overhead, standardize service mesh features, and will pave the way for even more tools on top of service mesh capabilities.

However, Istio is not just powerful but also complex. To solve this, Istio can be stripped down. It
is possible to exclude each part of the system from the installation. The question is whether any
simpler alternative exists. The challenges Istio solves must be dealt with in a microservices system.
Istio’s complexity is probably not a problem of Istio but rather of the microservices themselves.
