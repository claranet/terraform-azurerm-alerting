# Unreleased

Changed
  * [GITHUB-2](https://github.com/claranet/terraform-azurerm-alerting/pull/2): Add support for metric alerts

# v7.1.0 - 2023-01-18

Added
  * AZ-979: Add missing `status` parameter for activity log alert resource

# v7.0.0 - 2022-12-23

Breaking
  * AZ-840: Require Terraform 1.3+

Changed
  * AZ-840: Replace `any` types by `objects` on variables

# v5.1.0 - 2022-11-23

Changed
  * AZ-908: Use the new data source for CAF naming (instead of resource)

# v5.0.0 - 2022-02-03

Breaking
  * AZ-515: Option to use Azure CAF naming provider to name resources
  * AZ-515: Require Terraform 0.13+

Added
  * AZ-615: Add an option to enable or disable default tags

Changed
  * AZ-572: Revamp examples and improve CI

# v4.1.1 - 2021-08-27

Changed
  * AZ-532: Revamp README with latest `terraform-docs` tool

# v4.1.0 - 2021-05-11

Added:
  * [GITHUB-1](https://github.com/claranet/terraform-azurerm-alerting/issues/1): `service_health` variable to populated the new available block

Breaking
  * [GITHUB-1](https://github.com/claranet/terraform-azurerm-alerting/issues/1): AzureRM provider `v2.56.0` minimum version required, it fixes the issue with `service_health` block

# v3.0.1/v4.0.0 - 2020-10-20

Changed
  * AZ-273: Update README and CI, module compatible Terraform 0.13+ (now requires Terraform 0.12.26 minimum version)

# v2.0.1/v3.0.0 -  2020-07-09

Fixed
  *  AZ-191: Advisor alerts documentation

# v2.0.0 -  2020-03-25

Added
  * AZ-191: Azure Alerting - First Release
