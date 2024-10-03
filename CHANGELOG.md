## 7.4.0 (2024-10-03)

### Features

* use Claranet "azurecaf" provider fe3da7d

### Documentation

* update README badge to use OpenTofu registry 293c853
* update README with `terraform-docs` v0.19.0 522d74f

### Miscellaneous Chores

* **deps:** update dependency terraform-docs to v0.19.0 14e290f
* **deps:** update dependency trivy to v0.55.2 e80ebea
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.1 9f2faa9

## 7.3.0 (2024-09-16)

### Features

* **AZ-1454:** add support of location variable 0667029

### Bug Fixes

* **AZ-1454:** fix bad types on service_health variable 55f4f52

### Miscellaneous Chores

* **AZ-1454:** rename location variable 758d00e
* **deps:** update dependency opentofu to v1.8.2 74afa4d
* **deps:** update dependency trivy to v0.55.0 a6090aa
* **deps:** update dependency trivy to v0.55.1 91bb105
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.18.0 5923330
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.1 2de6dbb
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.2 869270a
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.3 1a4901c
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.95.0 33d079d
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.0 70f9cdf

## 7.2.2 (2024-08-30)

### Bug Fixes

* pin AzureRM provider to v3 a899e09

### Miscellaneous Chores

* **deps:** update dependency tflint to v0.53.0 a9160b5
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.17.0 65d6146
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.2 69371b5
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.0 974ad68

## 7.2.1 (2024-08-09)


### Bug Fixes

* **GH-3:** add missing metric alerts output 0287391


### Documentation

* **GH-3:** update README and example 8a1c26f


### Continuous Integration

* **AZ-1391:** enable semantic-release [skip ci] 0ffeb69
* **AZ-1391:** update semantic-release config [skip ci] de388c4


### Miscellaneous Chores

* **deps:** add renovate.json 3a74a53
* **deps:** enable automerge on renovate 20bcd2e
* **deps:** update dependency opentofu to v1.7.0 81ca05b
* **deps:** update dependency opentofu to v1.7.1 0a57cf0
* **deps:** update dependency opentofu to v1.7.2 e814c77
* **deps:** update dependency opentofu to v1.7.3 70e63d7
* **deps:** update dependency opentofu to v1.8.0 173b12d
* **deps:** update dependency opentofu to v1.8.1 a0e47e9
* **deps:** update dependency pre-commit to v3.7.1 ea013f8
* **deps:** update dependency pre-commit to v3.8.0 57cd31c
* **deps:** update dependency terraform-docs to v0.18.0 4a8b103
* **deps:** update dependency tflint to v0.51.0 7c39cbe
* **deps:** update dependency tflint to v0.51.1 a9d3a41
* **deps:** update dependency tflint to v0.51.2 2e9888f
* **deps:** update dependency tflint to v0.52.0 01124dd
* **deps:** update dependency trivy to v0.50.2 43baf9e
* **deps:** update dependency trivy to v0.50.4 70fbbb0
* **deps:** update dependency trivy to v0.51.0 7bdb177
* **deps:** update dependency trivy to v0.51.1 af06a70
* **deps:** update dependency trivy to v0.51.2 a11a428
* **deps:** update dependency trivy to v0.51.3 2c4e3be
* **deps:** update dependency trivy to v0.51.4 9807fe4
* **deps:** update dependency trivy to v0.52.0 1ccc7d2
* **deps:** update dependency trivy to v0.52.1 15ee73c
* **deps:** update dependency trivy to v0.52.2 392f8ca
* **deps:** update dependency trivy to v0.53.0 11c0c60
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.0 472b7f8
* **deps:** update renovate.json 3f40885
* **deps:** update tools 6125c67
* **pre-commit:** update commitlint hook 888bdfb
* **release:** remove legacy `VERSION` file e8a17f9

# v7.2.0 - 2023-02-03

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
