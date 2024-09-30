<!-- trunk-ignore-all(prettier) -->
# terragrunt-azure

Terragrunt Azure IaC


## Table with links to Terraform Cloud, Terramate, Trunk and Spacelift Dashboards
## Table with links to Terraform Cloud, Terramate, Trunk and Spacelift Dashboards

| Service           | Link                                      |
|-------------------|-------------------------------------------|
| Terraform Cloud   | [Terraform Cloud Dashboard](https://app.terraform.io) |
| Terramate         | [Terramate Dashboard](https://terramate.io) |
| Trunk             | [Trunk Dashboard](https://app.trunk.io)       |
| Spacelift         | [Spacelift Dashboard](https://spacelift.io) |


## Connect to Azure

1. First Login to Azure

```bash
az login
```
2. You will be prompted something like:

```bash
Select the account you want to log in with. For more information on login with Azure CLI, see https://go.microsoft.com/fwlink/?linkid=2271136
```

## TUTORIALS

### AKS
- [Tutorial](https://techcommunity.microsoft.com/t5/azure-for-isv-and-startups/how-to-deploy-a-production-ready-aks-cluster-with-terraform/ba-p/4122013)

### E2E TESTS

- [Tutorial](https://azure.github.io/Azure-Verified-Modules/contributing/terraform/terraform-contribution-flow/#42-run-e2e-tests)


### AZURE REGIONS

- [Repo con la lista](https://gist.github.com/ausfestivus/04e55c7d80229069bf3bc75870630ec8)
- Francia Central  = `francecentral` (con Availibility Zones)
- Espana Central = `spaincentral` (sin Availibility Zones)

### TRUNK CLI
<!-- trunk-ignore(markdownlint/MD047) -->
- [Trunk CLI](https://fig.io/manual/trunk/check)