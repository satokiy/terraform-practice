module "vpc" {
  source = "./modules/vpc"
}

module "alb" {
  source                     = "./modules/alb"
  public_subnet_ids = module.vpc.public_subnet_ids
  vpc_id            = module.vpc.vpc_id
}