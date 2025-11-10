##Standard R Project File Structure Setup
## Enhanced version with subdirectories, .gitignore, and README templates
## Author: Michael Hickey
## Updated: 2025-11-06

#' Create Standard R Project Directory Structure
#'
#' @param project_name Character string for project title (used in README)
#' @param subdirs Logical. If TRUE, creates subdirectories within data/ and output/
#' @param create_gitignore Logical. If TRUE, creates .gitignore file
#' @param create_readme Logical. If TRUE, creates README.md template
#' @param include_renv Logical. If TRUE, includes renv directory
#' @param custom_dirs Character vector of additional custom directories to create
#'
#' @return NULL (side effect: creates directory structure)
#' @export
#'
#' @examples
#' create_project_structure("My Analysis Project")
#' create_project_structure("Data Study", subdirs = FALSE, include_renv = FALSE)
create_project_structure <- function(project_name = "R Project",
                                     subdirs = TRUE,
                                     create_gitignore = TRUE,
                                     create_readme = TRUE,
                                     include_renv = TRUE,
                                     custom_dirs = NULL) {

  # Define base directory structure
  if (subdirs) {
    dir.names <- c(
      "data/raw",
      "data/processed",
      "scripts/analysis",
      "scripts/functions",
      "reports",
      "output/figures",
      "output/tables",
      "docs",
      "tmp"
    )
  } else {
    dir.names <- c("data", "scripts", "reports", "output", "tmp", "docs")
  }

  # Add renv if requested
  if (include_renv) {
    dir.names <- c(dir.names, "renv")
  }

  # Add custom directories if provided
  if (!is.null(custom_dirs)) {
    if (!is.character(custom_dirs)) {
      stop("custom_dirs must be a character vector")
    }
    dir.names <- c(dir.names, custom_dirs)
  }

  # Validate inputs
  if (!is.character(dir.names)) {
    stop("Directory names must be character strings.")
  }

  cat("\n=== Creating R Project Structure ===\n\n")

  # Create directories
  for (dir in dir.names) {
    if (!dir.exists(dir)) {
      dir.create(dir, recursive = TRUE, showWarnings = FALSE)
      cat("✓ Created:", dir, "\n")
    } else {
      cat("○ Exists: ", dir, "\n")
    }
  }

  # Create .gitignore
  if (create_gitignore) {
    gitignore_content <- c(
      "# R Project Files",
      ".Rhistory",
      ".RData",
      ".Rproj.user",
      "*.Rproj",
      "",
      "# Temporary files",
      "tmp/",
      "*.tmp",
      "",
      "# macOS",
      ".DS_Store",
      "",
      "# Windows",
      "Thumbs.db",
      "",
      "# RStudio",
      ".Rproj.user/",
      "",
      "# renv (uncomment if not tracking library)",
      "# renv/library/",
      "# renv/staging/",
      "",
      "# Output (uncomment if not tracking output)",
      "# output/",
      "",
      "# Sensitive data (adjust as needed)",
      "# data/raw/*.csv",
      "# data/raw/*.xlsx",
      "# !data/raw/.gitkeep"
    )

    if (!file.exists(".gitignore")) {
      writeLines(gitignore_content, ".gitignore")
      cat("\n✓ Created .gitignore\n")
    } else {
      cat("\n○ .gitignore already exists\n")
    }
  }

  # Create README template
  if (create_readme) {

    # Build directory tree for README
    if (subdirs) {
      tree <- c(
        "```",
        "project/",
        "├── data/",
        "│   ├── raw/           # Original data files",
        "│   └── processed/     # Cleaned/processed data",
        "├── scripts/",
        "│   ├── analysis/      # Analysis scripts",
        "│   └── functions/     # Reusable R functions",
        "├── reports/           # R Markdown reports",
        "├── output/",
        "│   ├── figures/       # Generated figures",
        "│   └── tables/        # Generated tables",
        "├── docs/              # Documentation",
        "└── tmp/               # Temporary files (gitignored)",
        "```"
      )
    } else {
      tree <- c(
        "```",
        "project/",
        "├── data/              # Data files",
        "├── scripts/           # R scripts",
        "├── reports/           # Reports and documentation",
        "├── output/            # Generated outputs",
        "└── tmp/               # Temporary files",
        "```"
      )
    }

    readme_template <- c(
      paste("#", project_name),
      "",
      "## Overview",
      "",
      "Brief description of the project.",
      "",
      "## Directory Structure",
      "",
      tree,
      "",
      "## Usage",
      "",
      "Describe how to run the analysis.",
      "",
      "## Dependencies",
      "",
      "List required R packages or see `renv.lock` for package versions.",
      "",
      "## Author",
      "",
      "## License",
      "",
      "## Citation",
      ""
    )

    if (!file.exists("README.md")) {
      writeLines(readme_template, "README.md")
      cat("✓ Created README.md\n")
    } else {
      cat("○ README.md already exists\n")
    }
  }

  # Create .gitkeep files for empty directories (helps git track empty folders)
  if (subdirs) {
    gitkeep_dirs <- c("data/raw", "data/processed", "output/figures", "output/tables")
    for (dir in gitkeep_dirs) {
      if (dir.exists(dir)) {
        gitkeep_file <- file.path(dir, ".gitkeep")
        if (!file.exists(gitkeep_file)) {
          file.create(gitkeep_file)
        }
      }
    }
    cat("✓ Created .gitkeep files in empty directories\n")
  }

  cat("\n🎉 Project structure created successfully!\n")
  cat("📁 Working directory:", getwd(), "\n\n")

  invisible(NULL)
}


#' Quick Setup - Standard Research Project
#'
#' Wrapper function for common research project setup
quick_research_project <- function(project_name = "Research Project") {
  create_project_structure(
    project_name = project_name,
    subdirs = TRUE,
    create_gitignore = TRUE,
    create_readme = TRUE,
    include_renv = TRUE
  )
}


#' Quick Setup - Simple Analysis Project
#'
#' Wrapper function for simple analysis projects (no subdirectories)
quick_simple_project <- function(project_name = "Analysis Project") {
  create_project_structure(
    project_name = project_name,
    subdirs = FALSE,
    create_gitignore = TRUE,
    create_readme = TRUE,
    include_renv = FALSE
  )
}


# Example usage (uncomment to run):
# create_project_structure("My Analysis Project")
# quick_research_project("My Research Study")
# quick_simple_project("Quick Analysis")