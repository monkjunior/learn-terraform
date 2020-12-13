provider "aws" {
  profile = "vungocson998"
  region  = "ap-southeast-1"
}

resource "aws_instance" "host1" {
  ami           = "ami-0d728fd4e52be968f"
  instance_type = "t2.micro"
  tags = {
    "Name" = "nginx"
  }
  user_data              = file("install_server.sh")
  key_name               = "terraform"
  vpc_security_group_ids = [aws_security_group.host1-sg.id]
}

resource "aws_security_group" "host1-sg" {
  name = "host1-sg"
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "ssh"
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 22
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "server port"
      from_port        = 8080
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 8080
  }]
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "allow all"
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
}