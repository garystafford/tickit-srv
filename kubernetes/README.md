# Kubernetes Commands Used in Demonstration

All commands made from root of project.

```shell
export NAMESPACE=tickit

# Namespace
kubectl create namespace ${NAMESPACE}

# Role and RoleBinding for GitHub Actions to deploy to Amazon EKS
kubectl apply -f kubernetes/github_actions_role.yml -n ${NAMESPACE}

# Secret
kubectl apply -f kubernetes/secret.yml -n ${NAMESPACE}

# Command used by GitHub Action to deploy Quarkus application
kubectl apply -f build/kubernetes/kubernetes.yml -n ${NAMESPACE}
```
