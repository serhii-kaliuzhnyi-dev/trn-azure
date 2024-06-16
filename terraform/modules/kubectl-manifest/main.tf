resource "kubectl_manifest" "resource" {
  count = length(var.resources)

  yaml_body          = var.resources[count.index].yaml_body
  sensitive_fields   = lookup(var.resources[count.index], "sensitive_fields", ["data"])
  force_new          = lookup(var.resources[count.index], "force_new", false)
  server_side_apply  = lookup(var.resources[count.index], "server_side_apply", false)
  force_conflicts    = lookup(var.resources[count.index], "force_conflicts", false)
  apply_only         = lookup(var.resources[count.index], "apply_only", false)
  ignore_fields      = lookup(var.resources[count.index], "ignore_fields", [])
  override_namespace = lookup(var.resources[count.index], "override_namespace", null)
  validate_schema    = lookup(var.resources[count.index], "validate_schema", true)
  wait               = lookup(var.resources[count.index], "wait", false)
  wait_for_rollout   = lookup(var.resources[count.index], "wait_for_rollout", true)
}