# Other Service Meshes {#chapter-other}

While Istio is the most popular service mesh, the market is quite diverse and worth evaluating. The first Service Mesh tool is Linkerd, developed in 2015. 

In 2017, Google and IBM joined forces to create the Istio Service Mesh after they found out they have been working on similar ideas. The public attention Istio enjoyed through Google and IBM as main contributors was amplified by media campaigns and conference talks. By the end of 2017, Linkerd announed a new, more opinionated service mesh only for Kubernetes that was first named Conduit and later Linkerd 2. By 2018, the term Service Mesh was ubiquitous and more products and companies joined the party. Consul was first turned into a service mesh and AWS announced their own Service Mesh implementation AWS App Mesh.

## Linkerd 2 {#section-other-linkerd2}

The first service mesh was Linkerd, developed in 2015 by the startup Buoyant. Although having been adopted in large production systems, the software was too complex to configure and not performing well. These limitations induced Buoyant to develop a completely new Service Mesh. The result - formerly Conduit, today called Linkerd 2 - was presented in December 2017 as an Open Source project, written in Go and Rust. Linkerd 2 is also a incubation Project of the CNCF (Cloud Native Computing Foundation) and currently the only Service Mesh in the CNCF Landscape.

Although Kubernetes is the most common platform to be used with Istio, it's designed to work with any environment. Te complexity of Istio is to some extent connected to this platform neutral design. While the first version of Linkerd was designed alike, Linkerd 2 benefits from it's commitment to Kubernetes. The current version 2.4 supports HTTP and TCP connections. Most Service Mesh functions like automatic injection of proxy sidecars, monitoring, routing, retries, timeouts and mTLS are ready for production. Some features like circuit breaking and tracing are completely missing. Unlike all other Service Mesh implementations, which use the third-party Service Proxy Envoy, Linkerd includes its own implementation of a service proxy (linkerd-proxy).

Rewriting Linkerd for usability and performance while integrating with Kubernetes seems to have worked out. The API of Linkerd 2 is much more clean and consistent than Istio's. It has only one CRD (Istio has 23) and a carefully considered dashboard. Kubernetes users should consider it closely since it includes most features in a production ready stage, has a great performance and provides excellent developer experience.

> Performance
>
> refined Timeouts and retrys
>
> concept of tap
>
> minimal-invasiv durch Ingress

![Linkerd Dashboard](images/linkerd-dashboard.png)

## Consul {#section-other-consul}

Consul, originally a solution for Service Discovery, recently added Service Mesh use cases. Consul supports service discovery, authorization, mTLS, monitoring through metrics and routing capabilities. The latter were added by integrating with the Envoy Proxy that Istio and other Service Meshes are also using. Resilience features like circuit breaking, retry and timeout are yet to be developed. Like istio, Consul does not depend on any orchestration platform.

> TODO: Screenshot, details
>
> Performance
>
> Dokumentation
>
> API
>
> Kubernetes-Support

## AWS App Mesh {#section-other-aws-app-mesh}

As the name suggests, AWS App Mesh is a service mesh developed for AWS. It was first introduced in November 2018. Like Istio and Consul, AWS App Mesh uses Envoy as Service Proxy and adds its own Control Plane that for example exports metrics to Amazon CloudWatch. AWS App Mesh is in "public preview" status at the time and only supports a small part of the Service Mesh features like monitoring and routing.

>  TODO: Screenshot, details
>
> Performance
>
> Dokumentation
>
> API
>
> Kubernetes-Support

## When to Choose Which? {#section-other-choose}

The features a service mesh provides seem to be useful for the vast majority of microservice applications. When it comes to chosing a specific tool, It is hard to resist going with Istio as it is the most popular one. But experience taught us that technical decisions are best based on requirements and problems rather than any hype, a projects public attention or even its amount of features.

Istio overtook all other service mesh tool in terms of feature completeness and configurability. But these atteributes have made istio an invasive component that is hard to manage in practice, especially because not all features and their configurability are required for all applications



Service meshes only for microservices?