"functions": {
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
		// +usage=Function image.
		image:                    string
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
		pulsar:                        #Pulsar
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
			pulsarConfig: string
			authSecret?:  string
			tlsSecret?:   string
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
		kind:       "Function"
		metadata: name: context.name
		spec: {
			image:       parameter.image
			minReplicas: parameter.minReplicas
			logTopic:    parameter.logTopic
			input:       parameter.input
			output:      parameter.output
			pulsar:      _ & parameter.pulsar
			if parameter.maxPendingAsyncRequests != _|_ {
				maxPendingAsyncRequests: parameter.maxPendingAsyncRequests
			}
			if parameter.replicas != _|_ {
				replicas: parameter.replicas
			}
			if parameter.maxReplicas != _|_ {
				maxReplicas: parameter.maxReplicas
			}
			if parameter.resources != _|_ {
				resources: _ & parameter.resources
			}
			if parameter.secretsMap != _|_ {
				secretsMap: _ & parameter.secretsMap
			}
			if parameter.timeout != _|_ {
				timeout: parameter.timeout
			}
			if parameter.autoAck != _|_ {
				autoAck: parameter.autoAck
			}
			if parameter.maxMessageRetry != _|_ {
				maxMessageRetry: parameter.maxMessageRetry
			}
			if parameter.processingGuarantee != _|_ {
				processingGuarantee: parameter.processingGuarantee
			}
			if parameter.retainKeyOrdering != _|_ {
				retainKeyOrdering: parameter.retainKeyOrdering
			}
			if parameter.retainOrdering != _|_ {
				retainOrdering: parameter.retainOrdering
			}
			if parameter.deadLetterTopic != _|_ {
				deadLetterTopic: parameter.deadLetterTopic
			}
			if parameter.forwardSourceMessageProperty != _|_ {
				forwardSourceMessageProperty: parameter.forwardSourceMessageProperty
			}
			if parameter.runtimeFlags != _|_ {
				runtimeFlags: parameter.runtimeFlags
			}
			if parameter.subscriptionName != _|_ {
				subscriptionName: parameter.subscriptionName
			}
			if parameter.cleanupSubscription != _|_ {
				cleanupSubscription: parameter.cleanupSubscription
			}
			if parameter.subscriptionPosition != _|_ {
				subscriptionPosition: parameter.subscriptionPosition
			}
			if parameter.javaRuntimeConfig != _|_ {
				java:      _ & parameter.javaRuntimeConfig
				className: parameter.javaRuntimeConfig.className
			}
			if parameter.pythonRuntimeConfig != _|_ {
				python:    _ & parameter.pythonRuntimeConfig
				className: parameter.pythonRuntimeConfig.className
			}
			if parameter.golangRuntimeConfig != _|_ {
				golang: _ & parameter.golangRuntimeConfig
			}
			if parameter.imagePullPolicy != _|_ {
				imagePullPolicy: parameter.imagePullPolicy
			}
			if parameter.statefulConfig != _|_ {
				statefulConfig: _ & parameter.statefulConfig
			}
			if parameter.funcConfig != _|_ {
				funcConfig: _ & parameter.funcConfig
			}
			if parameter.volumeMounts != _|_ {
				volumeMounts: _ & parameter.volumeMounts
			}
			if parameter.windowConfig != _|_ {
				windowConfig: _ & parameter.windowConfig
			}
			if parameter.pod != _|_ {
				pod: _ & parameter.pod
			}
		}
	}
}
