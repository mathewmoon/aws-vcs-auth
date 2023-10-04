<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.19.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_openid_connect_provider.provided](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_openid_connect_provider) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [tls_certificate.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_client_ids"></a> [additional\_client\_ids](#input\_additional\_client\_ids) | A list of additional client ID's to add to the provider | `list(string)` | `[]` | no |
| <a name="input_managed_provider"></a> [managed\_provider](#input\_managed\_provider) | Use preconfigured OIDC provider for supported services. Currently only supports hosted Gitlab and Github. Fingerprints are statically coded in the mode<br>    and will need to be kept up over time as they are rotated. This is the tradeoff | `string` | `null` | no |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | The ARN of an existing OIDC provider to use | `string` | `null` | no |
| <a name="input_oidc_provider_tags"></a> [oidc\_provider\_tags](#input\_oidc\_provider\_tags) | Tags to add to the OIDC provider | `map(string)` | `{}` | no |
| <a name="input_provider_config"></a> [provider\_config](#input\_provider\_config) | Configuration for a custom provider | <pre>object({<br>    url             = string<br>    thumbprint_list = list(string)<br>    client_id_list  = list(string)<br>  })</pre> | `null` | no |
| <a name="input_refs"></a> [refs](#input\_refs) | The Git refs that should be allowed to assume the role. These vary by the VCS provider and how you want to limit access. Examples:<br><br>    `repo:foo/bar:*` will allow all branches/tags in the repo `bar` that belongs to the `foo` org in Github to assume the role. Changing to<br>    `repo:foo/bar:ref:refs/heads/main` will lock it down to only the `main` branch.<br><br>    Note that Gitlab and Github have their own syntax for refs. See the following documents for how to configure refs for Gitlab and Github:<br><br>    https://docs.gitlab.com/ee/ci/cloud_services/aws/#configure-a-role-and-trust<br>    https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services | `list(string)` | n/a | yes |
| <a name="input_validate_subject"></a> [validate\_subject](#input\_validate\_subject) | If set to a non empty value, then the Common Name in the IdP's certificate's subject will be validated to<br>    match the input. Use only the expected name, and not the `CN=` prefix, `OU` or any other identifiers. An example<br>    for Github would be `*.actions.githubusercontent.com` | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_assume_role_json"></a> [assume\_role\_json](#output\_assume\_role\_json) | An assume role policy output as JSON to be used when creating a role that can be assumed by a client validated by a JWT<br>    signed by the IdP |
| <a name="output_cert"></a> [cert](#output\_cert) | The CA cert of the IP as returned by the IdP's url |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | The AWS ARN for the IAM OIDC Provider |
| <a name="output_oidc_provider_thumbprints"></a> [oidc\_provider\_thumbprints](#output\_oidc\_provider\_thumbprints) | The thumbprints of the certificate used by the IdP |
| <a name="output_oidc_url"></a> [oidc\_url](#output\_oidc\_url) | The url used to by the IdP |
| <a name="output_subject_common_name"></a> [subject\_common\_name](#output\_subject\_common\_name) | The CN of the subject provided by the IdP's certificate |
<!-- END_TF_DOCS -->