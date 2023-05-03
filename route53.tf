resource "aws_route53_zone" "zone53" {
  name = "somesampleaddress.com"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.zone53.zone_id
  name    = "www.somesampleaddress.com"
  type    = "A"
  
  alias {
    name                   = aws_lb.loadbalancer.dns_name
    zone_id                = aws_lb.loadbalancer.zone_id
    evaluate_target_health = true
  }
}