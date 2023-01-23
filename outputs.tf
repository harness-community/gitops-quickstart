output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "zone" {
  value       = local.google_zone
  description = "GCloud Zone"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.primary.endpoint
  description = "GKE Cluster Host"
}

output "kubeconfig_path" {
  value       = abspath(local_file.kubeconfig.filename)
  description = "Kubeconfig file"
}

output "argocd_admin_password" {
  value       = random_password.argocd_admin_password.result
  sensitive   = true
  description = "ArgoCD admin password"
}

output "argocd_service_url" {
  value       = length(data.kubernetes_service.argocd.status) > 0 ? "http://${data.kubernetes_service.argocd.status.0.load_balancer.0.ingress.0.ip}" : "no service available"
  description = "ArgoCD service URL"
}
