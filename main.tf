terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.35.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }
}

provider "aws" {
  region     = "eu-west-1"
}

data "aws_eks_cluster" "cluster" {
  name = "eks_infra"
}

data "aws_eks_cluster_auth" "cluster" {
  name = "eks_infra"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

