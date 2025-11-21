# Render Subfactor Analysis to output/reports directory
#
# CRITICAL DEPENDENCY: The 'coin' package is required for Mann-Whitney effect sizes.
# Without it, all Mann-Whitney effect sizes will be NA in output tables.
#
# Setup:
#   renv::restore()           # Install all packages including coin
#   renv::install("coin")     # Or manually install if renv::restore() fails
#
# Verification after rendering:
#   Check output/tables/subfactor_analysis/financial_age.csv
#   Verify 'effsize' column shows numeric values (not NA)

cat("=== Rendering Subfactor Analysis ===\n\n")

# Ensure output directory exists
output_dir <- "output/reports"
dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)
cat("Output directory:", output_dir, "\n\n")

# Path to the .qmd file
qmd_file <- "scripts/analysis/subfactor_analysis.qmd"

# Install quarto package if needed
if (!requireNamespace("quarto", quietly = TRUE)) {
  cat("Installing quarto package...\n")
  install.packages("quarto", repos = "https://cloud.r-project.org")
}

# Render the document (both HTML and DOCX formats)
cat("Rendering document (this may take a few minutes)...\n\n")
quarto::quarto_render(
  input = qmd_file,
  output_format = "all"
)

# Move output files to output/reports
cat("\nMoving files to output/reports...\n")

html_source <- "scripts/analysis/subfactor_analysis.html"
docx_source <- "scripts/analysis/subfactor_analysis.docx"

html_dest <- file.path(output_dir, "subfactor_analysis.html")
docx_dest <- file.path(output_dir, "subfactor_analysis.docx")

if (file.exists(html_source)) {
  file.rename(html_source, html_dest)
  cat("✓ HTML:", html_dest, "\n")
}

if (file.exists(docx_source)) {
  file.rename(docx_source, docx_dest)
  cat("✓ DOCX:", docx_dest, "\n")
}

cat("\n✅ Rendering complete!\n")
cat("\nOutput files saved to:", output_dir, "\n")
cat("CSV tables saved to: output/tables/subfactor_analysis/\n")
