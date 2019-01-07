provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "<userhome-changeme>/.aws/credentials"
  profile = "${var.profile}"
}
