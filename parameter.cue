package main

parameter: {
		//+usage=Deploy to specified clusters. Leave empty to deploy to all clusters.
		clusters?: [...string]
		//+usage=Namespace to deploy to, defaults to function-mesh
		namespace: *"function-mesh" | string
}