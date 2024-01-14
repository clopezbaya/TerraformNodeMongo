packer {
 required_plugins{
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "Nginx-Node-MEAN"{
  ami_name = "Nginx-Node-MEAN-app-${local.timestamp}"

  source_ami_filter {
    filters = {
      name                = "al2023-ami-2023.2.20231113.0-kernel-6.1-x86_64"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  instance_type = "t2.micro"
  access_key= "AKIAVRUVTHSYUMBADYOA"
  secret_key= "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"
  region = "sa-east-1"
  ssh_username = "ec2-user"
}

build {
  sources = [
    "source.amazon-ebs.Nginx-Node-MEAN", 
  ]

  provisioner "file" {
    source = "../NodeAPP.zip"
    destination = "/home/ec2-user/NodeAPP.zip"
  }

  provisioner "file" {
    source = "./node.service"
    destination = "/tmp/node.service"
  }

  provisioner "shell" {
    script = "./app.sh"
  }
}