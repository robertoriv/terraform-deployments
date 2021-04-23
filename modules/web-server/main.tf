resource "aws_instance" "web_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_size
  vpc_security_group_ids = [aws_security_group.security_group.id]
  subnet_id              = var.subnet

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_http_port} &
              EOF

  tags = merge(
    var.tags,
    {
      Name = "web-server-${var.environment_name}"
    }
  )
}

resource "aws_security_group" "security_group" {

  name   = "web-server-${var.environment_name}-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.server_http_port
    to_port     = var.server_http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
