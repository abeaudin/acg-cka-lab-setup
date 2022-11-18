resource "linode_firewall" "cka-firewall" {
  label = "cka-firewall"

  inbound {
    label    = "allow-ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = [var.myipaddress]
    ipv6     = []
  }

  inbound {
    label    = "allow-kubernetes-api"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "6443"
    ipv4     = ["${linode_instance.cka-control.ip_address}/32","${linode_instance.cka-worker1.ip_address}/32", "${linode_instance.cka-worker2.ip_address}/32" ]
    ipv6     = []
  }
  
  inbound_policy = "ACCEPT"
  outbound_policy="ACCEPT"
  }
  
  resource "linode_firewall_device" "cka-control-device" {
	firewall_id = linode_firewall.cka-firewall.id
	entity_id = linode_instance.cka-control.id
	}
	
  resource "linode_firewall_device" "cka-worker1-device" {
	firewall_id = linode_firewall.cka-firewall.id
	entity_id = linode_instance.cka-worker1.id
	}
	
  resource "linode_firewall_device" "cka-worker2-device" {
	firewall_id = linode_firewall.cka-firewall.id
	entity_id = linode_instance.cka-worker2.id
	}