// main template for gatekeeper
local kap = import 'lib/kapitan.libjsonnet';
local kube = import 'lib/kube.libjsonnet';
local inv = kap.inventory();
// The hiera parameters for the component
local params = inv.parameters.gatekeeper;

local namespace = kube.Namespace(params.namespace.name) {
  metadata+: {
    annotations+: params.namespace.annotations,
    labels+: params.namespace.labels,
  },
};

// Define outputs below
{
  '10_namespace': namespace,
}
