data "github_repository" "repo" {
  name = var.repository_name
}

resource "github_actions_secret" "acr_login_server" {
  repository      = data.github_repository.repo.name
  secret_name     = "ACR_LOGIN_SERVER"
  plaintext_value = var.acr_login_server
}

resource "github_actions_secret" "acr_username" {
  repository      = data.github_repository.repo.name
  secret_name     = "ACR_USERNAME"
  plaintext_value = var.acr_username
}

resource "github_actions_secret" "acr_password" {
  repository      = data.github_repository.repo.name
  secret_name     = "ACR_PASSWORD"
  plaintext_value = var.acr_password
}

resource "github_actions_secret" "azure_credentials" {
  repository      = data.github_repository.repo.name
  secret_name     = "AZURE_CREDENTIALS"
  plaintext_value = jsonencode({
    clientId       = var.client_id,
    clientSecret   = var.client_secret,
    subscriptionId = var.subscription_id,
    tenantId       = var.tenant_id
  })
}

resource "github_actions_secret" "github_token" {
  repository      = data.github_repository.repo.name
  secret_name     = "DEPLOYMENT_KEY"
  plaintext_value = var.github_token
}