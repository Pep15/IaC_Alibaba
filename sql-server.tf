resource "alicloud_instance" "sql" {
  # cn-beijing
  availability_zone = data.alicloud_zones.availability_zones.zones.0.id
  security_groups   = [alicloud_security_group.Allow-SQL-to-http.id ,alicloud_security_group.Allow-sql-to-http.id]

  # series III
  instance_type              = "ecs.g6.large"
  system_disk_category       = "cloud_essd"
  system_disk_name           = "DISK"
  system_disk_description    = "test_foo_system_disk_description"
  image_id                   = "ubuntu_24_04_x64_20G_alibase_20240812.vhd"
  instance_name              = "sql"
  vswitch_id                 = alicloud_vswitch.Privete.id
  internet_charge_type       = "PayByTraffic"
  instance_charge_type       = "PostPaid"
  internet_max_bandwidth_out = 0
  key_name                   = alicloud_ecs_key_pair.KeySSH.key_pair_name
  user_data = base64encode(file("sql-satrup.sh"))
  
}