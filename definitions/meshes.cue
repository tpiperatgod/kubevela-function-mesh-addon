"meshes": {
	annotations: {}
	attributes: workload: {
		type: "autodetects.core.oam.dev"
	}
	description: "Argocd-application is a definition of application resource."
	labels: {}
	type: "component"
}

template: {
	parameter: {
		functions?: [...#Function]
		sinks?: [...#Sink]
		sources?: [...#Source]

		#Function: {
			// +usage=Function image.
			image:                    string
			name:                     string
			maxPendingAsyncRequests?: *1000 | int
			replicas?:                *1 | int & >=1
			maxReplicas?:             int & >=replicas
			minReplicas?:             *1 | int & <=replicas
			logTopic:                 string
			input:                    #Input
			output:                   #Output
			resources?:               #Resources
			secretsMap?: {
				[string]: {
					path: string
					key:  string
				}
			}
			timeout?:                      int
			autoAck?:                      *true | bool
			maxMessageRetry?:              int
			processingGuarantee?:          *"atleast_once" | "atmost_once" | "effectively_once"
			retainKeyOrdering?:            bool
			retainOrdering?:               bool
			deadLetterTopic?:              string
			forwardSourceMessageProperty?: *true | bool
			runtimeFlags?:                 string
			subscriptionName?:             string
			cleanupSubscription?:          bool
			subscriptionPosition?:         *"latest" | "earliest"
			javaRuntimeConfig?:            #JavaRuntime
			pythonRuntimeConfig?:          #PythonRuntime
			golangRuntimeConfig?:          #GolangRuntime
			pulsar?:                       #Pulsar
			imagePullPolicy?:              "Always" | "Never" | *"IfNotPresent"
			statefulConfig?:               #StatefulConfig
			funcConfig?: {
				[string]: string
			}
			volumeMounts?: #VolumeMounts
			windowConfig?: {
				actualWindowFunctionClassName: string
				windowLengthCount?:            int
				windowLengthDurationMs?:       int
				slidingIntervalCount?:         int
				slidingIntervalDurationMs?:    int
				lateDataTopic?:                string
				maxLagMs?:                     int
				watermarkEmitIntervalMs?:      int
				timestampExtractorClassName?:  string
			}
			pod?: #Pod
		}

		#Sink: {
			image:            string
			name:             string
			clusterName?:     *"kubernetes" | string
			tenant?:          *"public" | string
			namespace?:       *"default" | string
			sinkType?:        string
			replicas?:        *1 | int & >=1
			maxReplicas?:     int & >=replicas
			minReplicas?:     *1 | int & <=replicas
			downloaderImage?: string
			input:            #Input
			sinkConfig?: {
				[string]: string
			}
			resources?: #Resources
			secretsMap?: {
				[string]: {
					path: string
					key:  string
				}
			}
			volumeMounts?:                 #VolumeMounts
			timeout?:                      int
			autoAck?:                      *true | bool
			negativeAckRedeliveryDelayMs?: int
			maxMessageRetry?:              int
			processingGuarantee?:          *"atleast_once" | "atmost_once" | "effectively_once"
			retainOrdering?:               bool
			deadLetterTopic?:              string
			runtimeFlags?:                 string
			subscriptionName?:             string
			cleanupSubscription?:          bool
			subscriptionPosition?:         *"latest" | "earliest"
			pod?:                          #Pod
			pulsar:                        #Pulsar
			javaRuntimeConfig?:            #JavaRuntime
			imagePullPolicy?:              "Always" | "Never" | *"IfNotPresent"
			statefulConfig?:               #StatefulConfig
		}

		#Source: {
			image:            string
			name:             string
			clusterName?:     *"kubernetes" | string
			tenant?:          *"public" | string
			namespace?:       *"default" | string
			sourceType?:      string
			replicas?:        *1 | int & >=1
			maxReplicas?:     int & >=replicas
			minReplicas?:     *1 | int & <=replicas
			downloaderImage?: string
			output:           #Output
			batchSourceConfig?: {
				discoveryTriggererClassName?: string
				discoveryTriggererConfig?: {
					[string]: string
				}
			}
			sourceConfig?: {
				[string]: string
			}
			resources?: #Resources
			secretsMap?: {
				[string]: {
					path: string
					key:  string
				}
			}
			processingGuarantee?:          *"atleast_once" | "atmost_once" | "effectively_once"
			runtimeFlags?:                 string
			volumeMounts?:                 #VolumeMounts
			forwardSourceMessageProperty?: *true | bool
			pod?:                          #Pod
			pulsar?:                       #Pulsar
			javaRuntimeConfig?:            #JavaRuntime
			imagePullPolicy?:              "Always" | "Never" | *"IfNotPresent"
			statefulConfig?:               #StatefulConfig
		}

		#Pod: {
			labels?: {
				[string]: string
			}
			nodeSelector?: {
				[string]: string
			}
			affinity?: {
				nodeAffinity?: {
					requiredDuringSchedulingIgnoredDuringExecution?: {
						nodeSelectorTerms?: [...{
							matchExpressions?: [...#LabelSelectorRequirement]
							matchFields?: [...#LabelSelectorRequirement]
						}]
					}
					preferredDuringSchedulingIgnoredDuringExecution?: [...#PreferredSchedulingTerm]
				}
				podAffinity?: {
					requiredDuringSchedulingIgnoredDuringExecution?: [...#PodAffinityTerm]
					preferredDuringSchedulingIgnoredDuringExecution?: [...#WeightedPodAffinityTerm]
				}
				podAntiAffinity?: {
					requiredDuringSchedulingIgnoredDuringExecution?: [...#PodAffinityTerm]
					preferredDuringSchedulingIgnoredDuringExecution?: [...#WeightedPodAffinityTerm]
				}
			}
			tolerations?: [...{
				key?:               string
				operator?:          "Exists" | "Equal"
				value?:             string
				effect?:            "NoSchedule" | "PreferNoSchedule" | "NoExecute"
				tolerationSeconds?: int
			}]
			annotations?: {
				[string]: string
			}
			securityContext?: {
				seLinuxOptions?: {
					user?:  string
					role?:  string
					type?:  string
					level?: string
				}
				windowsOptions?: {
					gmsaCredentialSpecName?: string
					gmsaCredentialSpec?:     string
					runAsUserName?:          string
					hostProcess?:            string
				}
				runAsUser?:    int
				runAsGroup?:   int
				runAsNonRoot?: bool
				supplementalGroups?: [...int]
				fsGroup?: int
				sysctls?: [...{
					name:  string
					value: string
				}]
				fsGroupChangePolicy?: "OnRootMismatch" | *"Always"
				seccompProfile?: {
					type:              string
					localhostProfile?: string
				}
			}
			terminationGracePeriodSeconds?: int
			imagePullSecrets?: [...{
				name?: string
			}]
			initContainers?: [...#Container]
			sidecars?: [...#Container]
			serviceAccountName?: string
			builtinAutoscaler?: [...#BuiltinHPARule]
			autoScalingBehavior?: {
				scaleUp?: {
					stabilizationWindowSeconds?: int
					selectPolicy?:               *"Max" | "Min" | "Disabled"
					policies?: [...{
						type:          "Pods" | "Percent"
						value:         int
						periodSeconds: int
					}]
				}
			}
			vpa?: {
				updatePolicy?: {
					updateMode?:  "Off" | "Initial" | "Recreate" | *"Auto"
					minReplicas?: int
				}
				resourcePolicy?: {
					containerPolicies?: [...{
						containerName?: string
						mode?:          *"Auto" | "Off"
						minAllowed?:    string
					}]
				}
			}
		}

		#LabelSelectorRequirement: {
			key?:      string
			operator?: "In" | "NotIn" | "Exists" | "DoesNotExist"
			values?: [...string]
		}

		#NodeSelectorRequirement: {
			key?:      string
			operator?: "In" | "NotIn" | "Exists" | "DoesNotExist" | "Gt" | "Lt"
			values?: [...string]
		}

		#WeightedPodAffinityTerm: {
			weight?:          int
			podAffinityTerm?: #PodAffinityTerm
		}

		#PreferredSchedulingTerm: {
			weight?: int
			preference?: {
				matchExpressions?: [...#NodeSelectorRequirement]
				matchFields?: [...#NodeSelectorRequirement]
			}
		}

		#PodAffinityTerm: {
			labelSelector?: {
				matchLabels?: {
					[string]: string
				}
				matchExpressions?: [...#LabelSelectorRequirement]
			}
			namespaces?: [...string]
			topologyKey?: string
			namespaceSelector?: {
				matchLabels?: {
					[string]: string
				}
				matchExpressions?: [...#LabelSelectorRequirement]
			}
		}

		#Container: {
			name:   string
			image?: string
			command?: [...string]
			args?: [...string]
			env?: [...{
				name:  string
				value: string
			}]
			volumeMounts?: [...{
				name:      string
				readOnly?: bool
				mountPath: string
				subPath?:  string
			}]
			imagePullPolicy?: *"IfNotPresent" | "Always" | "Never"
		}

		#RuntimeLog: {
			level?:        "off" | "trace" | "debug" | "info" | "warn" | "error" | "fatal" | "all" | "panic"
			rotatePolicy?: "TimedPolicyWithDaily" | "TimedPolicyWithWeekly" | "TimedPolicyWithMonthly" | "SizedPolicyWith10MB" | "SizedPolicyWith50MB" | "SizedPolicyWith100MB"
			logConfig?: {
				name?: string
				key?:  string
			}
		}

		#Pulsar: {
			pulsarConfig?: string
			authSecret?:   string
			tlsSecret?:    string
			tlsConfig?: {
				enabled?:              bool
				allowInsecure?:        bool
				hostnameVerification?: bool
				certSecretName?:       string
				certSecretKey?:        string
			}
			authConfig?: {
				oauth2Config?: {
					audience:      string
					issuerUrl:     string
					scope?:        string
					keySecretName: string
					keySecretKey:  string
				}
			}
		}

		#Input: {
			typeClassName?: string
			topics: [...string]
			topicPattern?: string
			customSerdeSources?: {
				[string]: string
			}
			customSchemaSources?: {
				[string]: string
			}
		}

		#Output: {
			typeClassName?:      string
			topic:               string
			sinkSerdeClassName?: string
			sinkSchemaType?:     string
			customSchemaSinks?: {
				[string]: string
			}
		}

		#Resources: {
			requests?: cpu:    *"0.1" | =~"^([1-9][0-9]{0,63})(E|P|T|G|M|K|Ei|Pi|Ti|Gi|Mi|Ki)$"
			requests?: memory: *"500M" | =~"^([1-9][0-9]{0,63})(E|P|T|G|M|K|Ei|Pi|Ti|Gi|Mi|Ki)$"
			limits?: cpu:      *"0.5" | =~"^([1-9][0-9]{0,63})(E|P|T|G|M|K|Ei|Pi|Ti|Gi|Mi|Ki)$"
			limits?: memory:   *"1G" | =~"^([1-9][0-9]{0,63})(E|P|T|G|M|K|Ei|Pi|Ti|Gi|Mi|Ki)$"
		}

		#JavaRuntime: {
			jar?:                  string
			jarLocation?:          string
			className:             string
			extraDependenciesDir?: string
			options?: [...string]
			log?: #RuntimeLog
		}

		#PythonRuntime: {
			py:          string
			pyLocation?: string
			log?:        #RuntimeLog
		}

		#GolangRuntime: {
			go:          string
			goLocation?: string
			log?:        #RuntimeLog
		}

		#VolumeMounts: [...{
			name:              string
			readOnly?:         bool
			mountPath:         string
			subPath?:          string
			mountPropagation?: *"None" | "HostToContainer" | "Bidirectional"
			subPathExpr?:      string
		}]

		#StatefulConfig: {
			pulsar?: {
				serviceUrl: string
				javaProvider?: {
					className: string
					config?: {
						[string]: string
					}
				}
			}
		}

		#BuiltinHPARule: "AverageUtilizationCPUPercent80" | "AverageUtilizationCPUPercent50" | "AverageUtilizationCPUPercent20" | "AverageUtilizationMemoryPercent80" | "AverageUtilizationMemoryPercent50" | "AverageUtilizationMemoryPercent20"
	}

	output: {
		apiVersion: "compute.functionmesh.io/v1alpha1"
		kind:       "FunctionMesh"
		metadata: name: context.name
		spec: {
			if parameter.sources != _|_ {
				sources: [
					for k, v in parameter.sources {
						name:        v.name
						image:       v.image
						minReplicas: v.minReplicas
						output:      v.output
						java:        _ & v.javaRuntimeConfig
						pulsar:      _ & v.pulsar
						className:   v.javaRuntimeConfig.className
						if v.clusterName != _|_ {
							clusterName: v.clusterName
						}
						if v.tenant != _|_ {
							tenant: v.tenant
						}
						if v.namespace != _|_ {
							namespace: v.namespace
						}
						if v.sourceType != _|_ {
							sourceType: v.sourceType
						}
						if v.replicas != _|_ {
							replicas: v.replicas
						}
						if v.maxReplicas != _|_ {
							maxReplicas: v.maxReplicas
						}
						if v.downloaderImage != _|_ {
							downloaderImage: v.downloaderImage
						}
						if v.batchSourceConfig != _|_ {
							batchSourceConfig: _ & v.batchSourceConfig
						}
						if v.sourceConfig != _|_ {
							sourceConfig: v.sourceConfig
						}
						if v.resources != _|_ {
							resources: _ & v.resources
						}
						if v.secretsMap != _|_ {
							secretsMap: _ & v.secretsMap
						}
						if v.processingGuarantee != _|_ {
							processingGuarantee: v.processingGuarantee
						}
						if v.forwardSourceMessageProperty != _|_ {
							forwardSourceMessageProperty: v.forwardSourceMessageProperty
						}
						if v.runtimeFlags != _|_ {
							runtimeFlags: v.runtimeFlags
						}
						if v.imagePullPolicy != _|_ {
							imagePullPolicy: v.imagePullPolicy
						}
						if v.statefulConfig != _|_ {
							statefulConfig: _ & v.statefulConfig
						}
						if v.volumeMounts != _|_ {
							volumeMounts: _ & v.volumeMounts
						}
						if v.pod != _|_ {
							pod: _ & v.pod
						}
					},
				]
			}
			if parameter.functions != _|_ {
				functions: [
					for k, v in parameter.functions {
						name:        v.name
						image:       v.image
						minReplicas: v.minReplicas
						logTopic:    v.logTopic
						input:       v.input
						output:      v.output
						pulsar:      _ & v.pulsar
						if v.maxPendingAsyncRequests != _|_ {
							maxPendingAsyncRequests: v.maxPendingAsyncRequests
						}
						if v.replicas != _|_ {
							replicas: v.replicas
						}
						if v.maxReplicas != _|_ {
							maxReplicas: v.maxReplicas
						}
						if v.resources != _|_ {
							resources: _ & v.resources
						}
						if v.secretsMap != _|_ {
							secretsMap: _ & v.secretsMap
						}
						if v.timeout != _|_ {
							timeout: v.timeout
						}
						if v.autoAck != _|_ {
							autoAck: v.autoAck
						}
						if v.maxMessageRetry != _|_ {
							maxMessageRetry: v.maxMessageRetry
						}
						if v.processingGuarantee != _|_ {
							processingGuarantee: v.processingGuarantee
						}
						if v.retainKeyOrdering != _|_ {
							retainKeyOrdering: v.retainKeyOrdering
						}
						if v.retainOrdering != _|_ {
							retainOrdering: v.retainOrdering
						}
						if v.deadLetterTopic != _|_ {
							deadLetterTopic: v.deadLetterTopic
						}
						if v.forwardSourceMessageProperty != _|_ {
							forwardSourceMessageProperty: v.forwardSourceMessageProperty
						}
						if v.runtimeFlags != _|_ {
							runtimeFlags: v.runtimeFlags
						}
						if v.subscriptionName != _|_ {
							subscriptionName: v.subscriptionName
						}
						if v.cleanupSubscription != _|_ {
							cleanupSubscription: v.cleanupSubscription
						}
						if v.subscriptionPosition != _|_ {
							subscriptionPosition: v.subscriptionPosition
						}
						if v.javaRuntimeConfig != _|_ {
							java:      _ & v.javaRuntimeConfig
							className: v.javaRuntimeConfig.className
						}
						if v.pythonRuntimeConfig != _|_ {
							python:    _ & v.pythonRuntimeConfig
							className: v.pythonRuntimeConfig.className
						}
						if v.golangRuntimeConfig != _|_ {
							golang: _ & v.golangRuntimeConfig
						}
						if v.imagePullPolicy != _|_ {
							imagePullPolicy: v.imagePullPolicy
						}
						if v.statefulConfig != _|_ {
							statefulConfig: _ & v.statefulConfig
						}
						if v.funcConfig != _|_ {
							funcConfig: v.funcConfig
						}
						if v.volumeMounts != _|_ {
							volumeMounts: _ & v.volumeMounts
						}
						if v.windowConfig != _|_ {
							windowConfig: _ & v.windowConfig
						}
						if v.pod != _|_ {
							pod: _ & v.pod
						}
					},
				]
			}
			if parameter.sinks != _|_ {
				sinks: [
					for k, v in parameter.sinks {
						name:        v.name
						image:       v.image
						minReplicas: v.minReplicas
						input:       v.input
						java:        _ & v.javaRuntimeConfig
						className:   v.javaRuntimeConfig.className
						pulsar:      _ & v.pulsar
						if v.clusterName != _|_ {
							clusterName: v.clusterName
						}
						if v.tenant != _|_ {
							tenant: v.tenant
						}
						if v.namespace != _|_ {
							namespace: v.namespace
						}
						if v.sinkType != _|_ {
							sinkType: v.sinkType
						}
						if v.replicas != _|_ {
							replicas: v.replicas
						}
						if v.maxReplicas != _|_ {
							maxReplicas: v.maxReplicas
						}
						if v.downloaderImage != _|_ {
							downloaderImage: v.downloaderImage
						}
						if v.sinkConfig != _|_ {
							sinkConfig: v.sinkConfig
						}
						if v.resources != _|_ {
							resources: _ & v.resources
						}
						if v.secretsMap != _|_ {
							secretsMap: _ & v.secretsMap
						}
						if v.processingGuarantee != _|_ {
							processingGuarantee: v.processingGuarantee
						}
						if v.timeout != _|_ {
							timeout: v.timeout
						}
						if v.autoAck != _|_ {
							autoAck: v.autoAck
						}
						if v.negativeAckRedeliveryDelayMs != _|_ {
							negativeAckRedeliveryDelayMs: v.negativeAckRedeliveryDelayMs
						}
						if v.maxMessageRetry != _|_ {
							maxMessageRetry: v.maxMessageRetry
						}
						if v.retainOrdering != _|_ {
							retainOrdering: v.retainOrdering
						}
						if v.deadLetterTopic != _|_ {
							deadLetterTopic: v.deadLetterTopic
						}
						if v.runtimeFlags != _|_ {
							runtimeFlags: v.runtimeFlags
						}
						if v.subscriptionName != _|_ {
							subscriptionName: v.subscriptionName
						}
						if v.cleanupSubscription != _|_ {
							cleanupSubscription: v.cleanupSubscription
						}
						if v.subscriptionPosition != _|_ {
							subscriptionPosition: v.subscriptionPosition
						}
						if v.imagePullPolicy != _|_ {
							imagePullPolicy: v.imagePullPolicy
						}
						if v.statefulConfig != _|_ {
							statefulConfig: _ & v.statefulConfig
						}
						if v.volumeMounts != _|_ {
							volumeMounts: _ & v.volumeMounts
						}
						if v.pod != _|_ {
							pod: _ & v.pod
						}
					},
				]
			}
		}
	}
}
