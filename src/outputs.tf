
output "vpc_id" {
  value = aws_vpc.yuvaraj-vpc.id
}
output "ec2_id" {
  value = aws_instance.example.id
}