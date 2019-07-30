# What is a Service Mesh? {#chapter-what-is-a-service-mesh}

A Service Mesh is a dedicated infrastructure component that facilitates observing, controlling and securing communication between services. Unlike earlier appoaches such as Enterprise Service Buses or API Gateways, a service mesh embraces the distributed nature of modern microservice applications. 

A Service Mesh is composed of two layers, the data plane and the control plane. The data plane consists of a a number of Service Proxys, each deployed alongside every microservice instance. This is called the sidecar pattern: Capabilities that every service needs are extracted to an additional application (the sidecar) that is placed next to every service instance. Up to now, typical use cases for a sidecar have been basic monitoring and encryption of network connections. Therefore, a service proxy was deployed as a sidecar which intersects all network traffic. The configuration of these service proxy sidecar containers and any update to it had to be done manually. In a service mesh the service proxys, that make up the Data Plane, are configured automatically by the second layer of a servie mesh: the control plane. Any change to the behaviour of the service mesh configured by the developer is applied to the Control Plane and automatically distributed to the service proxys. As shown in figure 1.1, the Control Plane also processes telemetry data that is collected by the service proxys as they intersect all traffic.

This architecture adds powerful features like monitoring, circuit breaking, canary releasing and automatic mTLS to a microservice application without the need to change a single line of application code.

![Figure 1.1 - Service Mesh Architecture](images/service_mesh_architecture.png)



## Market Overview {#section-what-market-overview}

The first service mesh was Linkerd, developed in 2015 by the startup Buoyant. Although having been adopted in larger production systems, the software was too complex to configure for many users. In 2017, Google and IBM joined forces to create the Istio Service Mesh after they found out they have been working on similar ideas. The public attention Istio through Google and IBM as main contributors was amplified by media campaigns and conference talks. By the end of 2017, Linkerd announed a new, more opinionated service mesh  only for Kubernetes that was first named Conduit and later Linkerd 2. By 2018, the term Service Mesh was ubiquitous and more players joined the party. Consul was first described as a service mesh and AWS announced their own Service Mesh implementation AWS App Mesh.
