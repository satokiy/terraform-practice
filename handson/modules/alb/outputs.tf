output "alb_listener_rule" {
  value = aws_lb_listener_rule.main
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.main.arn
}

output "aws_alb_main_zone_id" {
    value = aws_lb.main.zone_id
}
output "aws_alb_main_dns_name" {
    value = aws_lb.main.dns_name
}