resource "alicloud_security_group" "Allow-SQL-to-http" {
  name        = "Allow-ssh"
  description = "security group"
  vpc_id      = alicloud_vpc.vpc1.id
}
resource "alicloud_security_group_rule" "allow_Sql_ssh-to-http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.Allow-SQL-to-http.id
  source_security_group_id = alicloud_security_group.Allow.id
}

resource "alicloud_security_group" "Allow-sql-to-http" {
  name        = "Alow-http"
  description = "security group"
  vpc_id      = alicloud_vpc.vpc1.id
}
resource "alicloud_security_group_rule" "allow_sql-to-http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "3306/3306"
  priority          = 1
  security_group_id = alicloud_security_group.Allow-sql-to-http.id
  source_security_group_id = alicloud_security_group.Allow.id
}