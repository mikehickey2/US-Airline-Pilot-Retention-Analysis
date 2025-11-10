# Run the project structure setup
# This will create directories and recreate .gitignore and README.md

# Source the setup script to load functions
source("RProj_FS_setup.r")

# Remove existing .gitignore and README.md to allow fresh creation
if (file.exists(".gitignore")) {
  file.remove(".gitignore")
  cat("Removed existing .gitignore\n")
}

if (file.exists("README.md")) {
  file.remove("README.md")
  cat("Removed existing README.md\n")
}

# Run the setup with fresh .gitignore and README.md
create_project_structure(
  project_name = "US Airline Pilot Retention Analysis",
  subdirs = TRUE,
  create_gitignore = TRUE,   # Create new .gitignore
  create_readme = TRUE,       # Create new README.md
  include_renv = FALSE,       # Skip renv for now
  custom_dirs = NULL
)

cat("\n✅ Setup complete! Directory structure created with new .gitignore and README.md\n")
