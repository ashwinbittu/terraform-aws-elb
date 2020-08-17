resource "aws_elb" "my-elb" {
  name            = "${var.app_name}-elb"
  subnets         = var.aws_subnet_ids
  security_groups = var.aws_security_group_elb_id
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = var.lb_ssl_id
  }  
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 10
  }
  
  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "${var.app_name}-elb"
    environment  = var.app_env
    appname = var.app_name
    csiappid = var.app_csi
  }
}
