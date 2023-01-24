provider "helm" {
  kubernetes {
    host                   = "https://${google_container_cluster.primary.endpoint}"
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = []
      command     = "gke-gcloud-auth-plugin"
    }
  }
}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.primary.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = []
    command     = "gke-gcloud-auth-plugin"
  }
}

resource "random_password" "argocd_admin_password" {
  length      = 16
  min_lower   = 1
  min_upper   = 1
  min_special = 1
  min_numeric = 1
  special     = true
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  wait             = true
  create_namespace = true

  values = [
    templatefile("${path.module}/templates/argocd_install_values.tfpl", {
      # ArgoCD password should bcrypt hashes
      argocdAdminPassword = random_password.argocd_admin_password.bcrypt_hash
    })
  ]
}

data "kubernetes_service" "argocd" {
  depends_on = [
    helm_release.argocd
  ]
  metadata {
    name      = "argocd-server"
    namespace = "argocd"
  }
}
