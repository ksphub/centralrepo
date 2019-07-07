variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}

provider "aws" {
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  region = "us-east-2"
}

resource "aws_instance" "AnsibleServer" {
    ami = "ami-0f65671a86f061fcd"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["sg-03f1b4ecbad3c31a9"]
    key_name = "kspaws230219"
    tags {
    Name = "AnsibleServer"
    }
  
  provisioner "remote-exec" {
    inline = [
      "echo Configuring Ansible Master",
      "sudo useradd -c 'Ansible User' -m -d /home/ansible -s /bin/bash ansible",
      "echo  \"ansible ALL=(ALL) NOPASSWD:ALL\" | sudo tee --append  /etc/sudoers.d/90-cloud-init-users",
      "sudo apt-get update",
      "sudo apt-get install software-properties-common -y",
      "sudo apt-add-repository --yes --update ppa:ansible/ansible",
      "sudo apt-get update",
      "sudo apt-get install ansible -y",
      "sudo echo -e '\n\n\n' | sudo -u ansible -- ssh-keygen -t rsa -N ''",
      "sudo sed -i 's#ansible:!#ansible:$6$VvE3RiZW$afrzusqN.jBWERtwPxVWmLgG3NxG/kO7TwAl1.Cwth13OS1P1oBP9qBMaJO2evCJ9/eU7HovwdGazl5jPXPP5/#g' /etc/shadow",
      "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config",
      "sudo systemctl restart sshd",
      "echo admin123 > /tmp/tmppasswd",
      "echo Successfully Configured Ansible Master"
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
  value = "${aws_instance.AnsibleServer.private_ip}"
}

output "PublicIP" {
  value = "${aws_instance.AnsibleServer.public_ip}"
}
