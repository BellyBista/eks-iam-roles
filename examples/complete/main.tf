module "eks-iam-roles" {
  source    = "../../"
  pgp_key   = var.pgp_key
  region    = var.region
  developer = var.developer
  admin     = var.admin

}
