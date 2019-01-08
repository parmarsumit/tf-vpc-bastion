# tf-vpc-bastion
terraform to create vpc with bastion - aws

# Steps
1. Update backend file with your s3 bucket and filename to store for tfstate
2. fill in the values of varaibles as per your requirment
3. check the provider file for your creds if profile is setup on your machine, else insert the secret and access key : https://www.terraform.io/docs/providers/aws/

# Terraform
1. terraform init /* this will intialise the folder for terraform and download respective modules
2. terraform plan  /* will give you the list of resources created
3. terraform apply /* will create those resources
4. terraform destroy /* will cleanup all resources  

