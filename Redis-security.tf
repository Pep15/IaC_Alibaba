resource "alicloud_security_group" "Allow-ssh-to-bastions" {
  name        = "Allow-ssh"
  description = "security group"
  vpc_id      = alicloud_vpc.vpc1.id
}
resource "alicloud_security_group_rule" "allow_ssh-to-bastions" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.Allow-ssh-to-bastions.id
  source_security_group_id = alicloud_security_group.Allow.id
}

resource "alicloud_security_group" "Allow-http-to-bastions" {
  name        = "Alow-http"
  description = "security group"
  vpc_id      = alicloud_vpc.vpc1.id
}
resource "alicloud_security_group_rule" "allow_http-to-bastions" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "6379/6379"
  priority          = 1
  security_group_id = alicloud_security_group.Allow-http-to-bastions.id
  source_security_group_id = alicloud_security_group.Allow.id
}