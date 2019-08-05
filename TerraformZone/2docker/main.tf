variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}

provider "aws" {
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  region = "us-east-2"
}

resource "aws_instance" "DockerServer" {
    ami = "ami-0653e888ec96eab9b"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["sg-03f1b4ecbad3c31a9"]
    key_name = "kspaws230219"
    tags {
    Name = "DockerServer"
  }

  provisioner "file" {
    source      = "apachefiles"
    destination = "/tmp"

    connection {
      type        = "ssh"
      agent       = false
      private_key = "${file("kspaws230219.pem")}"
      user        = "ubuntu"
    } 
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/apachefiles/*.sh",
      "/tmp/apachefiles/dockerinstall.sh",
      "rm -r /tmp/apachefiles"
    ]
    connection {
      type        = "ssh"
      agent       = false
      private_key = "${file("kspaws230219.pem")}"
      user        = "ubuntu"
    } 
  }
}

output "publicip" {
  value = "${aws_instance.DockerServer.public_ip}"
}

output "DockerNexus URL" {
  value = "${aws_instance.DockerServer.public_ip}:8081"
}
