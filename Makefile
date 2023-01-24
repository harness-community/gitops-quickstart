SHELL := /usr/bin/env bash
# ENV_FILE := .env
# include ${ENV_FILE}
# export $(shell sed 's/=.*//' ${ENV_FILE})
CURRENT_DIR = $(shell pwd)
TFVARS_FILE ?= terraform.tfvars

help: ## Show this help
		@echo Please specify one or more build target. The choices are:
		@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "$(INFO_COLOR)%-30s$(NO_COLOR) %s\n", $$1, $$2}'

argoAdminPassword:	## Decrypt and show ArgoCD admin password
	@terraform output -raw argocd_admin_password

clean:	## Clean up all terraform resources
	rm -rf .terraform .terraform.lock.hcl	.tfplan

format:	## Run terraform format
	@terraform fmt --recursive $(CURRENT_DIR)

init:	## Run terraform init
	@terraform init

.tfplan:	format	## Plan the terraform deployment
	@terraform plan -var-file="$(TFVARS_FILE)" -out ".tfplan"

validate:	format	## Run terraform validate to ensure all resources are valid
	@terraform validate

apply:## Create the resources using existing plan file ".tfplan"
	@terraform apply -var-file="$(TFVARS_FILE)"

plan:	validate	.tfplan	## Create the dpeloyment plan ; GKE, deploy ArgoCD, create App of Apps

destroy:	## Destroys and cleans up the resources created by terraform
	@terraform apply -destroy -var-file="$(TFVARS_FILE)"

.PHONY:	argoAdminPassword	clean	create	destroy	format	help	plan	init	format	validate