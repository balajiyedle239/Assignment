provider "aws" {
  region              = "us-east-1"
}

resource "aws_instance" "ec2" {
  ami                         = "ami-0f34c5ae932e6f0e4"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = "subnet-0600ec02f302b12d2"
  vpc_security_group_ids      = ["sg-01608658d7ac07eb7"]
  key_name                    = "ec2key"
  tags = {
    Name = "SERVER01"
  }
}
resource "null_resource" "start_instance" {

  provisioner "local-exec" {
    on_failure  = "fail"
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        echo -e "\x1B[31m Warning! Starting instance having id.................. \x1B"
        # aws ec2 reboot-instances --instance-ids ${aws_instance.ec2.id} --profile test
        # To stop instance
        aws ec2 start-instances --instance-ids i-0eaec3854ff353b7b
        echo "***************************************Rebooted****************************************************"
     EOT
  }
}
