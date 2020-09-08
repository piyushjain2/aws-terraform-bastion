# AWS-Terraform-Bastion

----
The project creates an AWS environment which consists of following 
1. Bastion Host : The Bastion Host is an AWS EC2 instance which is publically accessible over ssh on port 22
2. Target Host : The Target Host is an AWS EC2 instance that is on a private subnet. The target host is accessible via ssh from the bastion host.

----

### Tools used 

1. Terraform 
2. AWS SDK

----

### Pre-requistes

1. AWS account 
2. Terraform installed on machine
3. AWS SDK installed 

----

### Assumption

1. The IAM role chosen is with Administrator access
2. The code can be further generalised, I have created a very raw terraform module based structure
3. Default AWS region assumed : us-east-2(Ohio), accordingly I have taken AMI : `ami-0603cbe34fd08cb81`

----

### Steps to run 

1. Run `terraform plan` is used to create execution plan. You can run if you want to create a plan before you create the infrastructure.

2. This terraform script takes 5 variables (3 of them i.e. "region" - refers to AWS region for infrastructure, "ami" - refers to AWS machine image from that particular region and "key_name_prefix" - refers to prefix of ssh key created by AWS Secrets Manager)

3. Command to run : 
        `terraform apply -var 'aws_access_key=<<AWS_ACCESS_KEY>>' -var 'aws_secret_key=<<AWS_SECRET_KEY>>'`
                    if you want to approve the plan manually before applying
        OR
        `terraform apply -auto-approve -var 'aws_access_key=<<AWS_ACCESS_KEY>>' -var 'aws_secret_key=<<AWS_SECRET_KEY>>'`
                    if you don't want to approve the plan manually before applying

The terraform script will automatically create all the required components i.e. 

        1. AWS VPC 
        2. AWS Internet Gateway - For public EC2 instances
        3. 2 Subnets - 1 Public, 1 private subnet
        4. 2 Route table - 1 public, 1 private 
        5. 2 Route table associations - mapping route tables to subnets
        6. 2 Security groups -  1 opens `SSH` Port to world to ssh into bastion host, 1 allows bastion host to ssh into target host
        7. 1 SSH key pair - This key exposes the stores the private key and can be used to ssh to EC2 machine
        8. 2 Amazon Linux based EC2 - 1 bastion host, 1 target host


4. After the infrastucture is created, copy the ssh key value from AWS Secrets Manager and store it a file which in the next step you will use for doing `ssh`.

5. After the key is copied and stored, we can easily `ssh` into Bastion host using 
        `ssh -i <<PATH_TO_KEY_FILE>> ec2-user@<<public_ip_bastion>>`
         the value `public_ip_bastion` will be received as an output of `terraform apply` command

6. At this point from Bastion host if you would try to `ssh` to target host, your attempt will fail because the ssh-key is not present on Bastion machine. To solve this there are 2 ways as below :
        
        a. Copy the value of key from you machine to bastion host and try `ssh`. This is not a recommended behavior as this is prone to ssh-key getting leaked.

        b. SSH agent forwarding - this allows you to use your local SSH keys instead of leaving keys (without passphrases!) sitting on your server. To do this follow below steps 
            1. `cd` to the directory where your key is stored
            2.  ssh-agent bash
            3.  ssh-add <<KEY_FILE_NAME>>

7. After doing this try :
        `ssh -A ec2-user@<<public_ip_bastion>>`
    and
        `ssh ec2-user@<<private_ip_target>>`
        the value `private_ip_target` will also be received as an output of `terraform apply` command.