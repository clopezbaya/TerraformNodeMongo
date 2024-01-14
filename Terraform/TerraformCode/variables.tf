# Definicion de la region
variable "region" {
  default = "sa-east-1"
}

# Definicion del tipo de instancia
variable "instance_type" {
  default = "t2.micro"
}

# Claves de AWS
variable "access_key" {
  default = "AKIAVRUVTHSYUMBADYOA"
}

variable "secret_key" {
  default = "qT60Ba2sFvm+JQTVsv/eZUFSJlp4WDkCdEHjBxr6"
}

# Nombre del SecurityGroup definido previamente en AWS
variable "security_group_name" {
  default = "securityGroup"
}

# ID del SecurityGroup definido previamente en AWS
variable "vpc_security_group_id" {
  default = "sg-05efbdddbed812225"
}

# Subred de nuestro Security Group AWS
variable "subnet_id" {
  default = "subnet-072ec63b011b53fe0"
}

# Key la cual se usara para conectarse via SSH
variable "key_instance" {
  default = "newKey" 
}

# ID Imagen de Node
variable "ami_id_node" {
  default = "ami-0185b4f38a3e23455" 
}

# ID Imagen de Mongo
variable "ami_id_mongo" {
  default = "ami-0000dcfd53a621ba9" 
}

# variable "subnet_id_node" {
#   default = "subnet-0a81d25bb0e324be7"
# }

# variable "vpc_id" {
#   default = "vpc-0893b451633afb18b"
# }