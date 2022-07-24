# 3.9.2 (2022-07-24)
## Fix
- Fix network.{}.ingress.enableIstioIngressGateway so that it matches the documentation

# 3.9.1 (2022-07-24)
## Fix
- Fix service creation for StatefulSets

# 3.9.0 (2022-07-22)
## Feature
- Add support for StatefulSets, including Service per Pod and Route per Service

# 3.8.1 (2022-06-24)
## Bugfix
- Include chart name template in container name to make `nameOverride` work. Bug was introduced in 3.7.0.


# 3.8.0 (2022-06-22)
## Features
- Add support for creation of service type LoadBalancer and service type clusterIP for same pod with different ports

# 3.7.0 (2022-06-10)
## Features
- Add support for service type LoadBalancer

# 3.6.0 (2022-06-08)
## Features
- Add support for [Reloader](https://github.com/stakater/Reloader)

# 3.5.0 (2022-05-31)
## Features
- Add support to override target namespace

# 3.4.1 (2022-05-06)
## Fixes
- Include chart name template in container name to make `nameOverride` work

# 3.4.0 (2022-04-01)
## Features
- Add support for deploying strategies.

# 3.3.0 (2021-11-05)
## Features
- Add support for deploying workloads in a designated service mesh.

# 3.2.0 (2021-07-22)
## Breaking Change
- Remove `persistence.storageClass` default `trident-nfs-snapshot`. This leads to using the default storage class defined in the corresponding OpenShift cluster.

# 3.1.0 (2021-06-14)
## Features
- Add `network.{}.serviceMonitor.extraConfig` which allows to append any custom configuration to the endpoints section of the ServiceMonitor 

# 3.0.0 (2021-05-25)
## Features
- Add topology awareness for pods. Required for new Cluster in HCL datacenter

# 2.4.0 (2021-05-05)
## Features
- Enable support for multiple containers

# 2.3.1 (2021-03-26)
## Fixes
- Include chart name in ServiceMonitor name to prevent resource name collisions.

# 2.3.0 (2021-03-04)
## Features
- Add the option to create a serviceMonitor for each exposed port.

# 2.2.0 (2020-12-01)
## Features
- Add initContainers to the deployment template. Now initContainers can be defined in `values.yaml` (in plain YAML).

# 2.1.0 (2020-08-10)
## Features
- Expose container `args`

# 2.0.0 (2020-07-22)
## Breaking Changes
- Migrate to Helm 3

## Migration from 1.0.x to 2.0.0 / Upgrade to Helm 3
From 1.0.2 to 2.0.0 the generic-chart switch to Helm 3. This requires no changes to the `values.yaml` file but to the `Chart.yaml` and `requirements.yaml`. The content of the `requirements.yaml` now goes to the `Chart.yaml`. **The `requirements.yaml` file can be deleted afterwards**. Using Helm 3 requires to set two additional fields in the `Chart.yaml`. The `apiVersion` needs to be set to `v2` and the `version` fields must be set to a value (e.g. `1.0.0`) but it has no sematic meaning while using in config repositories.
Example of a new Chart.yaml using Helm 3 and generic-chart 2.0.0:
```yaml
apiVersion: v2
name: demo-test
version: 1.0.0
dependencies:
  - name:  generic-chart
    version: 2.0.0
    repository: https://charts.shapp.os1.balgroupit.com/shared/release/
    alias: demo
```

# 1.0.2 (2020-06-03)
## Fixes
- Fail if using .ingress.zone with multiple routes
- .ingress.zone is now deprecated 

# 1.0.1 (2020-05-27)
## Fixes
- fixed generated hostname

# 1.0.0 (2020-05-26)
## Features
- Initial stable release of generic-chart

## Migration from 0.4.0/0.12.0 to 1.x.x
From 0.4.0 to 1.0.x the concept of how a `Route` is created changed. The pre-release version, the `Route` configuration looked like this:
```yaml
generic:
[...]
  route:
    enabled: true
    host: demo-prod.shapp.os1.balgroupit.com
```
From 0.12.0 versions to 1.0.x the concept of how a `Route` is created changed. The pre-release version, the `Route` configuration looked like this:
```yaml
generic:
[...]
  ingress:
    enabled: true
    host: demo-prod.shapp.os1.balgroupit.com
```

With the introduction of support for multiple `Routes` and renaming `route` to `ingress` the equivalent in the new configuration looks like this:
```yaml
generic:
  network:
    http:
      ingress:
        host: demo-test.shapp-test.os1.balgroupit.com

``` 
The `network` section now configures the `Service` and `Route` configuration. The keyword `http` can be freely choosen (e.g. `metrics` or `web`) and then corresponds to the `port` name and is part of the name in the `Route` object.

