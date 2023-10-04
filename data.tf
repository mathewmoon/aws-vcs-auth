data "aws_iam_openid_connect_provider" "provided" {
  count = var.oidc_provider_arn != null ? 1 : 0

  arn = var.oidc_provider_arn

  lifecycle {
    precondition {
      condition     = length(compact([var.managed_provider, var.oidc_provider_arn, var.provider_config != null ? "provider_config" : null])) == 1
      error_message = "You must use exactly one of managed_provider, oidc_provider_arn or provider_config inputs"
    }
  }
}

data "tls_certificate" "this" {
  url = local.oidc_config.url

  lifecycle {
    postcondition {
      condition     = var.oidc_provider_arn != null || replace(reverse(self.certificates)[0].subject, "/(.*CN=)|(,.*)/", "") == local.oidc_config.common_name
      error_message = "Subject returned for certificate doesn't match validation"
    }
  }
}
