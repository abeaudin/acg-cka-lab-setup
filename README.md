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

and save the file

### Install Terraform 

Next step is to install Terraform. Run the below commands from the Linode shell-

```
 wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
 ```
 NOTE: This command will results in garbage on the screen, this is ok.
 ```
 echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
 ```
 
 ```
 sudo apt update && sudo apt-get install terraform
 ```
 
 Next, we build the target linodes for the Kubernetes cluster, with the terraform files that are included in this repository, and pulled into the Linode Shell from the prior git command.


1. Initialize the Linode terraform provider-
```
terraform init 
```
2. Next, we'll use the supplied terraform files to provision the LKE cluster. First, run the "terraform plan" command to view the plan prior to deployment-
```
terraform plan \
 -var-file="terraform.tfvars"
```
3. Run "terraform apply" to deploy the plan to Linode and build your LKE cluster-
```
terraform apply \
-var-file="terraform.tfvars"
```
Once deployment is complete, you should see three new Linodes in your Linode Cloud Manager account named cka-control, cka-worker1 and cka-worker2


From this point, you can continue along with the acloud.guru courses using kubeadm and the other tooling to stand the cluster up.
