variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "the region or zone where the cluster will be created"
  default     = "asia-south1"
}

variable "cluster_name" {
  description = "the gke cluster name"
  default     = "my-demos"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

# gcloud compute machine-types list
variable "machine_type" {
  description = "the google cloud machine types for each cluster node"
  # https://cloud.google.com/compute/docs/general-purpose-machines#e2_machine_types
  default = "e2-standard-4"
}

variable "kubernetes_version" {
  description = "the kubernetes versions of the GKE clusters"
  # kubernetes version to use, major.minor
  default = "1.23."
}

variable "release_channel" {
  description = "the GKE release channel to use"
  type        = string
  default     = "stable"
}

variable "gitops_repo" {
  description = "The GitHub repository to use as the source for GitOps"
  default     = "https://github.com/kameshsampath/gitops-quickstart.git"
}

variable "gitops_repo_revision" {
  description = "The GitOps repository revision"
  default     = "main"
}

variable "argocd_app_name" {
  description = "The ArgoCD application name for the app of apps. The same will be used as the base project name i.e. the project that houses App of Apps."
  default     = "gitops-kickstarter"
}

variable "hello_world_image_repo" {
  description = "The container registry repository where the hello world application will be pushed. e.g. docker.io/kameshsampath/go-hello-world"
}