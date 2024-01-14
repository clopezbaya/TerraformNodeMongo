# Definicion del Provider
provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

# Aclaracion de nuestro SecurityGroup existente en AWS
data "aws_security_group" "existing_sg" {
  name = var.security_group_name
}

# Definicion de la instancia a lanzarse de MONGODB
resource "aws_instance" "mongo_db" {
  ami           = var.ami_id_mongo
  instance_type = var.instance_type 
  key_name      = var.key_instance 
  vpc_security_group_ids = [var.vpc_security_group_id]
  subnet_id              = var.subnet_id
  private_ip    = "172.31.2.28"
  associate_public_ip_address = true
  tags = {
    Name = "mongo-db-instance"
  }
}

# Definicion de la instancia a lanzarse de NODEJS
resource "aws_instance" "node_app" {
  ami           = var.ami_id_node
  instance_type = var.instance_type 
  key_name      = var.key_instance   
  vpc_security_group_ids = [var.vpc_security_group_id]
  subnet_id              = var.subnet_id
  private_ip    = "172.31.2.29"
  associate_public_ip_address = true
  tags = {
    Name = "node-app-instance"
  }
}

# # Definición del balanceador de carga
# resource "aws_lb" "loadbalancing" {
#   name               = "load-balancer-node-mongo"
#   internal           = false
#   load_balancer_type = "application"
#   subnets            = [var.subnet_id_mongo,var.subnet_id_node]
#   enable_deletion_protection = false
# }

# # Definición de grupo de destinos para instancias de Node.js
# resource "aws_lb_target_group" "node_app" {
#   name     = "node-app-target-group"
#   port     = 3000
#   protocol = "HTTP"
#   vpc_id   = var.vpc_id

#   health_check {
#     path        = "/"
#     interval    = 30
#     timeout     = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#   }
# }

# # Definición de regla de escucha para instancias de Node.js
# resource "aws_lb_listener" "node_app" {
#   load_balancer_arn = aws_lb.loadbalancing.arn
#   port              = 3000
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.node_app.arn
#   }
# }

# # Asociar instancias de Node.js al grupo de destinos
# resource "aws_lb_target_group_attachment" "node_app" {
#   count             = 2
#   target_group_arn = aws_lb_target_group.node_app.arn
#   target_id        = aws_instance.node_app.id
# }

# # Asociar instancia de MongoDB al grupo de destinos 
# resource "aws_lb_target_group_attachment" "mongo_db" {
#   target_group_arn = aws_lb_target_group.node_app.arn
#   target_id        = aws_instance.mongo_db.id
# }