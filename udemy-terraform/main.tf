resource "aws_instance" "this" {
  ami           = "ami-0d979355d03fa2522"
  instance_type = "t2.micro"
  
  vpc_security_group_ids = [aws_security_group.this.id]

  tags = {
    Name = "udemy-terraform-ec2",
    Date = "2023-05-11"
  }
}

resource "aws_security_group" "this" {
  name = "udemy-terraform-ec2-sg"
}