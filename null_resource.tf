resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443

    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22

    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"] # Canonical
}


resource "aws_instance" "web" {
  ami           = "${data.aws_ami.centos.id}"
  key_name      = "${aws_key_pair.deployer.key_name}"
  instance_type = "t2.medium"
  security_groups = ["${aws_security_group.allow_tls.name}"]
  provisioner   "remote-exec" {
    connection {
        host        = "${self.public_ip}"
        type        = "ssh"
        user        = "centos"
        private_key = "${file("~/.ssh/id_rsa")}"
    }


resource "null_resource" "mine" {
    triggers = {
        always_run = "${timestamp()}"
    }    
  depends_on = ["aws_instance.web"]
  provisioner   "remote-exec" {
    connection {
        host        = "${aws_instance.web.public_ip}"
        type        = "ssh"
        user        = "centos"
        private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
      "sudo yum install -y curl policycoreutils-python openssh-server",
      "sudo systemctl enable sshd",
      "sudo systemctl start sshd",
      "sudo yum install firewalld -y",
      "sudo systemctl firewalld start",
      "sudo systemctl firewalld enable",
      "sudo firewall-cmd --permanent --add-service=http",
      "sudo firewall-cmd --permanent --add-service=https",
      "sudo systemctl reload firewalld",
      "curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh | sudo bash",
      "sudo EXTERNAL_URL="https://gitlab.example.com" yum install -y gitlab-ee"


    ]
  }