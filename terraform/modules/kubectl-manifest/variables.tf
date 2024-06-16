variable "resources" {
  description = "List of Kubernetes resources to manage with kubectl_manifest"
  type = list(object({
    yaml_body          = string
    sensitive_fields   = list(string)
    force_new          = bool
    server_side_apply  = bool
    force_conflicts    = bool
    apply_only         = bool
    ignore_fields      = list(string)
    override_namespace = string
    validate_schema    = bool
    wait               = bool
    wait_for_rollout   = bool
  }))
  default = [
    {
      sensitive_fields   = ["data"]
      force_new          = false
      server_side_apply  = false
      force_conflicts    = false
      apply_only         = false
      ignore_fields      = []
      override_namespace = null
      validate_schema    = true
      wait               = false
      wait_for_rollout   = true
    }
  ]
}
