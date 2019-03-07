variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}

provider "aws" {
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  region = "us-east-2"
}

resource "aws_instance" "JenkinsServer" {
    ami = "ami-0653e888ec96eab9b"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["sg-03f1b4ecbad3c31a9"]
    key_name = "kspaws230219"
    tags {
    Name = "JenkinsServer"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt install openjdk-8-jdk wget -y",
      "sudo sed -ei '\\$aJAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/jre/bin/java' /etc/environment",
      "wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -",
      "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt-get update",
      "sudo apt-get install jenkins -y",
      "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config",
      "sudo systemctl restart sshd",
      "sudo usermod -aG sudo jenkins",
      "sudo sed -i 's#jenkins:\\*#jenkins:$6$VvE3RiZW$afrzusqN.jBWERtwPxVWmLgG3NxG/kO7TwAl1.Cwth13OS1P1oBP9qBMaJO2evCJ9/eU7HovwdGazl5jPXPP5/#g' /etc/shadow",
      "sudo apt-get install maven -y"
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
  value = "${aws_instance.JenkinsServer.public_ip}"
}

output "Jenkins URL" {
  value = "${aws_instance.JenkinsServer.public_ip}:8080"
}
