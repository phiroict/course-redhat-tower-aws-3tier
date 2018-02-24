# Install AWS keys
Put these in aws_credentials and read these into the book. 

Install boto
```bash
sudo pip install boto3

```
Moved that to a ansible job. 

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

# Todo
* Attach public interface to the hosts to do the deployment.
* Do the deployment to have a MVP 
* After that, create a fifth host that is a jumphost. 
  * Put that in the public segment.
* Deploy over the jumphost
* Then get it to work over ansible tower. 