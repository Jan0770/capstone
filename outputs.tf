output "rds_endpoint" {
    description = "RDS endpoint of the writer instance"
    value = aws_rds_cluster_instance.clusterinstance[0].endpoint
}

        # Database #
output "database_name" {
  value = "capstoneDB"
}

output "db_user" {
  value = "capstoneRoot"
}

output "db_password" {
  value = "mustbeeightcharacters"
}
