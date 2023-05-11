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

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id

}

resource "aws_security_group_rule" "http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1" // all protocol
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id

}