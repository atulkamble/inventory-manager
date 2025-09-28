module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.8.4"

  cluster_name    = var.cluster_name
  cluster_version = "1.32"

  subnet_ids      = aws_subnet.public[*].id
  vpc_id          = aws_vpc.main.id

  enable_irsa     = true

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false

  eks_managed_node_group_defaults = {
    instance_type = "t3.medium"
  }

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
