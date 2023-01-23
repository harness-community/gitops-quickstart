# GitOps Kickstarter

A set of resources, components and scripts to get started with applying GitOps principles.

This kickstart repository resources that will setup the base infrastructure that is needed to get started with GitOps by deploying an ArgoCD base [App of Apps](https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/#app-of-apps) which deploys,

- [ArgoCD](https://argo-cd.readthedocs.io/) [Image Updater](https://argocd-image-updater.readthedocs.io/en/stable/)
- [Sigstore](https://sigstore.dev) [Policy Controller](https://github.com/sigstore/policy-controller)

## Pre-requisites

- [Google Cloud Account](https://cloud.google.com)
- [terraform](https://terraform.build)
- [helm](https://helm.sh)
- [kustomize](https://kustomize.io)
- [direnv](https://direnv.net) **Optional**

## Kubernetes Cluster

Running the following command which will setup a GKE cluster using terraform,

```shell
make init apply
```

### ArgoCD Deployment Details

#### Admin Password

```shell
terraform output -raw argocd_admin_password
```

#### ArgoCD Application URL

```shell
terraform output -raw argocd_service_url
```

## Clean up

```shell
make destroy
```

## Troubleshooting

- [Cosigned Helm Chart - tls: no certificates configured](https://github.com/sigstore/policy-controller/issues/369)

```shell
kubectl delete leases.coordination.k8s.io -n cosign-system --all
```
