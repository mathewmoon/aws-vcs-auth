variable "managed_provider" {
  description = <<EOT
    Use preconfigured OIDC provider for supported services. Currently only supports hosted Gitlab and Github. Fingerprints are statically coded in the mode
    and will need to be kept up over time as they are rotated. This is the tradeoff
EOT
  type        = string
  default     = null

  validation {
    condition     = var.managed_provider == null || contains(["github", "gitlab"], var.managed_provider)
    error_message = "Must be one of `github` or `gitlab`"
  }
}

variable "oidc_provider_arn" {
  description = "The ARN of an existing OIDC provider to use"
  type        = string
  default     = null
}

variable "provider_config" {
  description = "Configuration for a custom provider"
  type = object({
    url             = string
    thumbprint_list = list(string)
    client_id_list  = list(string)
    subject         = string
  })
  default = null
}

variable "oidc_provider_tags" {
  description = "Tags to add to the OIDC provider"
  type        = map(string)
  default     = {}
}

variable "refs" {
  description = <<EOT
    The Git refs that should be allowed to assume the role. These vary by the VCS provider and how you want to limit access. Examples:

    `repo:foo/bar:*` will allow all branches/tags in the repo `bar` that belongs to the `foo` org in Github to assume the role. Changing to
    `repo:foo/bar:ref:refs/heads/main` will lock it down to only the `main` branch.

    Note that Gitlab and Github have their own syntax for refs. See the following documents for how to configure refs for Gitlab and Github:

    https://docs.gitlab.com/ee/ci/cloud_services/aws/#configure-a-role-and-trust
    https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services

EOT
  type        = list(string)
}

variable "additional_client_ids" {
  description = "A list of additional client ID's to add to the provider"
  type        = list(string)
  default     = []
}
