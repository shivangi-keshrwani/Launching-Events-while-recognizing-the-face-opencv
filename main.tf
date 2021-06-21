provider "aws" {
    region  = "ap-south-1"
    profile = "default"
}
resource "aws_instance" "try" {
  ami           = "ami-0ad704c126371a549"
  instance_type = "t2.micro"
  key_name = "Abhay2"
 tags = {
    Name = "face_recognition"	
  }
}
resource "aws_ebs_volume" "vol" {
  availability_zone = aws_instance.try.availability_zone
  size              = 5

  tags = {
    Name = "Try_face recognition"
  }
}
resource "aws_volume_attachment" "ebs" {
  device_name = "/dev/sdc"
  volume_id   = aws_ebs_volume.vol.id
  instance_id = aws_instance.try.id
  force_detach = true
}
resource "null_resource"  "nullremote" {
 connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/Admin/Downloads/Abhay2.pem")
    host     = aws_instance.try.public_ip
  }

provisioner "remote-exec" {
    inline = [
      "sudo mkfs.ext4 /dev/xvdc",
      "sudo  mount /dev/xvdc  /",
    ]
  }
}

