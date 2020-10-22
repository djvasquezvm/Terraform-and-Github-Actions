resource "aws_instance" "proxy_basic" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"
  key_name	= aws_key_pair.key_proxy.key_name
  security_groups = [aws_security_group.sg.name]

  tags = {
    Name = "ssh proxy"
  }

}

resource "aws_security_group" "sg" {
  name = "allow_proxy (security group name)"
  description = "Allow proxy (description)"

  ingress {
    description = "Allow incoming ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow incoming http"
    from_port   = 80
    to_port     = 80
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
    "type" = "proxy security group"
  }
}

resource "aws_key_pair" "key_proxy" {
  key_name       = "proxy_key"
  public_key = file("id_rsa.pub")
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-up-and-running-state-daniel-vasquez"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks-daniel-vasquez"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
