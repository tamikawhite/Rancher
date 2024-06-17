#!/bin/bash

# Add Rancher stable repository
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable

# Create namespace for Rancher
kubectl create namespace cattle-system

# Apply Cert-Manager Custom Resource Definitions (CRDs)
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.14.1/cert-manager.crds.yaml

# Create namespace for Cert-Manager
kubectl create namespace cert-manager

# Add Jetstack repository
helm repo add jetstack https://charts.jetstack.io

# Update Helm repositories
helm repo update

# Install Cert-Manager
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.14.1

# Install Rancher
helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=ranchersrv-1.westus.cloudapp.azure.com \
  --set replicas=2 \
  --set bootstrapPassword=admin

echo "Script execution completed!"
