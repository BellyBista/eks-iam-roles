module "eks-iam-roles" {
  source    = "../../"
  pgp_key   = var.pgp_key
  developer = var.developer
  admin     = var.admin
}