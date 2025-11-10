# Initialize renv for the project
if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv")
}

# Initialize renv
renv::init()

cat("\n✅ renv initialization complete!\n")
