provider "aws" {
  profile = "vungocson998"
  region  = "ap-southeast-1"
}

resource "aws_instance" "nginx" {
  ami           = "ami-0d728fd4e52be968f"
  instance_type = "t2.micro"
  tags = {
    "Name" = "nginx"
  }
  user_data       = file("install_nginx.sh")
  key_name        = "terraform"
  security_groups = ["nginx-sg"]
}

resource "aws_security_group" "nginx-sg" {
  name        = "nginx-sg"
  description = "allow ssh and http"
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
      description      = "http"
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 280
    }
  ]
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "all allow going outbound"
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
}

output "domain-name" {
  value = aws_instance.nginx.public_dns
}

output "application-url" {
  value = "${aws_instance.nginx.public_dns}/index.php"
}