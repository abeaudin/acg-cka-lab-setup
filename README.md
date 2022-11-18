# Non LKS Kubernetes Cluster Setup
# About
Package of template files, etc to set up the basic lab sandbox for acloud.guru's Kubernetes courses for Introduction to Kubernetes and Certified Kubernetes Administrator courses.

This project provides examples of how to configure:
- Linodes
- Private IPs
- VLANs
- Firewalls, Rules, Nodes
- StackScripts
# Contents
## Template Files
- Sample Terraform files for deploying an three Linodes configured with the basics to deploy a kubernetes cluster on it.
- StackScript to configure and install containerd, etc on the three nodes

## Prerequisites
- Linode Account
- Access to acloud.guru for the course material

### Overview
The project scenario builds the following components and steps-

1. A Secure Shell Linode (provisioned via the Linode Cloud Manager GUI) to serve as the command console for the environment setup.

2. Installing developer tools on the Secure Shell (git, terraform) for use in environment setup.

3. Three Linodes (ubuntu 20.04), provisioned via terraform. Two for Kubernetes Workers, one for the Kubernetes Control node. 

4. Supporting linode objects, provisioned via Terraform include:
- Firewall permitting only ports 22,443 inbound

## Step By Step Instructions

We'll create a Linode using the "Secure Your Server" Marketplace image. This will give us a hardened, consistent environment to run our subsequent commands from.

1. Login to Linode Cloud Manager, Select "Create Linode," and choose the "Secure Your Server" Marketplace image.
2. Within the setup template for "Secure Your Server," select the Ubuntu image type.
3. Once your Linode is running, login to it's shell (either using the web-based LISH console from Linode Cloud Manager, or via your SSH client of choice).

### Install and Run git
Next step is to install git, and pull this repository to the Secure Shell Linode. The repository includes terraform and kubernetes configuration files that we'll need for subsequent steps.

### Install git via the SSH or LISH shell-
```
sudo apt-get install git
```

Pull down this repository to the Linode machine-

```
git init && git pull https://github.com/abeaudin/acg-cka-lab-linode
```

Once this is down, you need to 
- Create a stackscript from the node.txt files as a cut and paste
- make a note of the stackscript id.
- create an API token 

Then edit the terraform.tfvars file and add in values for
- token
- authorized_keys
- root_pass
- myipaddress
- stackscriptId
