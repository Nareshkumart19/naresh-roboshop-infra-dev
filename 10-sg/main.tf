# Security grops

module "mongodb" {
    #source = "../../naresh-terraform-aws-securitygroup"
    source = "git::https://github.com/Nareshkumart19/naresh-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    
    sg_name = "mongodb"
    sg_description = "for mongodb"
    vpc_id = local.vpc_id
}

# module "redis" {
    #source = "../../naresh-terraform-aws-securitygroup"
    # source = "git::https://github.com/Nareshkumart19/naresh-terraform-aws-securitygroup.git?ref=main"
    # project = var.project
    # environment = var.environment
    # 
    # sg_name = "redis"
    # sg_description = "for redis"
    # vpc_id = local.vpc_id
# }

# module "mysql" {
    #source = "../../naresh-terraform-aws-securitygroup"
    # source = "git::https://github.com/Nareshkumart19/naresh-terraform-aws-securitygroup.git?ref=main"
    # project = var.project
    # environment = var.environment
    # 
    # sg_name = "mysql"
    # sg_description = "for mysql"
    # vpc_id = local.vpc_id
# }

# module "rabbitmq" {
    #source = "../../naresh-terraform-aws-securitygroup"
    # source = "git::https://github.com/Nareshkumart19/naresh-terraform-aws-securitygroup.git?ref=main"
    # project = var.project
    # environment = var.environment
    # 
    # sg_name = "rabbitmq"
    # sg_description = "for rabbitmq"
    # vpc_id = local.vpc_id
# }

 module "catalogue" {
   #source = "../../naresh-terraform-aws-securitygroup"
    source = "git::https://github.com/Nareshkumart19/naresh-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    
    sg_name = "catalogue"
    sg_description = "for catalogue"
    vpc_id = local.vpc_id
 }

# module "user" {
    #source = "../../naresh-terraform-aws-securitygroup"
    # source = "git::https://github.com/Nareshkumart19/naresh-terraform-aws-securitygroup.git?ref=main"
    # project = var.project
    # environment = var.environment
    # 
    # sg_name = "user"
    # sg_description = "for user"
    # vpc_id = local.vpc_id
# }
#
#module "cart" {
#    #source = "../../naresh-terraform-aws-securitygroup"
#    source = "git::https://github.com/Nareshkumart19/naresh-terraform-aws-securitygroup.git?ref=main"
#    project = var.project
#    environment = var.environment
#    
#    sg_name = "cart"
#    sg_description = "for cart"
#    vpc_id = local.vpc_id
#}
#
#module "shipping" {
#    #source = "../../naresh-terraform-aws-securitygroup"
#    source = "git::https://github.com/Nareshkumart19/naresh-terraform-aws-securitygroup.git?ref=main"
#    project = var.project
#    environment = var.environment
#    
#    sg_name = "shipping"
#    sg_description = "for shipping"
#    vpc_id = local.vpc_id
#}
#module "payment" {
#    #source = "../../naresh-terraform-aws-securitygroup"
#    source = "git::https://github.com/Nareshkumart19/naresh-terraform-aws-securitygroup.git?ref=main"
#    project = var.project
#    environment = var.environment
#    
#    sg_name = "payment"
#    sg_description = "for payment"
#    vpc_id = local.vpc_id
#}


#module "frontend" {
#    #source = "../../naresh-terraform-aws-securitygroup"
#    #source = "git::https://github.com/Nareshkumart19/terraform-aws-securitygroup.git?ref=main"
#    source = "git::https://github.com/Nareshkumart19/naresh-terraform-aws-securitygroup.git?ref=main"
#    project = var.project
#    environment = var.environment
#    
#    
#    sg_name = var.frontend_sg_name
#    sg_description = var.frontend_sg_description
#    vpc_id = local.vpc_id
#    #vpc_id = "vpc-04185ddaf2bc0c619"   i did  my self
#}
#
#module "frontend_alb" {
#    #source = "../../terraform-aws-securitygroup"
#    source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
#    project = var.project
#    environment = var.environment
#
#    sg_name = "frontend-alb"
#    sg_description = "for frontend alb"
#    vpc_id = local.vpc_id
#}

module "bastion" {
    #source = "../../naresh-terraform-aws-securitygroup"
    source = "git::https://github.com/Nareshkumart19/naresh-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    
    
    sg_name = var.bastion_sg_name
    sg_description = var.bastion_sg_description
    vpc_id = local.vpc_id
}


module "backend_alb" {
    #source = "../../naresh-terraform-aws-securitygroup"
    source = "git::https://github.com/Nareshkumart19/naresh-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    
    sg_name = "backend-alb"
    sg_description = "for bakend alb"
    vpc_id = local.vpc_id
}

#module "vpn" {
    ##source = "../../naresh-terraform-aws-securitygroup"
    #source = "git::https://github.com/Nareshkumart19/naresh-terraform-aws-securitygroup.git?ref=main"
    #project = var.project
    #environment = var.environment
##
    #sg_name = "vpn"
    #sg_description = "for vpn"
    #vpc_id = local.vpc_id
#}



#================= port openings


# ports opening mongodb , reids  mysql  rabittmq  .

# mongodb
resource "aws_security_group_rule" "mangodb_bastion_ssh" {
  count = length(var.mongodb_ports_bastion)
  type              = "ingress"
  from_port         = var.mongodb_ports_bastion[count.index]
  to_port           = var.mongodb_ports_bastion[count.index]
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.mongodb.sg_id
}

resource "aws_security_group_rule" "mongodb_catalogue" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = module.catalogue.sg_id  
  security_group_id = module.mongodb.sg_id
}


#resource "aws_security_group_rule" "mongodb_user" {
#  type              = "ingress"
#  from_port         = 27017
#  to_port           = 27017
#  protocol          = "tcp"
#  source_security_group_id = module.user.sg_id
#  security_group_id = module.mongodb.sg_id
#}

## redis 
# resource "aws_security_group_rule" "redis_bastion_ssh" {
#  count = length(var.redis_ports_bastion)
#  type              = "ingress"
#  from_port         = var.redis_ports_bastion[count.index]
#  to_port           = var.redis_ports_bastion[count.index]
#  protocol          = "tcp"
#  source_security_group_id = module.bastion.sg_id
#  security_group_id = module.redis.sg_id
# }
# 
# resource "aws_security_group_rule" "redis_user" {
#  type              = "ingress"
#  from_port         = 6379
#  to_port           = 6379
#  protocol          = "tcp"
#  source_security_group_id = module.user.sg_id
#  security_group_id = module.redis.sg_id
# }
# 
# resource "aws_security_group_rule" "redis_cart" {
#  type              = "ingress"
#  from_port         = 6379
#  to_port           = 6379
#  protocol          = "tcp"
#  source_security_group_id = module.cart.sg_id
#  security_group_id = module.redis.sg_id
# }
# 
# 
##mysql
# resource "aws_security_group_rule" "mysql_bastion_ssh" {
#  count = length(var.mysql_ports_bastion)
#  type              = "ingress"
#  from_port         = var.mysql_ports_bastion[count.index]
#  to_port           = var.mysql_ports_bastion[count.index]
#  protocol          = "tcp"
#  source_security_group_id = module.bastion.sg_id
#  security_group_id = module.mysql.sg_id
# }
# 
# resource "aws_security_group_rule" "mysql_shipping" {
#  type              = "ingress"
#  from_port         = 3306
#  to_port           = 3306
#  protocol          = "tcp"
#  source_security_group_id = module.shipping.sg_id
#  security_group_id = module.mysql.sg_id
# }
# 
# 
##rabbitmq
# 
# resource "aws_security_group_rule" "rabbitmq_bastion_ssh" {
#  count = length(var.rabbitmq_ports_bastion)
#  type              = "ingress"
#  from_port         = var.rabbitmq_ports_bastion[count.index]
#  to_port           = var.rabbitmq_ports_bastion[count.index]
#  protocol          = "tcp"
#  source_security_group_id = module.bastion.sg_id
#  security_group_id = module.rabbitmq.sg_id
# }
# 
# resource "aws_security_group_rule" "rabbitmq_payment" {
#  type              = "ingress"
#  from_port         = 5672
#  to_port           = 5672
#  protocol          = "tcp"
#  source_security_group_id = module.payment.sg_id
#  security_group_id = module.rabbitmq.sg_id
# }

#application servers port opening 

# catalogue

resource "aws_security_group_rule" "catalogue_bastion_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.catalogue.sg_id
}

resource "aws_security_group_rule" "catalogue_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id  
  security_group_id = module.catalogue.sg_id
}


# user 

 #resource "aws_security_group_rule" "user_bastion_ssh" {
 # type              = "ingress"
 # from_port         = 22
 # to_port           = 22
 # protocol          = "tcp"
 # source_security_group_id = module.bastion.sg_id
 # security_group_id = module.user.sg_id
 #}
 #
 #resource "aws_security_group_rule" "user_backend_alb" {
 # type              = "ingress"
 # from_port         = 8080
 # to_port           = 8080
 # protocol          = "tcp"
 # source_security_group_id = module.backend_alb.sg_id
 # security_group_id = module.user.sg_id
 #}
 
  #cart
 
 #resource "aws_security_group_rule" "cart_bastion_ssh" {
 # type              = "ingress"
 # from_port         = 22
 # to_port           = 22
 # protocol          = "tcp"
 # source_security_group_id = module.bastion.sg_id
 # security_group_id = module.cart.sg_id
 #}
 #
 #resource "aws_security_group_rule" "cart_backend_alb" {
 # type              = "ingress"
 # from_port         = 8080
 # to_port           = 8080
 # protocol          = "tcp"
 # source_security_group_id = module.backend_alb.sg_id
 # security_group_id = module.cart.sg_id
 #}
 #
##shipping 
 #
 #resource "aws_security_group_rule" "shipping_bastion_ssh" {
 # type              = "ingress"
 # from_port         = 22
 # to_port           = 22
 # protocol          = "tcp"
 # source_security_group_id = module.bastion.sg_id
 # security_group_id = module.shipping.sg_id
 #}
 #
 #resource "aws_security_group_rule" "shipping_backend_alb" {
 # type              = "ingress"
 # from_port         = 8080
 # to_port           = 8080
 # protocol          = "tcp"
 # source_security_group_id = module.backend_alb.sg_id
 # security_group_id = module.shipping.sg_id
 #}
 #
##payment
 #
 #resource "aws_security_group_rule" "payment_bastion_ssh" {
 # type              = "ingress"
 # from_port         = 22
 # to_port           = 22
 # protocol          = "tcp"
 # source_security_group_id = module.bastion.sg_id
 # security_group_id = module.payment.sg_id
 #}
 #
 #resource "aws_security_group_rule" "payment_backend_alb" {
 # type              = "ingress"
 # from_port         = 8080
 # to_port           = 8080
 # protocol          = "tcp"
 # source_security_group_id = module.backend_alb.sg_id
 # security_group_id = module.payment.sg_id
 #}
# 
#Backend ALB

resource "aws_security_group_rule" "backend_alb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.backend_alb.sg_id
}
#
#resource "aws_security_group_rule" "backend_alb_frontend" {
#  type              = "ingress"
#  from_port         = 80
#  to_port           = 80
#  protocol          = "tcp"
#  source_security_group_id = module.frontend.sg_id
#  security_group_id = module.backend_alb.sg_id
#}
#
#resource "aws_security_group_rule" "backend_alb_cart" {
#  type              = "ingress"
#  from_port         = 80
#  to_port           = 80
#  protocol          = "tcp"
#  source_security_group_id = module.cart.sg_id
#  security_group_id = module.backend_alb.sg_id
#}
#
#resource "aws_security_group_rule" "backend_alb_shipping" {
#  type              = "ingress"
#  from_port         = 80
#  to_port           = 80
#  protocol          = "tcp"
#  source_security_group_id = module.shipping.sg_id
#  security_group_id = module.backend_alb.sg_id
#}
#
#resource "aws_security_group_rule" "backend_alb_payment" {
#  type              = "ingress"
#  from_port         = 80
#  to_port           = 80
#  protocol          = "tcp"
#  source_security_group_id = module.payment.sg_id
#  security_group_id = module.backend_alb.sg_id
#}


#Frontend


#resource "aws_security_group_rule" "frontend_bastion" {
#  type              = "ingress"
#  from_port         = 22
#  to_port           = 22
#  protocol          = "tcp"
#  source_security_group_id = module.bastion.sg_id
#  security_group_id = module.frontend.sg_id
#}
#
#resource "aws_security_group_rule" "frontend_frontend_alb" {
#  type              = "ingress"
#  from_port         = 80
#  to_port           = 80
#  protocol          = "tcp"
#  source_security_group_id = module.frontend_alb.sg_id
#  security_group_id = module.frontend.sg_id
#}
#
#
##Frontend ALB
#resource "aws_security_group_rule" "frontend_alb_http" {
#  type              = "ingress"
#  from_port         = 80
#  to_port           = 80
#  protocol          = "tcp"
#  cidr_blocks = ["0.0.0.0/0"]
#  security_group_id = module.backend_alb.sg_id
#}
#
#resource "aws_security_group_rule" "frontend_alb_https" {
#  type              = "ingress"
#  from_port         = 443
#  to_port           = 443
#  protocol          = "tcp"
#  cidr_blocks = ["0.0.0.0/0"]
#  security_group_id = module.frontend_alb.sg_id
#}
#
##backend ALB accepting connection from my bastion host to port no 80
#resource "aws_security_group_rule" "bastion_laptop" {
#  type              = "ingress"
#  from_port         = 22
#  to_port           = 22
#  protocol          = "tcp"
#  cidr_blocks       = ["0.0.0.0/0"]
#  security_group_id = module.bastion.sg_id
#}

# bastion accepiting connection from my latop
resource "aws_security_group_rule" "bastion_laptop" {
 type              = "ingress"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 cidr_blocks       = ["0.0.0.0/0"]
 security_group_id = module.bastion.sg_id
}


 # nenu vpn nundi chyaledhu
# resource "aws_security_group_rule" "catalogue_vpn_ssh" {
  # type              = "ingress"
  # from_port         = 22
  # to_port           = 22
  # protocol          = "tcp"
  # source_security_group_id = module.vpn.sg_id  
  # security_group_id = module.catalogue.sg_id
# }
# resource "aws_security_group_rule" "catalogue_vpn_http" {
  # type              = "ingress"
  # from_port         = 8080
  # to_port           = 808
  # protocol          = "tcp"
  # source_security_group_id = module.vpn.sg_id  
  # security_group_id = module.catalogue.sg_id
# }




