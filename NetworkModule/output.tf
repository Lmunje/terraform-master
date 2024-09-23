output "public_instance_ip" {
  value = ["${aws_instance.lionel_instance.public_ip}"]
}