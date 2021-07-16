variable "commit" {
  type = string
  description = "The Current commit."
}

resource "kubernetes_deployment" "infra-web" {
  metadata {
    name = "infra-web"
    labels = {
      app = "infra"
      run = "infra-web"
    }
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app  = "infra"
        tier = "web"
      }
    }
    template {
      metadata {
        labels = {
          app  = "infra"
          tier = "web"
        }
      }
      spec {
        container {
          name  = "infra-web-${var.commit}"
          image = "363724809304.dkr.ecr.eu-west-1.amazonaws.com/application:latest"
          resources {
            requests = {
              cpu = "200m"
            }
          }

        }
        node_selector = {
          "type" = "web"
        }
      }
    }
  }
}

resource "kubernetes_service" "infra-web" {
  metadata {
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb"
    }
    name = "infra-web"
    labels = {
      "app" = "infra"
    }
  }
  spec {
    port {
      port     = 80
      protocol = "TCP"
    }
    selector = {
      "app" = "infra"
    }
    type = "LoadBalancer"
  }
}

output "service" {
  value = kubernetes_service.infra-web
}
output "hostname" {
  value = kubernetes_service.infra-web[*].status[*].load_balancer[*].ingress[*].hostname
}