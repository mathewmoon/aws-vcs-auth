resource "aws_iam_openid_connect_provider" "this" {
  count = var.oidc_provider_arn == null ? 1 : 0

  url             = local.oidc_config.url
  client_id_list  = local.oidc_config.client_id_list
  thumbprint_list = var.provider_config != null ? var.provider_config.thumbprint_list : [local.cert.sha1_fingerprint]

  tags = var.oidc_provider_tags

  lifecycle {
    precondition {
      condition     = length(compact([var.managed_provider, var.oidc_provider_arn, var.provider_config != null ? "provider_config" : null])) == 1
      error_message = "You must use exactly one of managed_provider, oidc_provider_arn or provider_config inputs"
    }
  }
}

data "aws_iam_policy_document" "assume_role" {
  dynamic "statement" {
    for_each = toset(var.refs)

    content {

      effect = "Allow"

      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type        = "Federated"
        identifiers = [local.oidc_provider_arn]
      }

      condition {
        test     = "StringEquals"
        variable = "${local.oidc_hostname}:sub"
        values   = [statement.value]
      }

      condition {
        test     = "StringEquals"
        variable = "${local.oidc_hostname}:aud"
        values   = local.oidc_config.client_id_list
      }
    }

  }
}
