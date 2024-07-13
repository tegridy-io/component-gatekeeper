local kap = import 'lib/kapitan.libjsonnet';
local inv = kap.inventory();
local params = inv.parameters.gatekeeper;
local argocd = import 'lib/argocd.libjsonnet';

local app = argocd.App('gatekeeper', params.namespace);

{
  gatekeeper: app,
}
