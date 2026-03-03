# DevOps Engineer Project

End-to-end DevOps implementation of a containerized microservices system deployed on ROSA AWS (Kubernetes) with full CI/CD automation and environment separation (QA, UAT, PROD).

---

# Architecture Overview

This project demonstrates:

- Containerized services(names I used are for testing purposes)
- Docker image build & push to AWS ECR
- ROSA AWS Kubernetes deployments
- Infrastructure as Code
- CI/CD pipelines using GitHub Actions
- Multi-environment strategy (QA / UAT / PROD)

---

# Repository Structure
<details>

<Summary>Click to expand the Repository Structure</summary>



The repository is structured into two main domains:`aplication` and `infrastructure`. The `application` directory contains service source code, Dockerfiles, and Ansible playbooks for environment-specific deployments(`qa`,`uat`,`prod`). The `infrastructure` directory manages cluster provisioning and configuration using Terraform Ansible,with separate inventories per environment. This structure cleanly separates application deployment logic from infrastructure provisioning.

```
the-project/
├── application
│   ├── ansible
│   │   ├── inventories
│   │   │   ├── prod
│   │   │   │   └── hosts.yml
│   │   │   ├── qa
│   │   │   │   └── hosts.yml
│   │   │   └── uat
│   │   │       └── hosts.yml
│   │   └── playbooks
│   │       ├── deploy-app.yml
│   │       └── roles
│   │           └── kubernetes-deploy
│   │               ├── defaults
│   │               │   └── main.yml
│   │               ├── files
│   │               ├── handlers
│   │               │   └── main.yml
│   │               ├── meta
│   │               │   └── main.yml
│   │               ├── README.md
│   │               ├── tasks
│   │               │   └── main.yml
│   │               ├── templates
│   │               │   ├── deployment.yml.j2
│   │               │   ├── frontend-ingress.yml.j2
│   │               │   ├── networkpolicy.yml.j2
│   │               │   └── service.yml.j2
│   │               ├── tests
│   │               │   ├── inventory
│   │               │   └── test.yml
│   │               └── vars
│   │                   └── main.yml
│   ├── api
│   │   ├── Dockerfile
│   │   └── src
│   ├── frontend
│   │   ├── Dockerfile
│   │   └── src
│   └── worker
│       ├── Dockerfile
│       └── src
├── infrastructure
│   └── cluster
│       ├── ansible
│       │   ├── inventories
│       │   │   ├── cluster-prod
│       │   │   │   └── hosts.yaml
│       │   │   ├── cluster-qa
│       │   │   │   └── hosta.yaml
│       │   │   └── cluster-uat
│       │   │       └── hosts.yaml
│       │   └── playbooks
│       │       ├── cluster-config
│       │       │   ├── defaults
│       │       │   │   └── main.yml
│       │       │   ├── files
│       │       │   ├── handlers
│       │       │   │   └── main.yml
│       │       │   ├── meta
│       │       │   │   └── main.yml
│       │       │   ├── README.md
│       │       │   ├── tasks
│       │       │   │   └── main.yml
│       │       │   ├── templates
│       │       │   ├── tests
│       │       │   │   ├── inventory
│       │       │   │   └── test.yml
│       │       │   └── vars
│       │       │       └── main.yml
│       │       └── config-cluster.yaml
│       └── terraform
│           ├── main.tf
│           ├── provider.tf
│           ├── README.md
│           ├── test.tfvars
│           └── variables.tf
```

</details>