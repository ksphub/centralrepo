variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}

provider "aws" {
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  region = "us-east-2"
}

resource "aws_instance" "TestIns" {
    ami = "ami-0653e888ec96eab9b"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["sg-03f1b4ecbad3c31a9"]
    key_name = "kspaws230219"
    tags {
    Name = "TestIns"
  }

}

output "publicip" {
  value = "${aws_instance.TestIns.public_ip}"
}

output "privateip" {
  value = "${aws_instance.TestIns.private_ip}"
}
