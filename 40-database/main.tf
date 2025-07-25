resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mongodb_sg_id]
  subnet_id = local.database_subnet_id


  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-mongodb"
    }

  )
}

resource "aws_route53_record" "mongodb" {
  zone_id = var.zone_id
  name    = "mongodb-${var.environment}.${var.zone_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mongodb.private_ip]
  allow_overwrite = true
}

# sive terraform_data (null resource) tho servers ne trigger ne chesi bootstrap file tho ansible install chesi git tho ansible  pull  ante command tho chestunadi 
# nenu bastion sevver login chesi chestunadu nduku ante na vpn work avaledhu proper ga 

resource "terraform_data" "mongodb" {
 triggers_replace = [
  aws_instance.mongodb.id
]

 provisioner "file" {
  source      = "bootstrap.sh"
  destination = "/tmp/bootstrap.sh"
 }
 connection {
  type     = "ssh"
  user     = "ec2-user"
  password = "DevOps321"
  host     = aws_instance.mongodb.private_ip
 }
 provisioner "remote-exec" {
  inline = [
    "chmod +x /tmp/bootstrap.sh",
    "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}"
  ]
 }
}

## ======================= Redis
#resource "aws_instance" "redis" {
#  ami           = local.ami_id
#  instance_type = "t3.micro"
#  vpc_security_group_ids = [local.redis_sg_id]
#  subnet_id = local.database_subnet_id
#
#
#  tags = merge(
#    local.common_tags,
#    {
#        Name = "${var.project}-${var.environment}-redis"
#    }
#
#  )
#}
#
#resource "aws_route53_record" "redis" {
#  zone_id = var.zone_id
#  name    = "redis-${var.environment}.${var.zone_name}"
#  type    = "A"
#  ttl     = 1
#  records = [aws_instance.redis.private_ip]
#  allow_overwrite = true
#}
#
#resource "terraform_data" "redis" {
# triggers_replace = [
#   aws_instance.redis.id
# ]
# provisioner "file" {
#   source      = "bootstrap.sh"
#   destination = "/tmp/bootstrap.sh"
# }
# connection {
#   type     = "ssh"
#   user     = "ec2-user"
#   password = "DevOps321"
#   host     = aws_instance.redis.private_ip
# }
# provisioner "remote-exec" {
#   inline = [
#     "chmod +x /tmp/bootstrap.sh",
#     "sudo sh /tmp/bootstrap.sh redis ${var.environment}"
#   ]
# }
#}
#
#################  MYSQL
#resource "aws_instance" "mysql" {
#  ami           = local.ami_id
#  instance_type = "t3.micro"
#  vpc_security_group_ids = [local.mysql_sg_id]
#  subnet_id = local.database_subnet_id
#  iam_instance_profile = "EC2RoleFetchSSMparams"
#
#
#  tags = merge(
#    local.common_tags,
#    {
#        Name = "${var.project}-${var.environment}-mysql"
#    }
#
#  )
#}
#
#resource "aws_route53_record" "mysql" {
#  zone_id = var.zone_id
#  name    = "mysql-${var.environment}.${var.zone_name}"
#  type    = "A"
#  ttl     = 1
#  records = [aws_instance.mysql.private_ip]
#  allow_overwrite = true
#}
#
#resource "terraform_data" "mysql" {
# triggers_replace = [
#   aws_instance.mysql.id
# ]
# provisioner "file" {
#   source      = "bootstrap.sh"
#   destination = "/tmp/bootstrap.sh"
# }
# connection {
#   type     = "ssh"
#   user     = "ec2-user"
#   password = "DevOps321"
#   host     = aws_instance.mysql.private_ip
# }
# provisioner "remote-exec" {
#   inline = [
#     "chmod +x /tmp/bootstrap.sh",
#     "sudo sh /tmp/bootstrap.sh mysql ${var.environment}"
#   ]
# }
#}
#
#################  rabittmq
#resource "aws_instance" "rabbitmq" {
#  ami           = local.ami_id
#  instance_type = "t3.micro"
#  vpc_security_group_ids = [local.rabbitmq_sg_id]
#  subnet_id = local.database_subnet_id
#
#
#  tags = merge(
#    local.common_tags,
#    {
#        Name = "${var.project}-${var.environment}-rabbitmq"
#    }
#
#  )
#}
#
#resource "aws_route53_record" "rabbitmq" {
#  zone_id = var.zone_id
#  name    = "rabbitmq-${var.environment}.${var.zone_name}"
#  type    = "A"
#  ttl     = 1
#  records = [aws_instance.rabbitmq.private_ip]
#  allow_overwrite = true
#
#}
#
#resource "terraform_data" "rabbitmq" {
# triggers_replace = [
#   aws_instance.rabbitmq.id
# ]
# provisioner "file" {
#   source      = "bootstrap.sh"
#   destination = "/tmp/bootstrap.sh"
# }
# connection {
#   type     = "ssh"
#   user     = "ec2-user"
#   password = "DevOps321"
#   host     = aws_instance.rabbitmq.private_ip
# }
# provisioner "remote-exec" {
#   inline = [
#     "chmod +x /tmp/bootstrap.sh",
#     "sudo sh /tmp/bootstrap.sh rabbitmq ${var.environment}"
#   ]
# }
#}