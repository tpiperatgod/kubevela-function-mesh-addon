# Function Mesh addon for KubeVela

The purpose of the Function Mesh addon is to provide serverless capabilities based on Function Mesh for the users of OAM applications.

## Install

Function Mesh is a serverless framework purpose-built for stream processing applications. It brings powerful event-streaming capabilities to your applications by orchestrating multiple [Pulsar Functions](https://functionmesh.io/docs/functions/function-overview) and [Pulsar IO connectors](https://functionmesh.io/docs/connectors/pulsar-io-overview) for complex stream processing jobs.

### Prerequisites

Before using this addon, ensure to perform the following operations.

- Kubernetes server v1.19 or higher.
- KubeVela v1.4 or higher
- Apache Pulsar cluster 2.9.* or higher.
  - Follow this [docs](https://pulsar.apache.org/docs/next/getting-started-helm/) to install Pulsar
  - Or you can choose the [Pulsar Operator](https://docs.streamnative.io/operators/pulsar-operator/pulsar-operator-install) provided by StreamNative
- Cert-Manager (Use the command `vela addon enable cert-manager` to install it)
- FluxCD (Use the command `vela addon enable fluxcd` to install it)

### Enable the addon

> Currently this addon is only supported for local installation, you need to go into the repository directory and execute the following command

```shell
vela addon enable .
```

You need to manually create a configuration file for accessing the Pulsar cluster

> You need to update the value of `.pulsar.pulsarConfig` in Meshes Component with `<config-map-name>`

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: <config-map-name>
  namespace: <same-namespace-as-the-application>
data:
  webServiceURL: http://sn-platform-pulsar-broker.default.svc.cluster.local:8080 # this is an example
  brokerServiceURL: pulsar://sn-platform-pulsar-broker.default.svc.cluster.local:6650 # this is an example
```

## Demo

https://drive.google.com/file/d/1HuvLalaC7swdoFJ1iFjpsXhrL9C-iSBy/preview
