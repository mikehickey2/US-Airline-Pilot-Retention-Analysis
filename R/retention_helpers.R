# Retention Analysis Helper Functions
# Extracted from unified_retention_analysis.qmd for modularity and testing
# See documentation/function_architecture.md for design details

#' Default demographics configuration
#'
#' List defining demographic variables for retention analysis.
#' Each element specifies variable name, test type, and exact test flag.
default_demographics <- list(
  age = list(var = "age_group", type = "binary", exact = FALSE),
  gender = list(var = "gender_clean", type = "binary", exact = FALSE),
  position = list(var = "position", type = "binary", exact = FALSE),
  military = list(var = "military_clean", type = "binary", exact = FALSE),
  experience = list(var = "exp_q", type = "multi", exact = FALSE)
)

#' Safe Mann-Whitney U test with effect sizes
#'
#' Runs Mann-Whitney U test with rank-biserial effect size.
#' Returns empty tibble if fewer than 2 groups available.
#'
#' @param data Data frame in long format with rank and grouping variable
#' @param formula Formula for the test (rank ~ grouping_var)
#' @param exact Logical; use exact test (default FALSE)
#' @return Tibble with test statistics and effect sizes
safe_wilcox_test <- function(data, formula, exact = FALSE) {
  checkmate::assert_data_frame(data, min.rows = 1)
  checkmate::assert_formula(formula)
  checkmate::assert_logical(exact, len = 1)

  group_var <- all.vars(formula)[2]
  n_groups <- data |>
    dplyr::filter(!is.na(.data[[group_var]])) |>
    dplyr::pull(.data[[group_var]]) |>
    dplyr::n_distinct()

  if (n_groups < 2) {
    return(tibble::tibble(
      .y. = character(), group1 = character(), group2 = character(),
      n1 = integer(), n2 = integer(), statistic = numeric(),
      p = numeric(), effsize = numeric(), magnitude = character()
    ))
  }

  test_result <- rstatix::wilcox_test(data, formula, exact = exact)

  if (nrow(test_result) == 0) {
    return(tibble::tibble(
      .y. = character(), group1 = character(), group2 = character(),
      n1 = integer(), n2 = integer(), statistic = numeric(),
      p = numeric(), effsize = numeric(), magnitude = character()
    ))
  }

  effsize_result <- rstatix::wilcox_effsize(data, formula)

  test_result |>
    dplyr::left_join(
      effsize_result |>
        dplyr::select(dplyr::any_of(c("item", ".y.", "effsize", "magnitude"))),
      by = intersect(names(test_result), c("item", ".y."))
    )
}

#' Safe Kruskal-Wallis test with effect sizes
#'
#' Runs Kruskal-Wallis H test with eta-squared effect size.
#' Returns empty tibble if fewer than 2 groups available.
#'
#' @param data Data frame in long format
#' @param formula Formula for the test (rank ~ grouping_var)
#' @return Tibble with test statistics and effect sizes
safe_kruskal_test <- function(data, formula) {
  checkmate::assert_data_frame(data, min.rows = 1)
  checkmate::assert_formula(formula)

  group_var <- all.vars(formula)[2]
  n_groups <- data |>
    dplyr::filter(!is.na(.data[[group_var]])) |>
    dplyr::pull(.data[[group_var]]) |>
    dplyr::n_distinct()

  if (n_groups < 2) {
    return(tibble::tibble(
      .y. = character(), n = integer(), statistic = numeric(),
      df = integer(), p = numeric(), effsize = numeric(), magnitude = character()
    ))
  }

  test_result <- rstatix::kruskal_test(data, formula)

  if (nrow(test_result) == 0) {
    return(tibble::tibble(
      .y. = character(), n = integer(), statistic = numeric(),
      df = integer(), p = numeric(), effsize = numeric(), magnitude = character()
    ))
  }

  effsize_result <- rstatix::kruskal_effsize(data, formula)

  test_result |>
    dplyr::left_join(
      effsize_result |>
        dplyr::select(dplyr::any_of(c("item", ".y.", "effsize", "magnitude"))),
      by = intersect(names(test_result), c("item", ".y."))
    )
}

#' Prepare construct data: convert wide to long with respondent ID
#'
#' Transforms wide-format survey data to long format for statistical analysis.
#'
#' @param data Full dataset with demographic and construct columns
#' @param var_cols Character vector of column names for this construct
#' @param demographics List of demographic configurations (unused but kept for API)
#' @return Long-format tibble with respondent_id, item, rank, and demographics
prepare_construct_data <- function(data, var_cols, demographics) {
  checkmate::assert_data_frame(data, min.rows = 1)
  checkmate::assert_character(var_cols, min.len = 1)
  checkmate::assert_list(demographics)

  demo_cols <- c(
    "age_group", "gender_clean", "position", "military_clean", "exp_q"
  )

  selected_data <- data |>
    dplyr::select(dplyr::all_of(demo_cols), dplyr::all_of(var_cols)) |>
    dplyr::mutate(respondent_id = dplyr::row_number()) |>
    dplyr::mutate(dplyr::across(dplyr::all_of(var_cols), as.numeric))

  result <- selected_data |>
    tidyr::pivot_longer(
      cols = dplyr::all_of(var_cols),
      names_to = "item",
      values_to = "rank"
    ) |>
    dplyr::filter(!is.na(rank))

  result
}

#' Compute descriptive statistics for construct items
#'
#' Calculates n, median, mean, SD, and percent ranked first for each item.
#'
#' @param long_data Data in long format with item and rank columns
#' @param item_labels Named vector mapping variable names to display labels
#' @return Tibble with descriptive statistics per item
compute_descriptives <- function(long_data, item_labels) {
  checkmate::assert_data_frame(long_data, min.rows = 1)
  checkmate::assert_character(item_labels, min.len = 1, names = "named")

  long_data |>
    dplyr::group_by(item) |>
    dplyr::summarise(
      n = dplyr::n(),
      median = median(rank),
      mean = mean(rank),
      sd = sd(rank),
      pct_rank1 = sum(rank == 1) / dplyr::n() * 100,
      .groups = "drop"
    ) |>
    dplyr::mutate(item = dplyr::recode(item, !!!item_labels))
}

#' Run Friedman test for within-construct ranking differences
#'
#' Tests whether items within a construct are ranked differently overall.
#'
#' @param long_data Data in long format with respondent_id, item, and rank
#' @return rstatix Friedman test result tibble
run_friedman_test <- function(long_data) {
  checkmate::assert_data_frame(long_data, min.rows = 1)

  long_data |>
    rstatix::friedman_test(rank ~ item | respondent_id)
}

#' Run demographic comparison (Mann-Whitney or Kruskal-Wallis)
#'
#' Compares item rankings between demographic groups with effect sizes
#' and Holm-adjusted p-values.
#'
#' @param long_data Data in long format
#' @param demo_var Name of demographic variable column
#' @param demo_type "binary" for Mann-Whitney, "multi" for Kruskal-Wallis
#' @param exact Logical; use exact test for Mann-Whitney
#' @param item_labels Named vector for recoding item names
#' @return Tibble with test results, effect sizes, and adjusted p-values
run_demographic_comparison <- function(
  long_data,
  demo_var,
  demo_type,
  exact,
  item_labels
) {
  checkmate::assert_data_frame(long_data, min.rows = 1)
  checkmate::assert_string(demo_var)
  checkmate::assert_string(demo_type)
  checkmate::assert_logical(exact, len = 1)
  checkmate::assert_character(item_labels, min.len = 1, names = "named")

  filtered_data <- long_data |>
    dplyr::filter(!is.na(.data[[demo_var]]))

  test_formula <- reformulate(demo_var, "rank")

  if (demo_type == "binary") {
    result <- filtered_data |>
      dplyr::group_by(item) |>
      safe_wilcox_test(test_formula, exact = exact) |>
      dplyr::ungroup()
  } else {
    result <- filtered_data |>
      dplyr::group_by(item) |>
      safe_kruskal_test(test_formula) |>
      dplyr::ungroup()
  }

  if (nrow(result) > 0) {
    result <- result |>
      dplyr::mutate(p_raw = p) |>
      rstatix::adjust_pvalue(method = "holm") |>
      rstatix::add_significance("p.adj") |>
      dplyr::select(-p) |>
      dplyr::rename(p = p_raw, p_adj_holm = p.adj) |>
      dplyr::mutate(item = dplyr::recode(item, !!!item_labels))

    if (demo_type == "binary") {
      result <- result |>
        dplyr::select(
          item, statistic, p, p_adj_holm, p.adj.signif, effsize, magnitude
        )
    } else {
      result <- result |>
        dplyr::select(
          item, statistic, df, p, p_adj_holm, p.adj.signif, effsize, magnitude
        )
    }
  }

  result
}

#' Create median rank bar chart
#'
#' Generates horizontal bar chart showing median ranks for construct items.
#'
#' @param desc_stats Descriptive statistics tibble from compute_descriptives
#' @param construct_name Display name for chart title
#' @param color Fill color for bars (default "steelblue")
#' @return ggplot object
create_median_rank_chart <- function(
  desc_stats,
  construct_name,
  color = "steelblue"
) {
  checkmate::assert_data_frame(desc_stats, min.rows = 1)
  checkmate::assert_string(construct_name)
  checkmate::assert_string(color)

  desc_stats |>
    dplyr::mutate(item = forcats::fct_reorder(item, dplyr::desc(median))) |>
    ggplot2::ggplot(ggplot2::aes(x = median, y = item)) +
    ggplot2::geom_col(fill = color, alpha = 0.8) +
    ggplot2::geom_text(
      ggplot2::aes(label = sprintf("%.1f", median)), hjust = -0.2, size = 3
    ) +
    ggplot2::labs(
      title = paste(construct_name, "Subfactor Priorities"),
      subtitle = "Median rank (lower = higher priority)",
      x = "Median Rank",
      y = NULL
    ) +
    ggplot2::theme_minimal() +
    ggplot2::theme(plot.title = ggplot2::element_text(face = "bold"))
}

#' Export all tables for a construct to CSV
#'
#' Writes descriptive stats, Friedman results, and demographic comparisons.
#'
#' @param construct_name Name used for file prefix (spaces become underscores)
#' @param desc_stats Descriptive statistics tibble
#' @param friedman_result Friedman test result tibble
#' @param demo_results Named list of demographic comparison tibbles
#' @param output_dir Directory path for output files
export_construct_tables <- function(
  construct_name,
  desc_stats,
  friedman_result,
  demo_results,
  output_dir
) {
  checkmate::assert_string(construct_name)
  checkmate::assert_data_frame(desc_stats)
  checkmate::assert_data_frame(friedman_result)
  checkmate::assert_list(demo_results)
  checkmate::assert_string(output_dir)

  prefix <- tolower(gsub(" ", "_", construct_name))

  readr::write_csv(
    desc_stats, file.path(output_dir, paste0(prefix, "_descriptive.csv"))
  )
  readr::write_csv(
    friedman_result, file.path(output_dir, paste0(prefix, "_friedman.csv"))
  )

  demo_names <- c("age", "gender", "position", "military", "experience")
  for (name in demo_names) {
    if (!is.null(demo_results[[name]]) && nrow(demo_results[[name]]) > 0) {
      readr::write_csv(
        demo_results[[name]],
        file.path(output_dir, paste0(prefix, "_", name, ".csv"))
      )
    }
  }
}

#' Analyze one construct completely
#'
#' Main orchestrating function that runs full analysis pipeline for a construct:
#' prepares data, computes descriptives, runs Friedman test, runs demographic
#' comparisons, creates visualization, and exports all outputs.
#'
#' @param data Full dataset with all variables
#' @param construct_name Display name (e.g., "Financial")
#' @param var_cols Character vector of actual column names for this construct
#' @param item_labels Named vector mapping column names to readable labels
#' @param demographics List of demographic configs (default: default_demographics)
#' @param output_dir Directory for CSV output
#' @param plot_color Color for bar chart (default "steelblue")
#' @return List containing all results: descriptive_stats, friedman_result,
#'   demographic_results, screening_p, and figure
analyze_construct <- function(
  data,
  construct_name,
  var_cols,
  item_labels,
  demographics = default_demographics,
  output_dir = "../../output/tables/subfactor_analysis",
  plot_color = "steelblue"
) {
  checkmate::assert_data_frame(data, min.rows = 1)
  checkmate::assert_string(construct_name)
  checkmate::assert_character(var_cols, min.len = 1)
  checkmate::assert_character(item_labels, min.len = 1, names = "named")
  checkmate::assert_list(demographics)
  checkmate::assert_string(output_dir)
  checkmate::assert_string(plot_color)

  long_data <- prepare_construct_data(data, var_cols, demographics)
  desc_stats <- compute_descriptives(long_data, item_labels)
  friedman_result <- run_friedman_test(long_data)
  fig <- create_median_rank_chart(desc_stats, construct_name, plot_color)

  demo_results <- list()
  for (demo_name in names(demographics)) {
    demo_config <- demographics[[demo_name]]
    demo_results[[demo_name]] <- run_demographic_comparison(
      long_data,
      demo_var = demo_config$var,
      demo_type = demo_config$type,
      exact = demo_config$exact,
      item_labels = item_labels
    )
  }

  all_p_values <- purrr::map(demo_results, ~ {
    if (nrow(.x) > 0 && "p" %in% names(.x)) min(.x$p, na.rm = TRUE) else 1
  })
  screening_p <- min(unlist(all_p_values), na.rm = TRUE)

  export_construct_tables(
    construct_name, desc_stats, friedman_result, demo_results, output_dir
  )

  fig_path <- file.path(
    gsub("tables", "figures", output_dir),
    paste0(tolower(gsub(" ", "_", construct_name)), "_median_ranks.png")
  )
  ggplot2::ggsave(fig_path, fig, width = 8, height = 5, dpi = 300)

  list(
    construct_name = construct_name,
    descriptive_stats = desc_stats,
    friedman_result = friedman_result,
    demographic_results = demo_results,
    screening_p = screening_p,
    figure = fig
  )
}
