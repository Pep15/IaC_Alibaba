resource "alicloud_ecs_key_pair" "KeySSH" {
  key_name   = "mKey"
  key_file = "mKey.pem"
}