output "oidc_url" {
  description = "The url used to by the IdP"
  value       = local.oidc_config.url
}

output "oidc_provider_thumbprints" {
  description = "The thumbprints of the certificate used by the IdP"
  value       = var.oidc_provider_arn != null ? data.aws_iam_openid_connect_provider.provided[0].thumbprint_list : aws_iam_openid_connect_provider.this[0].thumbprint_list
}

output "oidc_provider_arn" {
  description = "The AWS ARN for the IAM OIDC Provider"
  value       = local.oidc_provider_arn
}

output "assume_role_json" {
  description = <<EOT
    An assume role policy output as JSON to be used when creating a role that can be assumed by a client validated by a JWT
    signed by the IdP
EOT
  value       = data.aws_iam_policy_document.assume_role.json
}

output "cert" {
  description = "The CA cert of the IP as returned by the IdP's url"
  value       = local.cert
}

output "subject_common_name" {
  description = "The CN of the subject provided by the IdP's certificate"
  value       = local.common_name
}