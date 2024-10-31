resource "alicloud_vpc" "vpc1" {
  vpc_name    = "LAB-terfform"
  cidr_block  = "10.0.0.0/8"
}
data "alicloud_zones" "availability_zones" {
  available_resource_creation = "VSwitch"
}
resource "alicloud_vswitch" "public-a" {
  vswitch_name      = "public"
  cidr_block        = "10.10.1.0/24"
  vpc_id            = alicloud_vpc.vpc1.id
  zone_id = data.alicloud_zones.availability_zones.zones.0.id
}
resource "alicloud_vswitch" "public-b" {
  vswitch_name      = "public"
  cidr_block        = "10.10.3.0/24"
  vpc_id            = alicloud_vpc.vpc1.id
  zone_id = data.alicloud_zones.availability_zones.zones.1.id
}
resource "alicloud_vswitch" "Privete" {
  vswitch_name      = "Privete"
  cidr_block        = "10.10.2.0/24"
  vpc_id            = alicloud_vpc.vpc1.id
  zone_id = data.alicloud_zones.availability_zones.zones.0.id
}
resource "alicloud_nat_gateway" "nat-internet" {
  vpc_id           = alicloud_vpc.vpc1.id
  nat_gateway_name = "http"
  payment_type     = "PayAsYouGo"
  vswitch_id       = alicloud_vswitch.public-a.id
  nat_type         = "Enhanced"
}

resource "alicloud_eip_address" "eip-address" {
  description               = "nat"
  isp                       = "BGP"
  address_name              = "nat"
  netmode                   = "public"
  bandwidth                 = "100"
  payment_type              = "PayAsYouGo"
  internet_charge_type      = "PayByTraffic"
}
resource "alicloud_eip_association" "nat" {
  allocation_id = alicloud_eip_address.eip-address.id
  instance_id   = alicloud_nat_gateway.nat-internet.id
  instance_type = "Nat"
}
resource "alicloud_snat_entry" "http" {
  snat_table_id     = alicloud_nat_gateway.nat-internet.snat_table_ids
  source_vswitch_id = alicloud_vswitch.Privete.id
  snat_ip           = alicloud_eip_address.eip-address.ip_address
}
resource "alicloud_route_table" "private" {
  vpc_id           = alicloud_vpc.vpc1.id
  route_table_name = "private"
  associate_type   = "VSwitch"
}
resource "alicloud_route_entry" "routuing-E" {
  route_table_id        = alicloud_route_table.private.id
  destination_cidrblock = "0.0.0.0/0"
  nexthop_type          = "NatGateway"
  nexthop_id            = alicloud_nat_gateway.nat-internet.id
}

resource "alicloud_route_table_attachment" "routing" {
  vswitch_id     = alicloud_vswitch.Privete.id
  route_table_id = alicloud_route_table.private.id
}