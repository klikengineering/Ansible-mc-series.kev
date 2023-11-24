resource "null_resource" "vscode-config" {
  depends_on = [time_sleep.wait_for_instance]


  connection {
    type        = "ssh"
    host        = aws_instance.ubuntu.public_ip
    user        = "ubuntu"
    password    = ""
    private_key = file("./ansible.pem")
  }


  provisioner "remote-exec" {
    script = "script.sh"

  }



  /*  provisioner "file" {
    source      = "./script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir /tmp",
      "sudo chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh args",
    ]
  }
  */

  provisioner "local-exec" {
    command = templatefile("${var.os}-ssh-script.tpl", {
      hostname     = aws_instance.ubuntu.public_ip
      user         = "ansible",
      IdentityFile = "./ansible.pem"
    })
    interpreter = var.os == "windows" ? ["powershell", "-Command"] : ["bash", "-c"]
  }
}


resource "time_sleep" "wait_for_instance" {
  create_duration = "180s"

  depends_on = [aws_instance.ubuntu]
}
