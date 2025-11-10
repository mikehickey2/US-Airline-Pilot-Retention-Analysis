# Rebuild renv with ONLY the packages needed for this project
# Run this script to create a clean, minimal renv setup

cat("=== Rebuilding renv with minimal packages ===\n\n")

# List of packages actually used in analysis files
required_packages <- c(
  "tidyverse",    # Includes: dplyr, tidyr, ggplot2, readr, stringr, purrr, etc.
  "rstatix",      # Statistical tests
  "knitr",        # Document rendering
  "rmarkdown",    # Document rendering (needed for .Rmd/.qmd)
  "FSA",          # Post-hoc tests
  "PMCMRplus",    # Multiple comparisons
  "janitor",      # Data cleaning
  "DescTools",    # Descriptive statistics
  "here",         # Path management
  "gmodels",      # CrossTable and other modeling functions
  "usethis"       # Project setup utilities
)

cat("Required packages for this project:\n")
cat(paste("-", required_packages), sep = "\n")
cat("\n")

# Step 1: Remove old renv
cat("Step 1: Removing old renv setup...\n")
if (dir.exists("renv.backup")) {
  unlink("renv.backup", recursive = TRUE)
  cat("  ✓ Removed renv.backup/\n")
}
if (file.exists("renv.lock.backup")) {
  file.remove("renv.lock.backup")
  cat("  ✓ Removed renv.lock.backup\n")
}
if (dir.exists("renv")) {
  unlink("renv", recursive = TRUE)
  cat("  ✓ Removed renv/\n")
}
if (file.exists("renv.lock")) {
  file.remove("renv.lock")
  cat("  ✓ Removed renv.lock\n")
}

cat("\nStep 2: Installing renv package...\n")
if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv", repos = "https://cloud.r-project.org")
}

cat("\nStep 3: Initializing fresh renv...\n")
renv::init(bare = TRUE, restart = FALSE)

cat("\nStep 4: Installing required packages...\n")
install.packages(required_packages, repos = "https://cloud.r-project.org")

cat("\nStep 5: Creating renv snapshot...\n")
renv::snapshot(prompt = FALSE)

cat("\n✅ renv rebuild complete!\n\n")
cat("Summary:\n")
cat("  - Removed bloated old renv with 200+ packages\n")
cat("  - Created clean renv with", length(required_packages), "core packages\n")
cat("  - All dependencies will be installed automatically\n\n")

cat("Next steps:\n")
cat("  1. Restart your R session\n")
cat("  2. renv will automatically activate\n")
cat("  3. Run your analysis files as normal\n\n")

# Show what was installed
cat("Installed packages:\n")
installed <- installed.packages()[, "Package"]
our_packages <- intersect(required_packages, installed)
cat(paste("  ✓", our_packages), sep = "\n")
