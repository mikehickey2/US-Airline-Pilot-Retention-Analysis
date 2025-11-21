# Refactor & Combine Branch: Detailed Project Plan

**Branch:** `refactor_combine`
**Created:** November 21, 2025
**Status:** COMPLETE - All Phases Finished
**Parent Document:** `refactor_combine_design.md`

---

## Executive Summary

This plan details the implementation steps to:
1. Archive original QMD files
2. Create a unified analysis QMD combining retention + subfactor analyses
3. Refactor ~600 lines of duplicated subfactor code into reusable functions
4. Generate comparison summary tables (raw, FDR, Bonferroni)
5. Prepare the document for academic publishing

**Estimated Total Effort:** 12-16 hours
**Time-box Target:** 3 days

---

## Phase 0: Pre-Work Setup

### Task 0.1: Archive Original QMDs
**Priority:** Critical (must complete first)
**Estimated Time:** 15 minutes

**Actions:**
1. Create `archive/original_qmds/` directory
2. Copy (not move) both files:
   - `scripts/analysis/retention.qmd` → `archive/original_qmds/retention_original.qmd`
   - `scripts/analysis/subfactor_analysis.qmd` → `archive/original_qmds/subfactor_analysis_original.qmd`
3. Create `archive/original_qmds/README.md` documenting the archive date and purpose

**Acceptance Criteria:**
- [ ] Original files preserved in archive
- [ ] Archive README documents provenance
- [ ] Working copies remain in `scripts/analysis/`

### Task 0.2: Create Unified QMD Shell
**Priority:** Critical
**Estimated Time:** 30 minutes

**Actions:**
1. Create new file: `scripts/analysis/unified_retention_analysis.qmd`
2. Set up YAML header combining best of both:
```yaml
---
title: "U.S. Airline Pilot Retention Analysis"
subtitle: "General Factor Rankings and Subfactor Priorities"
author: "Michael J. Hickey"
date: today
format:
  html:
    toc: true
    toc-depth: 3
    code-fold: true
    embed-resources: true
    theme: cosmo
    number-sections: true
  docx:
    toc: true
    toc-depth: 3
    number-sections: true
execute:
  warning: false
  message: false
  echo: true
---
```
3. Create section placeholders for document structure

**Acceptance Criteria:**
- [ ] New unified QMD created
- [ ] Renders empty shell without errors
- [ ] Section structure matches design spec

---

## Phase 1: Refactor Subfactor Analysis Code

### Task 1.1: Design Helper Function Architecture
**Priority:** High
**Estimated Time:** 1 hour (design only)

**Problem:** The current `subfactor_analysis.qmd` has ~600 lines of near-identical code repeated for each of 6 constructs (Financial, QoL, Professional, Recognition, Schedule, Operational).

**Proposed Solution:** Create a single parameterized function that handles all analysis for any construct.

**Function Signature:**
```r
analyze_construct <- function(
  data,
  construct_name,
  variable_prefix,
  item_labels,
  n_items,
  demographics = list(
    age = list(var = "age_group", type = "binary"),
    gender = list(var = "gender", type = "binary", exact = TRUE),
    position = list(var = "position", type = "binary"),
    military = list(var = "military_bg", type = "binary"),
    experience = list(var = "exp_q", type = "multi")
  ),
  output_dir = "../../output/tables/subfactor_analysis",
  fdr_threshold = 0.10,
  holm_alpha = 0.05
)
```

**Returns:** A list containing:
- `descriptive_stats` - tibble of median ranks, IQRs, % ranked #1
- `friedman_result` - Friedman test output
- `demographic_results` - list of tibbles for each demographic comparison
- `screening_p` - minimum p-value for hierarchical FDR screening
- `figure` - ggplot object for median rank bar chart

**Internal Structure:**
```r
analyze_construct <- function(...) {
  # 1. Prepare data: pivot to long format with respondent_id
  long_data <- prepare_construct_data(data, variable_prefix, item_labels, n_items)

  # 2. Descriptive statistics
  desc_stats <- compute_descriptives(long_data, item_labels)

  # 3. Friedman test (within-subjects)
  friedman <- run_friedman_test(long_data)

  # 4. Demographic comparisons
  demo_results <- map(demographics, ~{
    run_demographic_comparison(long_data, .x$var, .x$type, .x$exact %||% FALSE)
  })

  # 5. Apply Holm correction within construct
  demo_results <- map(demo_results, apply_holm_correction)

  # 6. Compute screening p-value
  screening_p <- min(map_dbl(demo_results, ~min(.x$p, na.rm = TRUE)))

  # 7. Export CSVs
  export_construct_tables(construct_name, desc_stats, friedman, demo_results, output_dir)

  # 8. Generate figure
  fig <- create_median_rank_chart(desc_stats, construct_name)

  # Return results
  list(
    descriptive_stats = desc_stats,
    friedman_result = friedman,
    demographic_results = demo_results,
    screening_p = screening_p,
    figure = fig
  )
}
```

**Acceptance Criteria:**
- [ ] Function signature approved by user
- [ ] All 6 constructs can be analyzed with single function call
- [ ] Output structure matches current CSV format exactly
- [ ] Effect sizes computed correctly (rank-biserial r, eta-squared)

### Task 1.2: Implement Core Helper Functions
**Priority:** High
**Estimated Time:** 2-3 hours

**Sub-functions to create:**

| Function | Purpose | Est. Lines |
|----------|---------|------------|
| `prepare_construct_data()` | Pivot to long, add respondent_id | 25 |
| `compute_descriptives()` | Median, IQR, % ranked #1 | 30 |
| `run_friedman_test()` | Friedman + formatted output | 20 |
| `safe_wilcox_test()` | Existing, minor refactor | 40 |
| `safe_kruskal_test()` | Existing, minor refactor | 40 |
| `run_demographic_comparison()` | Dispatch to MW or KW | 35 |
| `apply_holm_correction()` | Add p_adj_holm column | 15 |
| `export_construct_tables()` | Write 7 CSVs per construct | 40 |
| `create_median_rank_chart()` | ggplot bar chart | 30 |

**Total estimated:** ~275 lines (vs ~600 current)

**Acceptance Criteria:**
- [ ] All helper functions implemented
- [ ] Unit tested against known outputs from current code
- [ ] Documentation comments in code

### Task 1.3: Implement `analyze_construct()` Main Function
**Priority:** High
**Estimated Time:** 1 hour

**Actions:**
1. Combine helper functions into main orchestrator
2. Add error handling and logging
3. Add minimum group size checks (n >= 5)
4. Return comprehensive results list

**Acceptance Criteria:**
- [ ] Single function call produces all outputs for one construct
- [ ] Handles edge cases gracefully (small n, missing data)
- [ ] Results match current output exactly

### Task 1.4: Implement Hierarchical FDR Screening
**Priority:** High
**Estimated Time:** 45 minutes

**Function:**
```r
apply_hierarchical_fdr <- function(
  construct_results,
  fdr_q = 0.10
) {
  # Extract screening p-values
  screening_pvals <- map_dbl(construct_results, "screening_p")

  # Apply BH-FDR
  screening_adj <- p.adjust(screening_pvals, method = "BH")

  # Create screening results table
  screening_table <- tibble(
    construct = names(construct_results),
    min_p = screening_pvals,
    p_adj_fdr = screening_adj,
    passes_screen = screening_adj < fdr_q
  )

  return(screening_table)
}
```

**Acceptance Criteria:**
- [ ] Screening table matches current format
- [ ] BH-FDR calculation verified correct
- [ ] Passes/fails correctly flagged

### Task 1.5: Validate Refactored Output
**Priority:** Critical
**Estimated Time:** 1 hour

**Validation Protocol:**
1. Run refactored code on same data
2. Compare all 42 CSV files to originals (byte-level or row-level)
3. Compare 6 PNG figures to originals
4. Verify screening results match
5. Document any differences and justify

**Acceptance Criteria:**
- [ ] All 42 CSVs match (or differences explained)
- [ ] All 6 figures match
- [ ] Screening results identical
- [ ] Validation report created

---

## Phase 2: Combine QMD Documents

### Task 2.1: Migrate Data Loading & Preprocessing
**Priority:** High
**Estimated Time:** 45 minutes

**Actions:**
1. Copy data loading from `retention.qmd` (lines 39-89)
2. Merge preprocessing logic (both files have similar recoding)
3. Consolidate demographic variable creation
4. Ensure all variables needed by both analyses are created

**Unified Preprocessing Checklist:**
- [ ] age_group (≤35 vs >35)
- [ ] exp_q (quartiles)
- [ ] gender (Male/Female/Other)
- [ ] military_bg (Yes/No)
- [ ] position (Captain/First Officer)
- [ ] carrier_grp (Regional/Major/LCC/Other)
- [ ] respondent_id (for Friedman tests)

**Acceptance Criteria:**
- [ ] Single preprocessing section handles all needs
- [ ] No redundant recoding
- [ ] All variables created correctly

### Task 2.2: Migrate Retention Analysis Section
**Priority:** High
**Estimated Time:** 1 hour

**Actions:**
1. Copy RQ1-RQ2 chunks from `retention.qmd`
2. Clean up redundant library() calls (move to setup)
3. Standardize table/figure numbering
4. Ensure consistent p-value column naming (p_raw, p_adj_fdr)

**Sections to Include:**
- General factor rankings (Friedman)
- Age group comparisons
- Experience quartile comparisons
- Gender comparisons
- Military background comparisons
- Position comparisons
- Carrier type comparisons
- Summary heatmap

**Acceptance Criteria:**
- [ ] All retention analyses preserved
- [ ] Tables numbered sequentially
- [ ] No library conflicts

### Task 2.3: Migrate Subfactor Analysis Section
**Priority:** High
**Estimated Time:** 1 hour

**Actions:**
1. Add refactored helper functions to setup chunk
2. Replace 6 construct sections with loop:
```r
# Define all constructs
constructs <- list(
  financial = list(prefix = "financial_", n = 6, labels = financial_labels),
  qol = list(prefix = "qol_", n = 6, labels = qol_labels),
  professional = list(prefix = "professional_", n = 5, labels = professional_labels),
  recognition = list(prefix = "recognition_", n = 4, labels = recognition_labels),
  schedule = list(prefix = "schedule_", n = 5, labels = schedule_labels),
  operational = list(prefix = "operational_", n = 5, labels = operational_labels)
)

# Analyze all constructs
subfactor_results <- map(names(constructs), ~{
  analyze_construct(
    data = included_data,
    construct_name = .x,
    variable_prefix = constructs[[.x]]$prefix,
    item_labels = constructs[[.x]]$labels,
    n_items = constructs[[.x]]$n
  )
})
names(subfactor_results) <- names(constructs)

# Apply hierarchical FDR
screening_results <- apply_hierarchical_fdr(subfactor_results)
```
3. Add output sections for each construct's tables and figures

**Acceptance Criteria:**
- [ ] All 6 constructs analyzed
- [ ] ~600 lines reduced to ~50 lines
- [ ] All outputs generated correctly

### Task 2.4: Create Comparison Summary Tables
**Priority:** High
**Estimated Time:** 1.5 hours

**Required Tables:**

**Table A: Retention Analysis Summary**
| Demographic | Tests | Sig (raw) | Sig (FDR q=0.10) | Sig (Bonferroni) |
|-------------|-------|-----------|------------------|------------------|
| Age | 6 | X | Y | Z |
| Experience | 6 | X | Y | Z |
| ... | ... | ... | ... | ... |

**Table B: Subfactor Analysis Screening Summary**
| Construct | Min p | p_adj (FDR) | Passes Screen | Holm Sig Count |
|-----------|-------|-------------|---------------|----------------|
| Financial | X | Y | Yes/No | Z |
| ... | ... | ... | ... | ... |

**Table C: Combined Type I Error Comparison**
| Analysis | Total Tests | Raw Sig | FDR Sig | Bonferroni Sig |
|----------|-------------|---------|---------|----------------|
| Retention | 30 | X | Y | Z |
| Subfactor | 155 | X | Y | Z |

**Implementation:**
```r
create_comparison_summary <- function(retention_results, subfactor_results) {
  # Compute counts under each correction method
  # Return formatted tables for publication
}
```

**Acceptance Criteria:**
- [ ] All three summary tables generated
- [ ] Numbers verified against raw output
- [ ] Tables formatted for publication

### Task 2.5: Statistical Methods Section
**Priority:** High
**Estimated Time:** 30 minutes

**Actions:**
1. Consolidate methods text from both QMDs
2. Update to reflect unified analysis
3. Ensure all references included

**Content:**
- Sample description
- Non-parametric test rationale
- Hierarchical FDR approach (detailed)
- Within-subjects vs between-subjects handling
- Effect size interpretations
- Software/packages used

**Acceptance Criteria:**
- [ ] Methods complete and accurate
- [ ] Suitable for journal submission
- [ ] References formatted correctly

---

## Phase 3: Polish & Validation

### Task 3.1: Clean Console Output
**Priority:** Medium
**Estimated Time:** 30 minutes

**Actions:**
1. Remove verbose `cat()` statements from rendered output
2. Keep diagnostic output for interactive use only
3. Use Quarto callouts for important notes

**Acceptance Criteria:**
- [ ] Rendered document clean and professional
- [ ] No debugging output in final HTML/DOCX

### Task 3.2: Add Low-Power Warnings
**Priority:** Medium
**Estimated Time:** 30 minutes

**Actions:**
1. Add caveat section documenting sample limitations
2. Flag specific comparisons with low n (gender: 8 females)
3. Add interpretation guidance

**Acceptance Criteria:**
- [ ] Limitations clearly documented
- [ ] Reader understands power constraints

### Task 3.3: Final Validation & Testing
**Priority:** Critical
**Estimated Time:** 1 hour

**Protocol:**
1. Render unified QMD from clean environment
2. Verify all chunks execute without error
3. Compare key statistics to original outputs
4. Review all tables and figures for formatting
5. Proofread narrative sections

**Acceptance Criteria:**
- [ ] Full render completes without error
- [ ] All statistics match original
- [ ] Document ready for co-author review

### Task 3.4: Update Render Script
**Priority:** Medium
**Estimated Time:** 30 minutes

**Actions:**
1. Create `render_unified_analysis.R`
2. Add error handling with tryCatch
3. Add output verification (check file counts)
4. Update console messaging

**Acceptance Criteria:**
- [ ] Single command renders full analysis
- [ ] Failures reported clearly
- [ ] Output files verified

---

## Custom Claude Agents (CREATED)

**Status:** Agents created and approved on 2025-11-21
**Location:** `.claude/agents/` (project-level)

| Agent | File | Purpose |
|-------|------|---------|
| r-statistical-coder | `.claude/agents/r-statistical-coder.md` | R code implementation & refactoring |
| r-test-validator | `.claude/agents/r-test-validator.md` | Output validation & comparison |
| quarto-integrator | `.claude/agents/quarto-integrator.md` | QMD merging & document structure |
| academic-reviewer | `.claude/agents/academic-reviewer.md` | Publishing readiness review |

---

### Agent 1: `r-statistical-coder`

**Purpose:** Implements and refactors R statistical analysis code

**Capabilities:**
- Write R functions following tidyverse style
- Implement non-parametric statistical tests
- Handle edge cases in small samples
- Export results to CSV/PNG

**Creation Prompt Items:**
```
- Expert in R statistical programming, tidyverse, and rstatix packages
- Understands non-parametric tests (Mann-Whitney U, Kruskal-Wallis, Friedman)
- Follows tidyverse style guide strictly
- Always includes error handling with tryCatch
- Documents functions with roxygen2-style comments
- Tests edge cases: n < 5, missing data, single-group scenarios
- Preserves exact output format when refactoring existing code
- Uses effect sizes: rank-biserial r for MW, eta-squared for KW
- Implements multiple testing corrections: Holm, BH-FDR
```

### Agent 2: `r-test-validator`

**Purpose:** Validates that refactored code produces identical outputs

**Capabilities:**
- Compare CSV files for exact match
- Compare numeric outputs with tolerance
- Generate validation reports
- Identify discrepancies

**Creation Prompt Items:**
```
- Compares two sets of CSV files for exact or near-exact match
- Reports row counts, column names, and value differences
- Uses configurable numeric tolerance for floating-point comparisons
- Generates markdown validation report
- Identifies which specific values differ and by how much
- Can compare PNG files via hash or visual diff
- Outputs clear pass/fail status for each file
```

### Agent 3: `quarto-integrator`

**Purpose:** Combines and structures Quarto documents

**Capabilities:**
- Merge QMD sections intelligently
- Resolve library conflicts
- Maintain consistent formatting
- Number tables/figures sequentially

**Creation Prompt Items:**
```
- Expert in Quarto markdown and YAML configuration
- Merges R code chunks while avoiding namespace conflicts
- Consolidates library() calls to single setup chunk
- Maintains consistent code-fold, echo, warning settings
- Numbers tables and figures sequentially across sections
- Uses Quarto callouts for notes and warnings
- Ensures cross-references work correctly
- Validates YAML syntax before output
```

### Agent 4: `academic-reviewer`

**Purpose:** Reviews document for academic publishing readiness

**Capabilities:**
- Check statistical reporting standards (APA)
- Verify table/figure formatting
- Review methods clarity
- Flag missing information

**Creation Prompt Items:**
```
- Reviews statistical analysis reports for academic publishing standards
- Checks APA-style reporting of statistics (F, p, effect sizes)
- Verifies tables have proper captions, column headers, notes
- Ensures figures have axis labels, legends, captions
- Flags unclear or incomplete methods descriptions
- Checks that all claims are supported by presented data
- Identifies missing sample sizes, degrees of freedom
- Reviews limitations section for completeness
```

---

## Task Dependencies & Sequencing

```
Phase 0 (Setup)
├── 0.1 Archive QMDs ─────────────────┐
└── 0.2 Create Shell ─────────────────┼──► Phase 1 Start
                                      │
Phase 1 (Refactor)                    │
├── 1.1 Design Functions ◄────────────┘
├── 1.2 Implement Helpers ◄─── 1.1
├── 1.3 Main Function ◄─────── 1.2
├── 1.4 Hierarchical FDR ◄──── 1.3
└── 1.5 Validate ◄──────────── 1.4 ───┐
                                      │
Phase 2 (Combine)                     │
├── 2.1 Data Loading ◄────────────────┤
├── 2.2 Retention Section ◄─── 2.1    │
├── 2.3 Subfactor Section ◄─── 1.5 ───┘
├── 2.4 Summary Tables ◄────── 2.2, 2.3
└── 2.5 Methods Section ◄───── 2.4 ───┐
                                      │
Phase 3 (Polish)                      │
├── 3.1 Clean Output ◄────────────────┤
├── 3.2 Low-Power Warnings ◄── 3.1    │
├── 3.3 Final Validation ◄──── 3.2    │
└── 3.4 Update Render Script ◄─ 3.3   │
                                      │
                            COMPLETE ◄┘
```

---

## Risk Register

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Refactored output differs from original | High | Medium | Task 1.5 validation protocol |
| coin package dependency breaks | High | Low | Document in README, test on clean install |
| Time overrun on refactoring | Medium | Medium | Time-box each task, prioritize core functions |
| Merge conflicts between analyses | Low | Low | Careful variable naming, separate namespaces |
| Quarto render failures | Medium | Low | Test incrementally, backup working versions |
| **Namespace conflicts (coin/rstatix)** | **High** | **HIGH - OCCURRED** | **Use explicit `rstatix::` prefix** |
| **Tidyeval formula issues** | **Medium** | **HIGH - OCCURRED** | **Use `reformulate()` and `.data[[var]]`** |

---

## Lessons Learned (Session 2025-11-21)

### Critical: Package Namespace Conflicts

The `coin` package masks several `rstatix` functions. **Always use explicit namespace prefixes:**

```r
# WRONG - will use coin:: version
friedman_test(data, formula)
wilcox_test(data, formula)

# CORRECT - explicit rstatix namespace
rstatix::friedman_test(data, formula)
rstatix::wilcox_test(data, formula)
rstatix::kruskal_test(data, formula)
rstatix::pairwise_wilcox_test(data, formula)
rstatix::wilcox_effsize(data, formula)
rstatix::kruskal_effsize(data, formula)
rstatix::adjust_pvalue(data, method = "holm")
rstatix::add_significance(data, "p.adj")
```

### Critical: Tidyeval Does NOT Work in Formula Context

The `!!sym()` operator does NOT work when creating formulas:

```r
# WRONG - !!sym() is not evaluated in formula context
safe_wilcox_test(rank ~ !!sym(demo_var), exact = exact)

# CORRECT - use reformulate()
test_formula <- reformulate(demo_var, "rank")
safe_wilcox_test(test_formula, exact = exact)
```

### Critical: Use `.data[[var]]` Instead of `!!sym(var)`

For dplyr verbs, `.data[[var]]` is more reliable than `!!sym(var)`:

```r
# WRONG - can fail in certain contexts
data %>% filter(!is.na(!!sym(group_var)))

# CORRECT - use .data pronoun
data %>% filter(!is.na(.data[[group_var]]))
```

### Medium: Column Name Conflicts in Rename

When using `adjust_pvalue()`, the original `p` column must be removed before renaming:

```r
# WRONG - creates duplicate 'p' column
result %>%
  mutate(p_raw = p) %>%
  adjust_pvalue(method = "holm") %>%
  rename(p = p_raw)  # ERROR: 'p' already exists

# CORRECT - remove original p first
result %>%
  mutate(p_raw = p) %>%
  adjust_pvalue(method = "holm") %>%
  select(-p) %>%  # Remove original
  rename(p = p_raw)
```

### Medium: Explicit Argument Passing in Quarto

Default function arguments may not resolve correctly across Quarto chunks. Pass arguments explicitly:

```r
# RISKY - default_demographics may not resolve
analyze_construct(data = included_data, ...)

# SAFER - explicit argument
analyze_construct(data = included_data, demographics = default_demographics, ...)
```

### Low: YAML Settings for Clean Output

Use `echo: false` to hide code in rendered documents:

```yaml
execute:
  warning: false
  message: false
  echo: false  # Hide code blocks in output
```

---

## Sign-off Checklist

Before proceeding with implementation:

- [x] User approves function architecture (Task 1.1)
- [x] User approves document structure
- [x] User approves agent specifications (agents created in `.claude/agents/`)
- [x] User confirms time-box acceptable (3 days)
- [x] User confirms Phase 0 can proceed

**Approval:**
Name: Michael J. Hickey
Signature/Date: HY//20251121

---

## Appendix A: Current Code Metrics

| File | Lines | Chunks | Constructs | Duplication |
|------|-------|--------|------------|-------------|
| subfactor_analysis.qmd | 1,543 | ~45 | 6 | ~600 lines |
| retention.qmd | 1,041 | ~35 | 1 | ~50 lines |
| **Combined (current)** | **2,584** | **~80** | **7** | **~650 lines** |
| **Unified (target)** | **~1,200** | **~40** | **7** | **~50 lines** |

**Target Reduction:** ~53% fewer lines, ~50% fewer chunks

## Appendix B: Label Vectors (for reference)

```r
financial_labels <- c(
  "financial_1" = "Competitive salary",
  "financial_2" = "Allowances and soft pay",
  "financial_3" = "Benefits package",
  "financial_4" = "Disability insurance",
  "financial_5" = "Job security",
  "financial_6" = "New hire/longevity bonuses"
)

qol_labels <- c(
  "qol_1" = "Predictable schedule",
  "qol_2" = "Vacation time",
  "qol_3" = "Family-friendly policies",
  "qol_4" = "Possibility of being based at home",
  "qol_5" = "Travel benefits",
  "qol_6" = "Work-life balance"
)

professional_labels <- c(
  "professional_1" = "Financially stable airline",
  "professional_2" = "Opportunity for rapid upgrade",
  "professional_3" = "Opportunity to fly larger aircraft",
  "professional_4" = "Promotion/upgrade based on merit",
  "professional_5" = "Upgrade based on length of service"
)

recognition_labels <- c(
  "recognition_1" = "Professional-looking uniforms",
  "recognition_3" = "Additional vacation for long service",
  "recognition_4" = "Recognition as a professional",
  "recognition_7" = "Airline recognition"
)

schedule_labels <- c(
  "schedule_1" = "Fixed schedule",
  "schedule_2" = "Variable schedule",
  "schedule_3" = "Flexible work rules",
  "schedule_4" = "Bid line seniority system",
  "schedule_5" = "Vacation bidding rules"
)

operational_labels <- c(
  "operational_1" = "Unambiguous SOPs",
  "operational_2" = "Proactive training environment",
  "operational_3" = "Well-maintained aircraft",
  "operational_4" = "Well-equipped aircraft",
  "operational_5" = "Highly skilled fellow pilots"
)
```
