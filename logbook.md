# Install AWS keys
Put these in aws_credentials and read these into the book. 

Install boto
```bash
sudo pip install boto3

```
Moved that to an ansible job triggered by an bash script. 

# AWS 
* Create Infra structure: course-redhat-tower-aws-3tier/cmdCreateInfra.sh
  * Creates VPC 
  * Subnets
  * Create gateway
  * Creates routes
  * Create security groups
* Create instances: course-redhat-tower-aws-3tier/cmdCreateInstances.sh
* Delete instances: course-redhat-tower-aws-3tier/cmdDeleteHosts.sh

Current state is that the infra is created and we just delete and remake the hosts as these costs money.

# Setup commandline

Set the AWS variables to connect to the correct account. 
The:
```text
vars_aws.yml
```
Contain the non-secret settings:
```yaml

---
  instance_type: t2.micro
  key_name: "id_rsa_aws_proxy"
  image: "ami-845aa4e6"
  region: "ap-southeast-2"
```
The image is a centos7 image.


# Setup tower
Created from provision script at: https://github.com/phiroict/course-redhat-tower-os-3tier/tree/master/ansible-tower
Then the openstack.pem manually overto the location at /var/lib/awx/.ssh/.
Then created the jobs from the seperate playbooks.

## QA
This is run from this git repo.

### Run once
* Create networks
course-redhat-ansible-windows-chapter7/code/provisioning-QA/cmd_create_networks.sh
(Includes router)

  * Calls: pb_create_network.yml

* Create keypair
course-redhat-ansible-windows-chapter7/code/provisioning-QA/cmd_create_sshkeys.sh
  * Calls: pb_sshkeys.yml

* Create flavor
course-redhat-ansible-windows-chapter7/code/provisioning-QA/cmd_create_flavor.sh
  * Calls: pb_osp_flavor.yml 

* Create the security groups
course-redhat-ansible-windows-chapter7/code/provisioning-QA/cmd_create_security.sh
  * Calls: pb_setup_security.yml

### Run from tower
* Build instances
course-redhat-tower-os-3tier/cmd_create_instances.sh 
  * Calls: pb_create_instances.yml
  
* Install apps
course-redhat-tower-os-3tier/cmd_install_applications.sh ()
  * Calls: pb_install_apps.yml

* Delete instances
course-redhat-tower-os-3tier/cmd_delete_instances.sh
  * Calls: pb_delete_instances.yml
  
## Prod
From github: https://github.com/phiroict/course-redhat-tower-aws-3tier

* Create Infra structure: course-redhat-tower-aws-3tier/cmdCreateInfra.sh (pb_aws_setup_security.yml)
  * Creates VPC 
  * Subnets
  * Create gateway
  * Creates routes
  * Create security groups
* Create instances: course-redhat-tower-aws-3tier/cmdCreateInstances.sh   (pb_aws_create_instances.yml)
* Delete instances: course-redhat-tower-aws-3tier/cmdDeleteHosts.sh       (pb_aws_delete_instances.yml)


# Logging in to AWS jumphost
```bash
ssh -A -i ~/.ssh/id_rsa_aws_proxy centos@<external ip address jumphost>
```
You get this ip address from the cmdCreateInstances.sh result logs.

# Configuration of AWS 
* Set the security groups to allow all outgoing traffic so you can update yum repos. 
* Allow internal network to connect out by adding a nat gateway to it.
  * Add a nat gateway _to the public subnet_. (Done in ansible script now)
  * Adding the nat to the subnet does not work in ansible so add that **manually** to the route table of the private subnet. TODO: Figure out to do this in ansible.


