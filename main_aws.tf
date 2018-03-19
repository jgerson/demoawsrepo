# Deploy a single AMI, then execute the command, and then apply security group

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "example1" {
  # Ubuntu Server 14.04 LTS (HVM), SSD Volume Type in us-east-1
  count = 1
  ami = "ami-97785bed"
  instance_type = "t2.medium"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World test" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  tags {
    Name = "terraform-example 1"
  }
}

resource "aws_instance" "example2" {
  # Ubuntu Server 14.04 LTS (HVM), SSD Volume Type in us-east-1
  count = 1
  ami = "ami-97785bed"
  instance_type = "t2.medium"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World test" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  tags {
    Name = "terraform-example 2"
  }
}

resource "aws_instance" "example3" {
  # Ubuntu Server 14.04 LTS (HVM), SSD Volume Type in us-east-1
  count = 1
  ami = "ami-97785bed"
  instance_type = "t2.medium"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World test3" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  tags {
    Name = "terraform-example 3"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance 2"

  # Inbound HTTP from anywhere
  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
