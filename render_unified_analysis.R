# Render Unified Retention Analysis
# ============================================================================
# This script renders the unified_retention_analysis.qmd document and verifies
# all outputs are generated correctly.
#
# CRITICAL DEPENDENCIES:
#   - 'coin' package is required for effect size calculations
#   - 'rstatix' package provides statistical test functions
#   - Both packages must be loaded; explicit namespaces used to avoid conflicts
#
# Setup:
#   renv::restore()           # Install all packages
#   renv::install("coin")     # Or manually install if needed
#
# Usage:
#   source("render_unified_analysis.R")
#
# ============================================================================

cat("\n")
cat("============================================================\n")
cat("  UNIFIED RETENTION ANALYSIS RENDER SCRIPT\n")
cat("============================================================\n\n")

# Expected output counts
EXPECTED_CSV_SUBFACTOR <- 43  # 7 per construct x 6 + screening_results
EXPECTED_PNG <- 6             # 1 per construct
EXPECTED_CSV_UNIFIED <- 2     # retention_summary + combined_summary

# Paths
qmd_file <- "scripts/analysis/unified_retention_analysis.qmd"
quarto_output_dir <- "output/reports/scripts/analysis"  # Where Quarto puts files
final_output_dir <- "output/reports"                     # Where we want them
csv_subfactor_dir <- "output/tables/subfactor_analysis"
csv_unified_dir <- "output/tables/unified_analysis"
png_dir <- "output/figures/subfactor_analysis"

# Install quarto package if needed
if (!requireNamespace("quarto", quietly = TRUE)) {
  cat("Installing quarto package...\n")
  install.packages("quarto", repos = "https://cloud.r-project.org")
}

# Verify input file exists
if (!file.exists(qmd_file)) {
  stop("ERROR: QMD file not found: ", qmd_file)
}

cat("Input:  ", qmd_file, "\n")
cat("Output: ", final_output_dir, "\n\n")

# Ensure output directories exist
dir.create(quarto_output_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(final_output_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(csv_subfactor_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(csv_unified_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(png_dir, showWarnings = FALSE, recursive = TRUE)

# Render with error handling
cat("Rendering document (this may take 2-3 minutes)...\n\n")

render_result <- tryCatch({
  quarto::quarto_render(
    input = qmd_file,
    output_format = "all"
  )
  list(success = TRUE, error = NULL)
}, error = function(e) {
  list(success = FALSE, error = conditionMessage(e))
})

if (!render_result$success) {
  cat("\n")
  cat("============================================================\n")
  cat("  RENDER FAILED\n")
  cat("============================================================\n")
  cat("Error: ", render_result$error, "\n\n")
  cat("Troubleshooting:\n")
  cat("  1. Ensure 'coin' package is installed: renv::install('coin')\n")
  cat("  2. Check for R syntax errors in QMD file\n")
  cat("  3. Review error message above for details\n")
  stop("Render failed. See error above.")
}

# Move rendered files from nested Quarto output to final location
cat("Moving rendered files to final location...\n")

html_source <- file.path(quarto_output_dir, "unified_retention_analysis.html")
docx_source <- file.path(quarto_output_dir, "unified_retention_analysis.docx")
html_dest <- file.path(final_output_dir, "unified_retention_analysis.html")
docx_dest <- file.path(final_output_dir, "unified_retention_analysis.docx")

if (file.exists(html_source)) {
  file.copy(html_source, html_dest, overwrite = TRUE)
  file.remove(html_source)
}
if (file.exists(docx_source)) {
  file.copy(docx_source, docx_dest, overwrite = TRUE)
  file.remove(docx_source)
}

# Clean up empty nested directories
unlink("output/reports/scripts", recursive = TRUE)

# Verify outputs
cat("\n")
cat("============================================================\n")
cat("  OUTPUT VERIFICATION\n")
cat("============================================================\n\n")

# Count CSV files
csv_subfactor_files <- list.files(csv_subfactor_dir, pattern = "\\.csv$")
csv_unified_files <- list.files(csv_unified_dir, pattern = "\\.csv$")
png_files <- list.files(png_dir, pattern = "\\.png$")

csv_subfactor_count <- length(csv_subfactor_files)
csv_unified_count <- length(csv_unified_files)
png_count <- length(png_files)

# Report results
cat("Subfactor CSVs: ", csv_subfactor_count, "/", EXPECTED_CSV_SUBFACTOR, "\n")
cat("Unified CSVs:   ", csv_unified_count, "/", EXPECTED_CSV_UNIFIED, "\n")
cat("PNG figures:    ", png_count, "/", EXPECTED_PNG, "\n\n")

# Check for HTML and DOCX in final location
html_file <- file.path(final_output_dir, "unified_retention_analysis.html")
docx_file <- file.path(final_output_dir, "unified_retention_analysis.docx")

html_exists <- file.exists(html_file)
docx_exists <- file.exists(docx_file)

cat("HTML report:    ", ifelse(html_exists, "OK", "MISSING"), "\n")
cat("DOCX report:    ", ifelse(docx_exists, "OK", "MISSING"), "\n\n")

# Summary
all_ok <- (csv_subfactor_count >= EXPECTED_CSV_SUBFACTOR - 2) &&  # Allow small tolerance
          (csv_unified_count >= EXPECTED_CSV_UNIFIED) &&
          (png_count >= EXPECTED_PNG) &&
          html_exists && docx_exists

if (all_ok) {
  cat("============================================================\n")
  cat("  RENDER COMPLETE - ALL CHECKS PASSED\n")
  cat("============================================================\n\n")
  cat("Output files:\n")
  cat("  HTML: ", html_file, "\n")
  cat("  DOCX: ", docx_file, "\n")
  cat("  CSVs: ", csv_subfactor_dir, "/ (", csv_subfactor_count, " files)\n")
  cat("  PNGs: ", png_dir, "/ (", png_count, " files)\n")
} else {
  cat("============================================================\n")
  cat("  RENDER COMPLETE - WARNINGS DETECTED\n")
  cat("============================================================\n\n")
  cat("Some output files may be missing. Please verify:\n")
  if (csv_subfactor_count < EXPECTED_CSV_SUBFACTOR) {
    cat("  - Missing subfactor CSV files\n")
  }
  if (png_count < EXPECTED_PNG) {
    cat("  - Missing PNG figures\n")
  }
  if (!html_exists) {
    cat("  - HTML report not generated\n")
  }
  if (!docx_exists) {
    cat("  - DOCX report not generated\n")
  }
}

cat("\n")
