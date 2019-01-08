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
# resource "aws_security_group_rule" "allow_ssh" {
#   type            = "ingress"
#   from_port       = 22
#   to_port         = 22
#   protocol        = "tcp"
#   security_group_id = "${module.vpc.default_security_group_id}"
#   source_security_group_id = "${module.bastion.security_group_id}" 
# }


#### if you dont want to use default sg ####
resource "aws_security_group" "default" {
  name        = "bastion-sg"
  description = "bastionsg"
  vpc_id      = "${module.vpc.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# OPTIONAL: Allow inbound traffic from your local workstation external IP
#           to the Kubernetes. You will need to replace A.B.C.D below with
#           your real IP. Services like icanhazip.com can help you find this.
resource "aws_security_group_rule" "bastion" {
  cidr_blocks       = ["37.228.251.245/32"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 22
  protocol          = "tcp"
  source_security_group_id = "${module.bastion.security_group_id}" 
  to_port           = 22
  type              = "ingress"
}