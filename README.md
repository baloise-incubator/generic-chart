# Generic Helm Chart

This chart is a template for common Kubernetes resource manifests, which should cover most use cases. Please read through the list of possible configuration parameters. If you miss a specific feature, you can easily add it via a pull request. If you don't think you can do that, just create a JIRA issue in the Container Platform Team JIRA project (Key: COP)

## Configuration

| Parameter | Description | Default |
|----------:|:------------|:--------|
| **replicaCount** | Amount of `Pod` replicas | 1 |
| **revisionHistoryLimit** | Amount of old `ReplicaSets` for this `Deployment` should be retained | `1` |
| **image.repository** | URL to the container registry with organisation and repository | `nil` |
| **image.tag** | Image tag of the provided container repository | `nil` |
| **image.pullPolicy** | The pull policy when a image should be pulled (`IfNotPresent`, `Always`) | `IfNotPresent` |
| **imagePullSecrets** | Reference a `Secret` which should be use to authenticate against a container registry | `nil` |
| **nameOverride** | Override the fullname with this name | "" |
| **service.type** | Defines `Service` type (`ClusterIP`, `NodePort`, `ExternalName`) | `ClusterIP` |
| **service.port** | Port number of the application (e.g. 8080, 8443). cannot be below 1024 by default | `8080` |
| **route.enabled** | If `true` a `Route` for the `Service` is created | `false` |
| **route.host** | Hostname of the `Route` | `nil` |
| **route.zone** | If set, the `Route` hostname can be generated (`ch` or `sh`) | `nil` |
| **env** | List of environment variables for the `Deployment` | `[]` |
| **envFrom** | Defines x[`envFrom`](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#configure-all-key-value-pairs-in-a-configmap-as-container-environment-variables) | `nil` |
| **readinessProbe** | Defines the [`readinessProbe`](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) | `{}` |
| **livenessProbe** | Defines the [`livenessProbe`](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) | `{}` |
| **resources** | CPU/Memory resource requests/limits | `{}` |
|**podSecurityContext** | Defines the [`securityContext`](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) for the pod | `{}`|
|**securityContext** | Defines the [`securityContext`](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) for the container | `{}`|
|**nodeSelector** | Defines the [`nodeSelector`](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#nodeselector) for the pod | `{}` |
|**tolerations** | Defines [`tolerations`](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) to schedule the pod on nodes with [`taints`](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/)  | `{}` |
|**affinity** | Defines [`affinity`](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) to prevent pods on the same node | `{}` |