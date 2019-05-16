# What is a Service Mesh?

A Service Mesh is most often described as a dedicated infrastructure layer to achieve s secure, fast and reliable communication between services. This definition though does not cover key attributes of a Service Mesh such as its distributed nature and the two layers that enables the powerful monitoring, resilience, routing and security features a Service Mesh adds to a microservice application.

What differenciates a Service Mesh from API Gateways and Enterprise Service Buses, which are often used for similar use cases, are the Data Plane and Control Plane in the Service Mesh architecture. The Data Plane makes heavy use of the Sidecar Pattern. Additional capabiliities are extracted to an additional container (" Sidecar") that is placed next to every application container. Up to now, typical use cases for a sidecar have been basic monitoring and encryption of network connections. In order to achieve that, all network traffic was intercepted by a service proxy that was deployed as a sidecar. The configuration of these service proxy sidecar containers and any update to it had to be done manually. In a service mesh the service proxys, that make up the Data Plane, are configured automatically by a central component. This allows to entrust even more functions like resilience and routing to the sidecar. The central component which configures the Data Plane is called the Control Plane. Any change to the behaviour of the service mesh configured by the user is applied to the Control Plane and automatically distributed to the service proxys. As shown in figure 1, the Control Plane also processes data that has been collected by the Data Plane. This data can be used for monitoring and logging.

![Figure 1 - Service Mesh Architecture](images/service_mesh_architecture.pdf)



## Market Overview