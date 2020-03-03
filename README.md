# Generic Helm Chart

This chart is a template for common Kubernetes resource manifests, which should cover most use cases. Please read through the list of possible configuration parameters. If you miss a specific feature, you can easily add it via a pull request. If you don't think you can do that, just create a JIRA issue in the Container Platform Team JIRA project (Key: COP)

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
| **service.type** | `Service` type (`ClusterIP`, `NodePort`, `ExternalName`) | `ClusterIP` |
| **service.port** | Port number of the application (e.g. 8080, 8443). cannot be below 1024 by default | `8080` |
| **ingress.enabled** | If `true` an exposing resource for the `Service` is created (e.g. Route or Ingress) | `false` |
| **ingress.controller** | Sets the type of the ingress controller (e.g. Route, Ingress) | `Route` |
| **ingress.host** | Hostname of the exposing resource (e.g. demo-app.chapp-test.os1.balgroupit.com) | `nil` |
| **ingress.zone** | If set to `ch` or `sh` and `ingress.host` is `nil`, the hostname is generated (~ $CHART_NAME-$RELEASE_NAME.$ZONE$ENV.os1.balgroupit.com) | `nil` |
| **env** | List of environment variables for the `Deployment` | `[]` |
| **envFrom** | Set environment variables from a `ConfigMap` or `Secret`. See [`envFrom`](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#configure-all-key-value-pairs-in-a-configmap-as-container-environment-variables) | `nil` |
| **persistence.enabled** | If `true` a [`PVC`](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) is created | `false` |
| **persistence.accessModes** | [`accessModes`](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) of the PVC (ReadWriteOnce, ReadWriteMany) | `ReadWriteOnce` |
| **persistence.storageClass** | [`storageClass`] of the PVC (trident-nfs-snapshot, trident-nfs) | `trident-nfs-snapshot` |
| **persistence.size** | Size of the PVC (e.g. 512Mi, 10Gi, 1Ti) | `nil` |
| **persistence.volumeMount** | Path where to volume should be mounted (e.g. `/var/data/`). If set, `volumes` and `volumeMounts` are configured | `nil` |
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

## Contributions
If you contribute new featuers or fix a bug, please update the `.version` in the `Chart.yaml` according to [SemVer](https://semver.org/) and update the documentation.