terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "1.29.2"
    }
  }
}

provider "linode" {
  token = var.token
}


resource "linode_instance" "cka-control" {
    image = "linode/ubuntu20.04"
    label = "cka-control"
    group = "Terraform"
    region = var.region
    type = "g6-standard-1"
    authorized_keys = [var.authorized_keys]
    root_pass = var.root_pass
	interface {
		purpose = "public"
	}
	interface {
		purpose = "vlan"
		label = var.vlan
		ipam_address = "10.0.0.1/24"
	}	
	tags = ["cka-k8s"]
	stackscript_id = var.stackscriptId
	stackscript_data = { 
		"hostname" = "cka-control"
	}
}

resource "linode_instance" "cka-worker1" {
    image = "linode/ubuntu20.04"
    label = "cka-worker1"
    group = "Terraform"
    region = var.region
    type = "g6-standard-1"
    authorized_keys = [var.authorized_keys]
    root_pass = var.root_pass
	interface {
		purpose = "public"
	}
	interface {
		purpose = "vlan"
		label = var.vlan
		ipam_address = "10.0.0.2/24"
	}	
	tags = ["cka-k8s"]
	stackscript_id = var.stackscriptId
	stackscript_data = { 
		"hostname" = "cka-worker1"
	}
}

resource "linode_instance" "cka-worker2" {
    image = "linode/ubuntu20.04"
    label = "cka-worker2"
    group = "Terraform"
    region = var.region
    type = "g6-standard-1"
    authorized_keys = [var.authorized_keys]
    root_pass = var.root_pass
	interface {
		purpose = "public"
	}
	interface {
		purpose = "vlan"
		label = var.vlan
		ipam_address = "10.0.0.3/24"
	}	
	tags = ["cka-k8s"]
	stackscript_id = var.stackscriptId
	stackscript_data = { 
		"hostname" = "cka-worker2"
	}
}






	
