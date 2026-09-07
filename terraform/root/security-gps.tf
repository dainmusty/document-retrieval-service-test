
# # Security Groups Module

# # WEB SG
module "web_sg" {
  source = "../modules/security/web"
  vpc_id              = module.vpc.vpc_id
  env                 = "blueeagle-prod"
  security_group_name = "blueeagle-prod-app-sg"

  web_ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      from_port                 = 8080
      to_port                   = 8080
      protocol                  = "tcp"
      source_security_group_ids = [module.alb_sg.alb_sg_id]
      description               = "Allow traffic from ALB"
    },

  ]

  web_egress_rules = [
    {
      description = "Allow all egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  web_sg_tags = {
    Name        = "web-sg"
    Environment = "Dev"
  }

}



# # ALB SG
module "alb_sg" {
  source = "../modules/security/alb"
  vpc_id              = module.vpc.vpc_id
  env                 = "blueeagle-prod"
  security_group_name = "blueeagle-prod-web-sg"

  alb_sg_ingress_rules = [
    {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  alb_sg_egress_rules = [
    {
      description = "Allow all egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  alb_sg_tags = {
    "Name"        = "alb-sg"
    "Project"     = "document-retrieval-service-test"
    "Environment" = "dev"
    "ManagedBy"   = "terraform"
  }

}
