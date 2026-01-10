################################################################################
# Bastion Module Outputs
################################################################################

output "instance_id" {
  description = "ID of the bastion EC2 instance"
  value       = aws_instance.bastion.id
}

output "public_ip" {
  description = "Public IP address of the bastion host"
  value       = aws_instance.bastion.public_ip
}

output "public_dns" {
  description = "Public DNS name of the bastion host"
  value       = aws_instance.bastion.public_dns
}

output "security_group_id" {
  description = "ID of the bastion security group"
  value       = aws_security_group.bastion.id
}

output "ssh_command" {
  description = "SSH command to connect to bastion"
  value       = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.bastion.public_ip}"
}

output "rds_tunnel_command" {
  description = "SSH tunnel command for RDS access (replace RDS_ENDPOINT)"
  value       = "ssh -i ~/.ssh/id_rsa -L 5432:RDS_ENDPOINT:5432 ec2-user@${aws_instance.bastion.public_ip}"
}
