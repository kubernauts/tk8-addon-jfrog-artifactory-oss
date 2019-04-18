# TK8 addon JFrog Artifactory OSS

## What are TK8 addons?

- TK8 add-ons provide freedom of choice for the user to deploy tools and applications without being tied to any customized formats of deployment.
- Simplified deployment process via CLI (will also be available via TK8 web in future).
- With the TK8 add-ons platform, you can also build your own add-ons.

### Prerequisites

This addon was created for the tk8 cli you could find it here: https://github.com/kubernauts/tk8
Addon integration is supported on Version 0.5.0 and greater

Alternative you can apply the main.yml directly with kubectl

To get more support join us on [Slack](https://kubernauts-slack-join.herokuapp.com)

## What is JFrog Artifactory?

JFrog Artifactory is an artifact repository manager, which is entirely technology agnostic and fully supports software created in any language or using any tool. It is also the only enterprise-ready repository manager available that supports secure, clustered, high availability Docker registries.

JFrog Artifactory addon provides open source version of the JFrog Artifactory.

## What do you need?

- A kubernetes cluster
- A default storage class defined
- TK8 binary

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Deploy jfrog-artifactory-oss on the Kubernetes Cluster

Run **tk8 addon install jfrog-artifactory-oss**

    $ tk8 addon install jfrog-artifactory-oss
    Install jfrog-artifactory-oss jfrog-artifactory-oss
    execute main.sh
    apply main.yml
    configmap/artifactory-artifactory-bs created
    role.rbac.authorization.k8s.io/artifactory-artifactory created
    rolebinding.rbac.authorization.k8s.io/artifactory-artifactory created
    secret/artifactory-artifactory created
    service/artifactory-artifactory created
    serviceaccount/artifactory-artifactory created
    statefulset.apps/artifactory-artifactory created
    deployment.apps/artifactory-artifactory-nginx created
    service/artifactory-artifactory-nginx created
    deployment.extensions/artifactory-postgresql created
    persistentvolumeclaim/artifactory-postgresql created
    secret/artifactory-postgresql created
    service/artifactory-postgresql created
     jfrog-artifactory-oss installation complete

This command will clone the kubernauts' jfrog-artifactory-oss repository (https://github.com/kubernauts/tk8-addon-jfrog-artifactory-oss) locally and install the necessary components.

This command creates:
- ConfigMaps, Secrets , ServiceAccount and Roles and RoleBindings for the artifactory
- A service of type LoadBalancer for the Frog artifactory front end served by Nginx
- Postgresql deployment for Storage.

If all goes, you should all resources in Running state:

    $ kubectl get all
    NAME                                                 READY   STATUS    RESTARTS   AGE
    pod/artifactory-artifactory-0                        1/1     Running   0          91s
    pod/artifactory-artifactory-nginx-595dc76b8b-s92dh   1/1     Running   1          90s
    pod/artifactory-postgresql-7b7756dbc4-q82d2          1/1     Running   0          90s
     
    NAME                                    TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
    service/artifactory-artifactory         ClusterIP      10.105.210.131   <none>        8081/TCP                     91s
    service/artifactory-artifactory-nginx   LoadBalancer   10.96.59.132     <pending>     80:30737/TCP,443:32676/TCP   90s
    service/artifactory-postgresql          ClusterIP      10.96.193.244    <none>        5432/TCP                     90s
    service/kubernetes                      ClusterIP      10.96.0.1        <none>        443/TCP                      7d12h
     
    NAME                                            READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/artifactory-artifactory-nginx   1/1     1            1           91s
    deployment.apps/artifactory-postgresql          1/1     1            1           90s
     
    NAME                                                       DESIRED   CURRENT   READY   AGE
    replicaset.apps/artifactory-artifactory-nginx-595dc76b8b   1         1         1       91s
    replicaset.apps/artifactory-postgresql-7b7756dbc4          1         1         1       90s
     
    NAME                                       READY   AGE
    statefulset.apps/artifactory-artifactory   1/1     91s
    
   
## Accessing the JFrog Artifactory Front-End

For visualizing the JFrog Artifactory front-end, use port-forwarding to expose the service. Run **kubectl port-forward svc/artifactory-artifactory-nginx 8081:80**. Then access the jfrog artifactory front end via http://localhost:8081/artifactory/webapp/#/home

## Uninstalling JFrog Artifactory

For removing jfrog-artifactory-oss from your cluster, we can use TK8 addon's destroy functionality. Run **tk8 addon destroy jfrog-artifactory-oss**

    $ tk8 addon destroy jfrog-artifactory-oss
    Destroying jfrog-artifactory-oss
    execute main.sh
    delete jfrog-artifactory-oss from cluster
    configmap "artifactory-artifactory-bs" deleted
    role.rbac.authorization.k8s.io "artifactory-artifactory" deleted
    rolebinding.rbac.authorization.k8s.io "artifactory-artifactory" deleted
    secret "artifactory-artifactory" deleted
    service "artifactory-artifactory" deleted
    serviceaccount "artifactory-artifactory" deleted
    statefulset.apps "artifactory-artifactory" deleted
    deployment.apps "artifactory-artifactory-nginx" deleted
    service "artifactory-artifactory-nginx" deleted
    deployment.extensions "artifactory-postgresql" deleted
    persistentvolumeclaim "artifactory-postgresql" deleted
    secret "artifactory-postgresql" deleted
    service "artifactory-postgresql" deleted
    jfrog-artifactory-oss destroy complete
