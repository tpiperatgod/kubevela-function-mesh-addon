package main

output: {
		apiVersion: "core.oam.dev/v1beta1"
		kind:       "Application"
		spec: {
				components: [
						{
								type: "k8s-objects"
								name: "function-mesh-operator-ns"
								properties: objects: [{
										apiVersion: "v1"
										kind:       "Namespace"
										metadata: name: parameter.namespace
								}]
				},
				{
						name: "function-mesh"
						type: "helm"
						dependsOn: ["function-mesh-operator-ns"]
						type: "helm"
						properties: {
								repoType: "git"
								url:      "https://github.com/streamnative/function-mesh"
								chart:    "./charts/function-mesh-operator"
								targetNamespace: parameter["namespace"]
								git:
								  branch: "master"
						}
				},
		]
				policies: [
						{
								type: "shared-resource"
								name: "namespace"
								properties: rules: [{
										selector: resourceTypes: ["Namespace"]
								}]
						},
						{
								type: "topology"
								name: "deploy-cert-manager-ns"
								properties: {
										namespace: parameter.namespace
										if parameter.clusters != _|_ {
												clusters: parameter.clusters
										}
										if parameter.clusters == _|_ {
												clusterLabelSelector: {}
										}
								}
						},
				]
		}
}