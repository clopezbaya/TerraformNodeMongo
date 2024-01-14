# Outputs con IP publica y DNS de la instancia de NODE
output "public_ip_node" {
  value = aws_instance.node_app.public_ip
}

output "public_dns_node" {
  value = aws_instance.node_app.public_dns
}

# Outputs con IP publica y DNS de la instancia de MONGO
output "public_ip_mongo" {
  value = aws_instance.mongo_db.public_ip
}

output "public_dns_mongo" {
  value = aws_instance.mongo_db.public_dns
}