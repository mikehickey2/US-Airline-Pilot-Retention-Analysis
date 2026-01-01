# Tests for retention analysis helper functions
# Run with: Rscript -e "testthat::test_dir('tests/testthat')"

library(testthat)
library(dplyr)
library(tidyr)
library(tibble)
library(here)

# Source helper functions
source(here("R/retention_helpers.R"))

# Test data fixtures
create_test_data <- function() {

  tibble(
    age_group = c("<=35", "<=35", ">35", ">35", "<=35", ">35"),
    gender_clean = c("Male", "Male", "Female", "Male", "Female", "Male"),
    position = c("Captain", "FO", "Captain", "FO", "Captain", "FO"),
    military_clean = c("Yes", "No", "Yes", "No", "Yes", "No"),
    exp_q = c("Q1", "Q2", "Q3", "Q4", "Q1", "Q2"),
    financial_1 = c(1, 2, 3, 1, 2, 3),
    financial_2 = c(2, 1, 1, 3, 3, 2),
    financial_3 = c(3, 3, 2, 2, 1, 1)
  )
}

test_labels <- c(
  "financial_1" = "Competitive salary",
  "financial_2" = "Allowances",
  "financial_3" = "Benefits"
)

# Tests for prepare_construct_data
test_that("prepare_construct_data creates long format correctly", {
  test_data <- create_test_data()
  var_cols <- c("financial_1", "financial_2", "financial_3")

  result <- prepare_construct_data(test_data, var_cols, default_demographics)

  expect_s3_class(result, "tbl_df")
  expect_true("respondent_id" %in% names(result))
  expect_true("item" %in% names(result))
  expect_true("rank" %in% names(result))
  expect_equal(nrow(result), 18)
})

test_that("prepare_construct_data validates inputs", {
  test_data <- create_test_data()

  expect_error(
    prepare_construct_data(NULL, "financial_1", default_demographics),
    "Assertion on 'data' failed"
  )

  expect_error(
    prepare_construct_data(test_data, character(0), default_demographics),
    "Assertion on 'var_cols' failed"
  )
})

# Tests for compute_descriptives
test_that("compute_descriptives calculates statistics correctly", {
  test_data <- create_test_data()
  var_cols <- c("financial_1", "financial_2", "financial_3")
  long_data <- prepare_construct_data(test_data, var_cols, default_demographics)

  result <- compute_descriptives(long_data, test_labels)

  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 3)
  expect_true(all(c("n", "median", "mean", "sd", "pct_rank1") %in% names(result)))
  expect_true("Competitive salary" %in% result$item)
})

test_that("compute_descriptives validates inputs", {
  expect_error(
    compute_descriptives(NULL, test_labels),
    "Assertion on 'long_data' failed"
  )

  expect_error(
    compute_descriptives(tibble(item = "a", rank = 1), c("wrong")),
    "Assertion on 'item_labels' failed"
  )
})

# Tests for run_friedman_test
test_that("run_friedman_test returns valid result", {
  test_data <- create_test_data()
  var_cols <- c("financial_1", "financial_2", "financial_3")
  long_data <- prepare_construct_data(test_data, var_cols, default_demographics)

  result <- run_friedman_test(long_data)

  expect_s3_class(result, "tbl_df")
  expect_true("statistic" %in% names(result))
  expect_true("p" %in% names(result))
})

# Tests for safe_wilcox_test
test_that("safe_wilcox_test returns empty tibble for single group", {
  single_group_data <- tibble(
    rank = c(1, 2, 3),
    group = c("A", "A", "A")
  )
  formula <- reformulate("group", "rank")

  result <- safe_wilcox_test(single_group_data, formula)

  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 0)
})

test_that("safe_wilcox_test validates inputs", {
  expect_error(
    safe_wilcox_test(NULL, rank ~ group),
    "Assertion on 'data' failed"
  )

  expect_error(
    safe_wilcox_test(tibble(rank = 1, group = "A"), "not_a_formula"),
    "Assertion on 'formula' failed"
  )
})

# Tests for safe_kruskal_test
test_that("safe_kruskal_test returns empty tibble for single group", {
  single_group_data <- tibble(
    rank = c(1, 2, 3),
    group = c("A", "A", "A")
  )
  formula <- reformulate("group", "rank")

  result <- safe_kruskal_test(single_group_data, formula)

  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 0)
})

# Tests for create_median_rank_chart
test_that("create_median_rank_chart returns ggplot object", {
  desc_stats <- tibble(
    item = c("A", "B", "C"),
    median = c(1.5, 2.0, 2.5)
  )

  result <- create_median_rank_chart(desc_stats, "Test Construct")

  expect_s3_class(result, "gg")
  expect_s3_class(result, "ggplot")
})

test_that("create_median_rank_chart validates inputs", {
  expect_error(
    create_median_rank_chart(NULL, "Test"),
    "Assertion on 'desc_stats' failed"
  )

  expect_error(
    create_median_rank_chart(tibble(item = "A", median = 1), 123),
    "Assertion on 'construct_name' failed"
  )
})

# Tests for run_demographic_comparison
test_that("run_demographic_comparison handles binary demographics", {
  test_data <- create_test_data()
  var_cols <- c("financial_1", "financial_2", "financial_3")
  long_data <- prepare_construct_data(test_data, var_cols, default_demographics)

  result <- run_demographic_comparison(
    long_data,
    demo_var = "age_group",
    demo_type = "binary",
    exact = FALSE,
    item_labels = test_labels
  )

  expect_s3_class(result, "tbl_df")
  if (nrow(result) > 0) {
    expect_true("p" %in% names(result))
    expect_true("p_adj_holm" %in% names(result))
  }
})

test_that("run_demographic_comparison handles multi-level demographics", {
  test_data <- create_test_data()
  var_cols <- c("financial_1", "financial_2", "financial_3")
  long_data <- prepare_construct_data(test_data, var_cols, default_demographics)

  result <- run_demographic_comparison(
    long_data,
    demo_var = "exp_q",
    demo_type = "multi",
    exact = FALSE,
    item_labels = test_labels
  )

  expect_s3_class(result, "tbl_df")
  if (nrow(result) > 0) {
    expect_true("df" %in% names(result))
  }
})

# Tests for export_construct_tables
test_that("export_construct_tables creates files", {
  skip_if_not(dir.exists(tempdir()))

  desc_stats <- tibble(item = "A", n = 10, median = 2)
  friedman_result <- tibble(statistic = 5, p = 0.05)
  demo_results <- list(
    age = tibble(item = "A", p = 0.05)
  )

  temp_dir <- tempdir()
  export_construct_tables(
    "Test",
    desc_stats,
    friedman_result,
    demo_results,
    temp_dir
  )

  expect_true(file.exists(file.path(temp_dir, "test_descriptive.csv")))
  expect_true(file.exists(file.path(temp_dir, "test_friedman.csv")))
  expect_true(file.exists(file.path(temp_dir, "test_age.csv")))

  unlink(file.path(temp_dir, "test_descriptive.csv"))
  unlink(file.path(temp_dir, "test_friedman.csv"))
  unlink(file.path(temp_dir, "test_age.csv"))
})
