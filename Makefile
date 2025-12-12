.PHONY: help org-login org-list org-open org-scratch-create org-delete-scratch deploy-preview deploy-start retrieve-preview retrieve-start package-versions-list package-version-create apex-run apex-run-file apex-list-log data-query

PKG ?= jordan-test
PKG_FLAG = $(if $(PKG),--package $(PKG),)

help: ## Display this help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

config: ## List all config settings
	sf config list

org-login: ## Login to an org using web login
	sf org login web

org-list: ## List all orgs authenticated to the CLI
	sf org list

org-open: ## Open the default org in a browser
	sf org open

org-scratch-create: ## Create a new scratch org
	sf org scratch create --edition developer --set-default --alias scratch

org-delete-scratch: ## Delete the scratch org
	sf org delete scratch

deploy-preview: ## Deploy source to default org in preview mode
	sf project deploy preview

deploy-start: ## Deploy source to default org in start mode
	sf project deploy start

retrieve-preview: ## Retrieve source from default org in preview mode
	sf project retrieve preview

retrieve-start: ## Retrieve source from default org in start mode
	sf project retrieve start

package-version-list: ## List package versions in the Dev Hub org
	sf package version list --concise --packages $(PKG)

package-version-create: ## Create a new package version using $PKG
	sf package version create --installation-key-bypass --package $(PKG)

apex-run: ## Run Apex code in scratch org in interactive mode
	sf apex run

apex-run-file: ## Run Apex code in scratch org from file
	sf apex run --file scripts/apex/hello.apex --loglevel debug | grep 'USER_'

apex-list-log: ## List debug logs in scratch org in json format
	sf apex list log --json

data-query: ## Run a data query in scratch org
	sf data query -q "$(QUERY)"