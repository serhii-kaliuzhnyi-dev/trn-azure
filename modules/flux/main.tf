data "github_repository" "existing_repo" {
  full_name = "serhii-kaliuzhnyi-dev/go-server-canary"
}

resource "kubernetes_namespace" "flux_system" {
  metadata {
    name = "flux-system"
  }
}

resource "kubernetes_namespace" "application" {
  metadata {
    name = "application"
  }
}

resource "tls_private_key" "flux" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "kubernetes_secret" "flux_github_deploy" {
  metadata {
    name      = "flux-git-deploy"
    namespace = kubernetes_namespace.flux_system.metadata[0].name
  }
  data = {
    identity    = tls_private_key.flux.private_key_pem
    "identity.pub" = tls_private_key.flux.public_key_openssh
    "known_hosts"  = "github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg="
  }
  type = "Opaque"
}


resource "github_repository_deploy_key" "this" {
  title      = "Flux Deploy Key"
  repository = data.github_repository.existing_repo.name
  key        = tls_private_key.flux.public_key_openssh
  read_only  = false
}

resource "helm_release" "flux2" {
  name       = "flux2"
  repository = "https://fluxcd-community.github.io/helm-charts"
  chart      = "flux2"
  version    = "2.13.0"
  namespace  = kubernetes_namespace.flux_system.metadata[0].name

  depends_on = [kubernetes_namespace.flux_system]
}

resource "helm_release" "flux2_sync" {
  name       = "flux2-sync"
  repository = "https://fluxcd-community.github.io/helm-charts"
  chart      = "flux2-sync"
  version    = "1.9.0"
  namespace  = kubernetes_namespace.flux_system.metadata[0].name

  set {
    name  = "gitRepository.spec.url"
    value = "ssh://git@github.com/serhii-kaliuzhnyi-dev/go-server-canary.git"
  }

  set {
    name  = "gitRepository.spec.ref.branch"
    value = data.github_repository.existing_repo.default_branch
  }

  set {
    name  = "gitRepository.spec.secretRef.name"
    value = kubernetes_secret.flux_github_deploy.metadata[0].name
  }

  set {
    name  = "gitRepository.spec.interval"
    value = "1m"
  }

  depends_on = [helm_release.flux2, kubernetes_secret.flux_github_deploy]
}

resource "helm_release" "flux2_sync_canary" {
  name       = "flux2-sync-canary"
  repository = "https://fluxcd-community.github.io/helm-charts"
  chart      = "flux2-sync"
  version    = "1.9.0"
  namespace  = kubernetes_namespace.flux_system.metadata[0].name

  set {
    name  = "gitRepository.spec.url"
    value = "ssh://git@github.com/serhii-kaliuzhnyi-dev/go-server-canary.git"
  }

  set {
    name  = "gitRepository.spec.ref.branch"
    value = "canary"
  }

  set {
    name  = "gitRepository.spec.secretRef.name"
    value = kubernetes_secret.flux_github_deploy.metadata[0].name
  }

  set {
    name  = "gitRepository.spec.interval"
    value = "1m"
  }

  depends_on = [helm_release.flux2, kubernetes_secret.flux_github_deploy]
}

resource "kubernetes_secret" "acr_secret" {
  depends_on = [kubernetes_namespace.application]

  metadata {
    name      = "acr-secret"
    namespace = "application"
  }

  data = {
    ".dockerconfigjson" = base64encode(jsonencode({
      auths = {
        "${var.acr_login_server}" = {
          username = var.acr_admin_username
          password = var.acr_admin_password
          email    = "not@val.id"
        }
      }
    }))
  }

  type = "kubernetes.io/dockerconfigjson"
}