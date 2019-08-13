# Conclusion

Microservices are here to stay. And service meshes are likely to be their long-term companions. Many monitoring, routing, resilience, and security features implemented inside each microservice can and will be taken over by a service mesh over time. A service mesh is not limited to traditional microservices following the request-response paradigm. Microservices that communicate asynchronously and Self-contained Systems (SCS) also benefit from monitoring and security features.

Current implementations such as Istio, Linkerd, Consul and AWS App Mesh are already mature and stable enough to be considered for production systems. However, carefully testing and comparing the technologies with regard to the individual use case is essential. As the example in [chapter 4](#chapter-example) shows, a service mesh is a piece of infrastructure and can be added and removed easily without changing application code.

The few drawbacks a service mesh has are the mental overhead it adds for the developers and the technical overhead that adds to the latency and the resource demands. However, those drawbacks will decrease since all current service mesh implementations are costantly improved. Recent efforts such as the SMI (Service Mesh Interface) will reduce mental overhead, standardize service mesh features and will pave the way for even more tools on top of service mesh capabilities.

