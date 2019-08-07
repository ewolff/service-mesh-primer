# Other Service Meshes {#chapter-other}

While Istio is the most popular service mesh, the market is quite diverse and worth evaluating. The first service mesh tool was Linkerd, developed in 2015. 

In 2017, Google and IBM joined forces to create the Istio Service Mesh after they found out they have been working on similar ideas. The public attention Istio enjoyed through Google and IBM as main contributors was amplified by media campaigns and conference talks. By the end of 2017, Linkerd announced a new, more opinionated service mesh only for Kubernetes that was first named Conduit and later Linkerd 2. By 2018, the term Service Mesh was ubiquitous and more products and companies joined the party. Consul was first turned into a service mesh and AWS announced their own Service Mesh implementation AWS App Mesh.

## Linkerd 2 {#section-other-linkerd2}

Linkerd 2 is the successor of Linkerd.
Although Linkerd had been adopted in large production systems, the software was too complex to configure and not performing well. These limitations induced Buoyant to develop a completely new service mesh. The result - formerly Conduit, today called Linkerd 2 - was presented in December 2017 as an open source project, written in Go and Rust. Linkerd 2 is an incubation project of the CNCF (Cloud Native Computing Foundation) and currently the only Service Mesh in the CNCF portfolio.

Although Kubernetes is the most common platform to be used with Istio, it is designed to work with any environment. The complexity of Istio is to some extent caused by this platform neutral design. While the first version of Linkerd was designed alike, Linkerd 2 benefits from its commitment to Kubernetes. The current version 2.4 supports HTTP and TCP connections. Most service mesh functions like automatic injection of proxy sidecars, monitoring, routing, retries, timeouts, and mTLS are ready for production. Some features like circuit breaking and tracing are missing. Unlike other service mesh implementations, which use the third-party service proxy Envoy, Linkerd includes its own implementation of a service proxy (linkerd-proxy).

<!-- it remains unclear which features are not ready for production. Most are ready for production, some are missing - which are not ready for production? -->

Rewriting Linkerd for usability and performance while integrating with Kubernetes seems to have worked out. The API of Linkerd 2 is much cleaner and more consistent than Istio's. It has only one CRD (Custom Resource Definition) that has to be used in a Kubernetes configuration. Istio has 23 CRDs. Linkerd 2 also provides a carefully considered dashboard. Kubernetes users should seriously consider it since it includes most features in a production ready stage, has a great performance, and provides an excellent developer experience.

> Performance
>
> refined Timeouts and retrys
>
> concept of tap
>
> minimal-invasiv durch Ingress

![Figure 5.1: Linkerd Dashboard](images/linkerd-dashboard.png)

## Consul {#section-other-consul}

Consul, originally a solution for Service Discovery, recently added Service Mesh use cases. Consul supports service discovery, authorization, mTLS, monitoring through metrics, and routing capabilities. The latter were added by integrating with the Envoy Proxy that Istio and other Service Meshes are also using. Resilience features like circuit breaking, retry, and timeout are yet to be developed. Like Istio, Consul does not depend on any specific orchestration platform.

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

As the name suggests, AWS App Mesh is a service mesh developed for AWS. It was first introduced in November 2018. Like Istio and Consul, AWS App Mesh uses Envoy as service proxy and adds its own control plane. The control plane for example exports metrics to Amazon CloudWatch. AWS App Mesh is currently in "public preview" status and only supports a small part of the service mesh features like monitoring and routing.

>  TODO: Screenshot, details
>
> Performance
>
> Dokumentation
>
> API
>
> Kubernetes-Support

<!-- I like the recommendation concerning Linkerd 2 above. Will you provide something similar for App Mesh? -->

## When to Choose Which? {#section-other-choose}

The features a service mesh provides seem to be useful for the vast majority of microservice applications. When it comes to chosing a specific tool, it is hard to resist going with Istio as it is the most popular one. But experience shows that technical decisions are best based on requirements and problems rather than any hype, a projects public attention, or even its number of features.

Istio overtook all other service mesh tool in terms of feature completeness and configurability. But these attributes have made Istio an invasive component that is hard to manage in practice, especially because not all features and their configurability are required for all applications.



Service meshes only for microservices?
