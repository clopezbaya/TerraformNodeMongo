#!/bin/bash
sudo yum update -y
# Instalar MongoDB en Rocky Linux
sudo tee /etc/yum.repos.d/mongodb-org-7.0.repo << EOF
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2023/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-7.0.asc
EOF

# Instalar MongoDB en Rocky Linux
sudo yum install -y mongodb-org

# Reiniciar el servicio MongoDB para aplicar la configuración
sudo yum remove mongodb-mongosh -y
sudo yum install mongodb-mongosh-shared-openssl3 -y
sudo yum install mongodb-mongosh -y

sudo yum install -y mongodb-org
# Iniciar el servicio MongoDB
sudo systemctl start mongod
# Habilitar el servicio para que inicie en el arranque
sudo systemctl enable mongod

# Crear un usuario y una base de datos con los datos proporcionados
mongosh --eval 'db.createUser({user: "christian-unir", pwd: "unir12345", roles: [{role: "readWrite", db: "test"}]})'

# Configurar MongoDB para aceptar conexiones remotas
sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf