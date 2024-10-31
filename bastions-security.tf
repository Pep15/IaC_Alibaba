resource "alicloud_security_group" "Allow" {
  name        = "Alow-ssh"
  description = "security group"
  vpc_id      = alicloud_vpc.vpc1.id
}
resource "alicloud_security_group_rule" "allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.Allow.id
  cidr_ip           = "0.0.0.0/0"
}