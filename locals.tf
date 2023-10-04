locals {
  providers = {
    github = {
      url            = "https://token.actions.githubusercontent.com"
      client_id_list = flatten(["sts.amazonaws.com", var.additional_client_ids])
      common_name    = "*.actions.githubusercontent.com"
    }
    gitlab = {
      url            = "https://gitlab.com"
      client_id_list = flatten(["sts.amazonaws.com", var.additional_client_ids])
      common_name    = "about.gitlab.com"
    }
    custom = var.provider_config != null ? {
      url             = var.provider_config.url
      thumbprint_list = var.provider_config.thumbprint_list
      client_id_list  = concat(var.provider_config.client_id_list, var.additional_client_ids)
      common_name     = var.provider_config.common_name
    } : null
    existing = var.oidc_provider_arn != null ? {
      url             = data.aws_iam_openid_connect_provider.provided[0].url
      thumbprint_list = data.aws_iam_openid_connect_provider.provided[0].thumbprint_list
      client_id_list  = data.aws_iam_openid_connect_provider.provided[0].client_id_list
    } : null
  }

  provider_name = var.managed_provider != null ? var.managed_provider : var.provider_config != null ? "custom" : "existing"
  oidc_config   = local.providers[local.provider_name]

  oidc_provider_arn = var.oidc_provider_arn != null ? var.oidc_provider_arn : aws_iam_openid_connect_provider.this[0].arn
  oidc_hostname     = replace(local.oidc_config.url, "/http(s)?:\\/\\//", "")
  cert              = reverse(data.tls_certificate.this.certificates)[0]
  common_name       = replace(local.cert.subject, "/(.*CN=)|(,.*)/", "")
}
