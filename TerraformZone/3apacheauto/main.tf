variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}

provider "aws" {
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  region = "us-east-2"
}

resource "aws_instance" "ApacheServer" {
    ami = "ami-0f65671a86f061fcd"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["sg-03f1b4ecbad3c31a9"]
    key_name = "kspaws230219"
    tags {
    Name = "ApacheServer"
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
      "echo copied apachefiles",
      "echo running apacheinstall.sh",
      "/tmp/apachefiles/apacheinstall.sh",
      "echo completed apacheinstall.sh and running apacheconfig.sh",
      "/tmp/apachefiles/apacheconfig.sh",
      "echo completed apacheconfig.sh and running manual steps",
      "sudo useradd -c 'Build User' -m -d /home/jenkins -s /bin/bash jenkins",
      "sudo sed -i 's#jenkins:!#jenkins:$6$VvE3RiZW$afrzusqN.jBWERtwPxVWmLgG3NxG/kO7TwAl1.Cwth13OS1P1oBP9qBMaJO2evCJ9/eU7HovwdGazl5jPXPP5/#g' /etc/shadow",
      "sudo usermod -aG sudo jenkins",
      "sudo apt-get install maven -y",
      "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config",
      "sudo systemctl restart sshd",
      "rm -rf /tmp/apachefiles",
      "echo  \"jenkins ALL=(ALL) NOPASSWD:ALL\" | sudo tee --append  /etc/sudoers.d/90-cloud-init-users",
      "echo completed manual steps"
    ]
    connection {
      type        = "ssh"
      agent       = false
      private_key = "${file("kspaws230219.pem")}"
      user        = "ubuntu"
    } 
  }
}

output "PrivateIP" {
  value = "${aws_instance.ApacheServer.private_ip}"
}

output "Apache-Tomcat URL" {
  value = "${aws_instance.ApacheServer.public_ip}:8080"
}
