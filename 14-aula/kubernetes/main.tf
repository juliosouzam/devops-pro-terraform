terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.24.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_service" "web_page_service" {
  metadata {
    name = "web-page"
  }
  spec {
    selector = {
      app = kubernetes_deployment.web_page.spec.0.template.0.metadata.0.labels.app
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_deployment" "web_page" {
  metadata {
    name = "web-page"
  }

  spec {
    replicas = 5

    selector {
      match_labels = {
        app = "web-page"
      }
    }

    template {
      metadata {
        labels = {
          app = "web-page"
        }
      }

      spec {
        container {
          image = "nginx:alpine"
          name  = "web-page"
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "web_page_ingress" {
  metadata {
    name = "web-page"
  }

  spec {
    ingress_class_name = "nginx"

    rule {
      host = "web.167.172.0.113.nip.io"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.web_page_service.metadata.0.name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
