packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "region"{
  type    = string
  default = ""
}

variable "source_ami"{
  type    = string
  default = ""
}

variable "instance_type"{
  type    = string
  default = ""
}

variable "vpc_id"{
  type    = string
  default = ""
}

variable "subnet_id"{
  type    = string
  default = ""
}

source "amazon-ebs" "my-ami"{
  region                      = var.region
  source_ami                   = var.source_ami
  instance_type               = var.instance_type
  ssh_username                = "ubuntu"
  associate_public_ip_address = true

ami_name = "cloud-spectrum-master-Build-${formatdate("YYYYMMDD-hhmmss", timestamp())}"

  vpc_id    = var.vpc_id
  subnet_id = var.subnet_id

  tags = {
  Name = "cloud-spectrum-master-Build-${formatdate("YYYYMMDD-hhmmss", timestamp())}"
  }
}

build {
  name    = "cloud-spectrum-master-ami-build"
  sources = [
    "source.amazon-ebs.my-ami"
  ]

  provisioner "shell"{
    inline = [
      "sleep 30",
      "sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo apt install git -y",
      "sudo git clone https://github.com/iam-rayees/Cloud-Spectrum-Master.git",
      "sudo rm -f /var/www/html/index.nginx-debian.html",
      "sudo cp Cloud-Spectrum-Master/index.html /var/www/html/index.html",
      "sudo cp Cloud-Spectrum-Master/style.css /var/www/html/style.css",
      "sudo cp Cloud-Spectrum-Master/script.js /var/www/html/script.js",
      "sudo service nginx start",
      "sudo systemctl enable nginx",
      "curl https://get.docker.com | bash"
    ]
  }

  provisioner "file"{
    source      = "docker.service"
    destination = "/tmp/docker.service"
  }

  provisioner "shell"{
    inline = [
      "sudo cp /tmp/docker.service /lib/systemd/system/docker.service",
      "sudo usermod -a -G docker ubuntu",
      "sudo systemctl daemon-reload",
      "sudo service docker restart"
    ]
  }
}