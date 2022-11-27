module "aws_user" {
  source = "github.com/ptonini/terraform-aws-iam-user"
  username = var.username
  access_key = true
  policy_statements = [
    {
      Effect = "Allow"
      Action = [
        "iam:AttachUserPolicy",
        "iam:CreateAccessKey",
        "iam:CreateUser",
        "iam:DeleteAccessKey",
        "iam:DeleteUser",
        "iam:DeleteUserPolicy",
        "iam:DetachUserPolicy",
        "iam:ListAccessKeys",
        "iam:ListAttachedUserPolicies",
        "iam:ListGroupsForUser",
        "iam:ListUserPolicies",
        "iam:PutUserPolicy",
        "iam:AddUserToGroup",
        "iam:RemoveUserFromGroup"
      ]
      Resource = ["arn:aws:iam::*:user/vault-*"]
    },
    {
      Effect = "Allow"
      Action = ["sts:AssumeRole"]
      Resource = ["arn:aws:iam::*:role/*"]
    }
  ]
  providers = {
    aws = aws
  }
}

resource "vault_aws_secret_backend" "this" {
  path = var.path
  access_key = module.aws_user.access_key_id
  secret_key = module.aws_user.secret_access_key
  default_lease_ttl_seconds = var.default_lease_ttl_seconds
  max_lease_ttl_seconds = var.max_lease_ttl_seconds
}