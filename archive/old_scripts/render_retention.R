# Render Retention Analysis to output/reports directory
#
# CRITICAL DEPENDENCY: The 'coin' package is required for exact tests.
# Without it, gender comparison exact tests will fail.
#
# Setup:
#   renv::restore()           # Install all packages including coin
#   renv::install("coin")     # Or manually install if renv::restore() fails
#
# Verification after rendering:
#   Check that gender comparisons completed successfully with exact=TRUE

cat("=== Rendering Retention Analysis ===\n\n")

# Ensure output directory exists
output_dir <- "output/reports"
dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)
cat("Output directory:", output_dir, "\n\n")

# Path to the .qmd file
qmd_file <- "scripts/analysis/retention.qmd"

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

html_source <- "scripts/analysis/retention.html"
docx_source <- "scripts/analysis/retention.docx"

html_dest <- file.path(output_dir, "retention.html")
docx_dest <- file.path(output_dir, "retention.docx")

if (file.exists(html_source)) {
  file.rename(html_source, html_dest)
  cat("✓ HTML:", html_dest, "\n")
}

if (file.exists(docx_source)) {
  file.rename(docx_source, docx_dest)
  cat("✓ DOCX:", docx_dest, "\n")
}

cat("\n✅ Rendering complete!\n")
cat("\nOutput file saved to:", output_dir, "\n")
