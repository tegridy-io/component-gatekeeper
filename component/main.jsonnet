// main template for gatekeeper
local kap = import 'lib/kapitan.libjsonnet';
local kube = import 'lib/kube.libjsonnet';
local com = import 'lib/commodore.libjsonnet';
local inv = kap.inventory();
// The hiera parameters for the component
local params = inv.parameters.gatekeeper;

local namespace = kube.Namespace(params.namespace.name) {
  metadata+: {
    annotations+: params.namespace.annotations,
    labels+: params.namespace.labels,
  },
};

local library = [
  std.mergePatch(
    std.parseJson(com.yaml_load('manifests/gatekeeper-library/%s/template.yaml' % name)),
    params.library[name]
  )
  for name in std.objectFields(params.library)
  if params.library[name] != null
];

// Define outputs below
{
  '00_namespace': namespace,
  [if std.length(library) > 0 then '20_library']: library,
}
