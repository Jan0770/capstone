resource "aws_rds_cluster" "auroracluster" {
  cluster_identifier        = "auroracluster"
  availability_zones        = var.availability_zones

  engine                    = var.aurora_engine
  engine_version            = var.aurora_engine_version
  
  database_name             = var.database_name
  master_username           = var.master_user
  master_password           = var.master_password

  skip_final_snapshot       = true
  final_snapshot_identifier = "aurora-final-snapshot"

  db_subnet_group_name = aws_db_subnet_group.db_net.id

  vpc_security_group_ids = [aws_security_group.aurora_security.id]

  tags = {
    Name = "auroracluster"
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
    Name = "aurora_${count.index + 1}"
  }
}
