#Decleares that Github is required and a specific version
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.14.0"
    }
  }
}

#Connects to a github account 
provider "github" {
  owner = var.owner
  token = var.gh_token
}

#Specifiex wich repository the changes will be done to
data "github_repository" "DCSG2900-Bachelor-thesis" {
  full_name = "${var.owner}/${var.repository_name}"
}

#Here the branch protection rules are enabled for branches "dev" and "prod"
resource "github_branch_protection" "example" {
  repository_id = data.github_repository.test1.id
  pattern       = "dev"

  required_status_checks {
    strict   = true
    contexts = ["ci"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews          = true
    require_code_owner_reviews     = true
    required_approving_review_count = 2
  }

  require_signed_commits = true
}

resource "github_branch_protection" "dev" {
  repository_id = data.github_repository.test1.id
  pattern       = "prod"

  required_status_checks {
    strict   = true
    contexts = ["ci"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews          = true
    require_code_owner_reviews     = true
    required_approving_review_count = 2
  }

  require_signed_commits = true
}