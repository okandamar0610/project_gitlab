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
      "sudo EXTERNAL_URL=http://ec2-3-235-29-127.compute-1.amazonaws.com yum install -y gitlab-ee"

     


    ]
  
}
}