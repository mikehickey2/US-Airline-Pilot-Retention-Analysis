# Subfactor Analysis Validation

Generated from a static review of `scripts/analysis/subfactor_analysis.qmd` and `render_subfactor_analysis.R`.

## Scope and Execution Status
- Inspected the Quarto analysis for data handling, statistical approach, and reporting structure.
- Reviewed the R render helper for workflow completeness.
- Attempted to execute `Rscript` to run the analysis, but even a trivial `Rscript -e "cat('hello')"` call timed out twice in this environment, so this validation documents code-level findings only.

## Key Findings

### Data ingestion and preprocessing
- `slice(-(1:2))` (line 177) removes two rows immediately after loading the CSV. Qualtrics exports typically need the second row (question text) stripped, but dropping both rows would also discard the first actual response unless there is a second metadata line. Confirming the raw file layout and tightening this filter would prevent silent sample loss.
- Demographic recodes (lines 199-228) sensibly standardize age, gender, experience quartiles, and military status, but position values are passed through without harmonization; any typos will propagate into later grouping.

### Statistical tests
- Using Mann-Whitney U for binary group comparisons and Kruskal-Wallis for experience quartiles matches the ordinal rank structure of the data. Bonferroni corrections via `adjust_pvalue()` are applied consistently.
- The Friedman tests are currently misconfigured: within each construct chunk (for example lines 274-279, 402-407, 516-526, 640-645, 756-762, and 884-889), the code creates `id = row_number()` after grouping by item. Because `row_number()` is reset per item, the same `id` label refers to different respondents across items, so the repeated-measures requirement of `friedman_test(rank ~ item | id)` is violated. A stable respondent identifier (e.g., `mutate(respondent_id = row_number())` before pivoting and reusing it post-pivot) is needed for valid Friedman statistics.
- Effect sizes and confidence intervals are absent from all group comparisons; only p-values are reported. Without metrics such as `rstatix::wilcox_effsize()` or `eta_squared()`, it is hard to judge practical importance, especially given the conservative Bonferroni adjustment.
- The "safe" wrappers only ensure at least two distinct groups, but they will still run with a single observation in one group, yielding unstable p-values. Consider requiring a minimum count per group or reporting when comparisons are skipped.

### Reporting and outputs
- Each construct section only prints `kable()` tables inside the document. No CSVs or figures are written even though the setup chunk creates `output/tables/subfactor_analysis` and the render script advertises "CSV tables saved..." This mismatch makes automated downstream reuse impossible.
- The analysis plan called for visual summaries (e.g., bar charts of median ranks), but the current `.qmd` generates no figures aside from tabular output.

### Complexity and maintainability
- The code for financial, QoL, professional, recognition, schedule, and operational constructs is nearly identical, leading to ~600 lines of duplicated logic. Encapsulating the long-format conversion, descriptive stats, and repeated test suite in a parameterized helper would greatly reduce maintenance effort and the chance of inconsistent fixes.
- Narrated `cat()` separators improve readability in the console but add noise to rendered reports; consider moving verbose logging to a conditional chunk option or using Quarto callouts for reader-friendly structure.

### Render script
- `render_subfactor_analysis.R` (lines 6-48) successfully handles directory creation, rendering, and file moves, but it does not catch failures from `quarto::quarto_render()` nor does it verify that the `.qmd` actually emitted CSV summaries (message at line 48 is currently inaccurate).

## Recommendations
1. Introduce a persistent respondent ID before any `pivot_longer()` call and reuse it for all Friedman tests so the within-subject ranking comparisons are valid.
2. Audit the raw Qualtrics export to determine whether only the question-text row needs removal; update `slice()` accordingly and log how many observations are dropped.
3. Replace the six near-identical construct chunks with a single function that takes the variable prefix, label vector, and number of levels, then loops over the demographic dimensions. This will simplify future maintenance and reduce the risk of inconsistent corrections.
4. Augment the demographic comparisons with effect sizes (e.g., Wilcoxon `r`, Kruskal-Wallis `eta_squared`) and clearly report when group sizes are too small for inference.
5. Persist the key tables (and any planned plots) to `output/tables/subfactor_analysis/` so the render script’s messaging matches reality and downstream workflows can consume the results programmatically.
6. Wrap the Quarto render call in error handling and ensure the helper prints or logs failures rather than silently exiting.
