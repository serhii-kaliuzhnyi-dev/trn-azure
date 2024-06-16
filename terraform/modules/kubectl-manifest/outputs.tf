output "yaml_body_parsed" {
  value = [for r in kubectl_manifest.resource : r.yaml_body_parsed]
}

output "api_version" {
  value = [for r in kubectl_manifest.resource : r.api_version]
}

output "kind" {
  value = [for r in kubectl_manifest.resource : r.kind]
}

output "name" {
  value = [for r in kubectl_manifest.resource : r.name]
}

output "namespace" {
  value = [for r in kubectl_manifest.resource : r.namespace]
}

output "uid" {
  value = [for r in kubectl_manifest.resource : r.uid]
}

output "live_uid" {
  value = [for r in kubectl_manifest.resource : r.live_uid]
}

output "yaml_incluster" {
  value = [for r in kubectl_manifest.resource : r.yaml_incluster]
}

output "live_manifest_incluster" {
  value = [for r in kubectl_manifest.resource : r.live_manifest_incluster]
}