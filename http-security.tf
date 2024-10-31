resource "alicloud_security_group" "Allow-ssh-http" {
  name        = "Alow-ssh"
  description = "security group"
  vpc_id      = alicloud_vpc.vpc1.id
}
resource "alicloud_security_group_rule" "allow_ssh_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.Allow-ssh-http.id
  source_security_group_id = alicloud_security_group.Allow.id
}
resource "alicloud_security_group" "Allow-http-sql" {
  name        = "Alow-ssh"
  description = "security group"
  vpc_id      = alicloud_vpc.vpc1.id
}
resource "alicloud_security_group_rule" "allow_sql_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.Allow-http-sql.id
  source_security_group_id = alicloud_security_group.Allow.id
}