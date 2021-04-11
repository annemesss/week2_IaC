provider "aws" {
    //region = "eu-central-1"
}

resource "aws_instance" "LinuxWebserver1" {
    ami                    = "ami-0db9040eb3ab74509"
    instance_type          = "t2.micro"
    vpc_security_group_ids = [aws_security_group.my_webserver.id]
    user_data              = file("web1.sh")
    key_name               = aws_key_pair.ssh_key.key_name
    tags = {
      Name = "Webserver_1"
    }
}

resource "aws_instance" "LinuxWebserver2" {
    ami                    = "ami-0db9040eb3ab74509"
    instance_type          = "t2.micro"
    vpc_security_group_ids = [aws_security_group.my_webserver.id]
    user_data              = file("web2.sh")
    key_name               = aws_key_pair.ssh_key.key_name
    tags = {
      Name = "Webserver_2"
    }
}

resource "aws_instance" "Nginx_Ubuntu" {
    ami                    = "ami-0db9040eb3ab74509"
    instance_type          = "t2.micro"
    vpc_security_group_ids = [aws_security_group.my_webserver.id]
    user_data              = templatefile("nginx.sh", {
        ip_web1 = aws_instance.LinuxWebserver1.public_ip,
        ip_web2 = aws_instance.LinuxWebserver2.public_ip
      })
    key_name               = aws_key_pair.ssh_key.key_name
    tags = {
       Name  = "WebServer_load_balancer"
    }
    depends_on = [aws_instance.LinuxWebserver1, aws_instance.LinuxWebserver2]

    provisioner "local-exec" {
        command = "echo ${aws_instance.LinuxWebserver1.public_ip}>> xxx"
    }

    provisioner "local-exec" {
        command = "echo ${aws_instance.LinuxWebserver2.public_ip}>> yyy"
    }

    provisioner "local-exec" {
        command = "echo ${aws_instance.Nginx_Ubuntu.public_ip}>> publicIP_LB"
    }
}
