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

source "amazon-ebs" "MongoDB"{
  ami_name = "MongoDB-app-${local.timestamp}"
  source_ami = "ami-01b33f2637768083e"
  instance_type = "t2.micro"
  access_key= "AKIAVRUVTHSYUMBADYOA"
  secret_key= "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"
  region = "sa-east-1"
  ssh_username = "ec2-user"
}



build {
  sources = [
    "source.amazon-ebs.MongoDB", 
  ] 

  provisioner "shell" {
    script = "./app.sh"
  }
}