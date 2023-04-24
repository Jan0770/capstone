resource "aws_rds_cluster" "auroracluster" {
  cluster_identifier        = "auroracluster"
  availability_zones        = var.availability_zones

  engine                    = var.aurora_engine
  engine_version            = var.aurora_engine_version
  
  database_name             = "auroradb"
  master_username           = "test"
  master_password           = "mustbeeightcharaters"

  skip_final_snapshot       = true
  final_snapshot_identifier = "aurora-final-snapshot"

  db_subnet_group_name = var.database_subnets

  vpc_security_group_ids = [aws_security_group.allow_aurora_access.id]

  tags = {
    Name = "auroracluster-db"
  }
}

resource "aws_rds_cluster_instance" "clusterinstance" {
  count              = 2
  identifier         = "clusterinstance-${count.index}"
  cluster_identifier = aws_rds_cluster.auroracluster.id
  instance_class     = "db.t3.small"
  engine             = "aurora-mysql"
  availability_zone  = "us-west-2${count.index == 0 ? "a" : "b"}"

  tags = {
    Name = "auroracluster-db-instance${count.index + 1}"
  }
}
