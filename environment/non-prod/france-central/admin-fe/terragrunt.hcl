include "root" {
  path = find_in_parent_folders()
}

terraform {
     source = "../../../..//modules/${basename(get_terragrunt_dir())}"
}

inputs = merge(
  yamldecode(file("${find_in_parent_folders("common.yaml")}")),
  yamldecode(file("${find_in_parent_folders("environment.yaml")}"))
)