# Generic Helm Chart

This chart is a template for common Kubernetes resource manifests, which should cover most use cases. Please read through the list of possible configuration parameters. If you miss a specific feature, you can easily add it via a pull request. If you don't think you can do that, just create a JIRA issue in the Container Platform Team JIRA project (Key: COP)

## Examples
You can find an example setup using the generic-chart in the [examples directory](./examples/). The [values-example.yaml](./values-example.yaml) contains some extended configuration examples.

## Configuration

| Parameter | Description | Default |
|----------:|:------------|:--------|
| **replicaCount** | Amount of `Pod` replicas | `1` |
| **revisionHistoryLimit** | Amount of old `ReplicaSets` for this `Deployment` should be retained | `1` |
| **image.repository** | URL to the container registry with organisation and repository | `nil` |
| **image.tag** | Image tag of the provided container repository | `nil` |
| **image.pullPolicy** | The pull policy when a image should be pulled (`IfNotPresent`, `Always`) | `IfNotPresent` |
| **imagePullSecrets** | Reference a `Secret` which should be use to authenticate against a container registry | `nil` |
| **nameOverride** | Override the fullname with this name | "" |
| **serviceAccount.create** | If a `ServiceAccount` should be created. If `false` a `ServiceAccount` must be provided and configured correctly with its name under `serviceAccount.name`.  | `true` |
| **serviceAccount.name** | Name of the `ServiceAccount`. If not set and create is true, a name is generated using the name template | `nil` |
| **serviceAccount.automountServiceAccountToken** | If `true` the `Secret` with the `Token` and `Certificates`  of the `ServiceAccount` is mounted. Only required when access to the master API is necessary | `false` |
| **serviceAccount.annotations** | Sets [`annotations`](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/) for the `ServiceAccount` | `{}` |
| **network** | Map of ports which should be exposed. Adds `ports` section to the Pod template, adds `ports` section to Service and can create `Ingress` or `Route` for the ports. | `network.http.servicePort: 8080` |
| **network.{}.servicePort** | Port number of the `Service` (e.g. 8080, 8443). If `nil` no port on the `Service` is exposed | `nil` |
| **network.{}.containerPort** | The port which is exposed on the `Pod`. If `nil` corresponds to the `network.{}.servicePort` | `nil` |
| **network.{}.ingress** | If not `nil` creates an `Ingress` or `Route` for the `Service` and its `servicePort`. If set to `{}` see `ingress.zone` | `nil` |
| **network.{}.ingress.host** | Sets the hostname for the `Ingress` or `Route`. If `nil` see `ingress.zone` | `nil` |
| **network.{}.ingress.annotations** | Sets [`annotations`](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/) for the `Ingress` or `Route` instance | `{}` |
| **network.{}.ingress.path** | Sets the path for the `Ingress` or `Route` instance | `/` |
| **service.type** | `Service` type (`ClusterIP`, `NodePort`, `ExternalName`) | `ClusterIP` |
| **service.annotations** | Sets [`annotations`](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/) for the `Service` | `{}` |
| **ingress.controller** | Sets the type of the ingress controller (e.g. Route, Ingress) | `Route` |
| **ingress.zone** | ***Deprecated***: If set to `ch` or `sh` and `network.{}.ingress.host` is `nil`, the hostname is generated (~ $CHART_NAME-$RELEASE_NAME.$ZONE$ENV.os1.balgroupit.com) | `nil` |
| **env** | List of environment variables for the `Deployment` | `[]` |
| **envFrom** | Set environment variables from a `ConfigMap` or `Secret`. See [`envFrom`](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#configure-all-key-value-pairs-in-a-configmap-as-container-environment-variables) | `nil` |
| **persistence.enabled** | If `true` a [`PVC`](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) is created | `false` |
| **persistence.name** | The name of the PVC | `generic-chart.name` |
| **persistence.accessModes** | [`accessModes`](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) of the PVC (ReadWriteOnce, ReadWriteMany) | `ReadWriteOnce` |
| **persistence.storageClass** | [`storageClass`] of the PVC (trident-nfs-snapshot, trident-nfs) | `trident-nfs-snapshot` |
| **persistence.size** | Size of the PVC (e.g. 512Mi, 10Gi, 1Ti) | `nil` |
| **persistence.volumeMountPath** | Path where to volume should be mounted (e.g. `/var/data/`). If set, `volumes` and `volumeMounts` are configured | `nil` |
| **persistence.annotations** | Sets [`annotations`](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/) for the `PersistentVolumeClaim` | `{}` |
| **volumes** | Set [`Volumes`](https://kubernetes.io/docs/concepts/storage/volumes/) available to the `Pod` | `[]` |
| **volumeMounts** | Mounts a [`Volume`](https://kubernetes.io/docs/concepts/storage/volumes/) defined in `volumes` in the container. | `[]` |
| **readinessProbe** | Defines the [`readinessProbe`](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) | `{}` |
| **livenessProbe** | Defines the [`livenessProbe`](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) | `{}` |
| **resources** | CPU/Memory resource [`requests/limits`](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container) | `{}` |
|**podSecurityContext** | [`securityContext`](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) of the `Pod` | `{}`|
|**securityContext** | [`securityContext`](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) for the container | `{}`|
|**nodeSelector** | [`nodeSelector`](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#nodeselector) schedules Pods only on matching nodes | `{}` |
|**tolerations** | [`tolerations`](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) allows to schedule `Pods` on nodes with [`taints`](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/)  | `{}` |
|**affinity** | Set [`affinity`](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) to control how pods are scheduled | `{}` |
|**defaultAffinityRules.enabled** | If `true` prevents that the `Pod` defined in `replicaCount` are not scheduled on the same node | `true` |
|**annotations** | Sets [`annotations`](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/) for the `Pod` | `{}` |
|**command** | Sets [`command`](https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#define-a-command-and-arguments-when-you-create-a-pod) for the `Pod`. | `[]` |


## Migrations from earlier versions
### Migration from 1.0.x to 2.0.0 / Upgrade to Helm 3
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

### Migration from 0.4.0/0.12.0 to 1.x.x
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

## Contributions
If you contribute new featuers or fix a bug, please update the `.version` in the `Chart.yaml` according to [SemVer](https://semver.org/) and update the documentation.