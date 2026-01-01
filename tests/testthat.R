# Test runner for retention analysis helper functions
# Run with: Rscript -e "testthat::test_dir('tests/testthat')"

library(testthat)
library(here)

# Source helper functions
source(here("R/retention_helpers.R"))

# Run tests
test_dir(here("tests/testthat"))
