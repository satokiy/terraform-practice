module "vpc" {
  source = "../../modules/vpc"
}

module "alb" {
  source            = "../../modules/alb"
  public_subnet_ids = module.vpc.public_subnet_ids
  vpc_id            = module.vpc.vpc_id
}

module "ecs" {
  source               = "../../modules/ecs"
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  alb_target_group_arn = module.alb.alb_target_group_arn
  ecs_listener_rule    = module.alb.alb_listener_rule
}

module "acm" {
  source      = "../../modules/acm"
  domain = var.domain
  route53_validation_record = module.route53.route53_validation_record
}

module "route53" {
  source          = "../../modules/route53"
  domain     = var.domain
  aws_acm_certificate = module.acm.acm_certificate
  aws_alb_main_zone_id = module.alb.aws_alb_main_zone_id
  aws_alb_main_dns_name = module.alb.aws_alb_main_dns_name
}