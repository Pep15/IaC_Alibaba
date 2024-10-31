resource "alicloud_nlb_load_balancer" "Loadhttp" {
  load_balancer_name = "Load-http"
  load_balancer_type = "Network"
  address_type       = "Internet"
  address_ip_version = "Ipv4"
  vpc_id             = alicloud_vpc.vpc1.id

  zone_mappings {
    vswitch_id = alicloud_vswitch.public-a.id
    zone_id    = data.alicloud_zones.availability_zones.zones.0.id
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.public-b.id
    zone_id    = data.alicloud_zones.availability_zones.zones.1.id
  }
}

output "URL_LOADBALANCE_WWWW"{
    value = alicloud_nlb_load_balancer.Loadhttp.dns_name
   
}

output "STATUS_OF_LOAD_"{
    value = alicloud_nlb_load_balancer.Loadhttp.status
}

resource "alicloud_nlb_server_group" "GroupOfHttp" {
  server_group_name        = "Http"
  server_group_type        = "Instance"
  vpc_id                   = alicloud_vpc.vpc1.id
  scheduler                = "rr"
  protocol                 = "TCP"
  connection_drain_enabled = true
  connection_drain_timeout = 60
  address_ip_version       = "Ipv4"
  health_check {
    health_check_enabled         = true
    health_check_type            = "TCP"
    health_check_connect_port    = 0
    healthy_threshold            = 2
    unhealthy_threshold          = 2
    health_check_connect_timeout = 5
    health_check_interval        = 10
    http_check_method            = "GET"
    health_check_http_code       = ["http_2xx", "http_3xx", "http_4xx"]
 
}
}

resource "alicloud_nlb_server_group_server_attachment" "GroupNLB" {
  count = length(alicloud_instance.http)
  server_type     = "Ecs"
  port            = 80
  server_group_id = alicloud_nlb_server_group.GroupOfHttp.id
  server_id       = alicloud_instance.http[count.index].id
  weight          = 100
 
}

resource "alicloud_nlb_listener" "ListenerHttp" {
  listener_protocol      = "TCP"
  listener_port          = "80"
  listener_description   = "Lestener-http"
  load_balancer_id       = alicloud_nlb_load_balancer.Loadhttp.id
  server_group_id        = alicloud_nlb_server_group.GroupOfHttp.id
  idle_timeout           = "900"
  proxy_protocol_enabled = "false"
  cps                    = "0"
  mss                    = "0"
}