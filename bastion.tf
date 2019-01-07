module "bastion" {
  source                      = "github.com/terraform-community-modules/tf_aws_bastion_s3_keys"
  instance_type               = "t2.micro"
  ami                         = "ami-976152f2"
  region                      = "${var.region}"
  key_name                    = "${var.key_name}"
  iam_instance_profile        = "s3_readonly"
  s3_bucket_name              = "my-public-keys-bucket"
  vpc_id                      = "${module.vpc.vpc_id}"
  subnet_ids                  = "${module.vpc.public_subnets}"
  keys_update_frequency       = "*/15 * * * *"
  additional_user_data_script = "date"
  name  = "bastion"
  associate_public_ip_address = true
  ssh_user = "ec2-user"
}

# allow ssh coming from bastion to boxes in vpc
#
resource "aws_security_group_rule" "allow_ssh" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  security_group_id = "${module.vpc.default_security_group_id}"
  source_security_group_id = "${module.bastion.security_group_id}" 
}