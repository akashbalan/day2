data "template_file" "frontend_user_data" {
  template = file("${path.module}/frontend-user-data.sh.tmpl")

  vars = {
    backend_alb_dns = module.back_end_alb.dns_name
  }
}
