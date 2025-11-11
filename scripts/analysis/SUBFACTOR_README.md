# Subfactor Analysis - Phase 1A

## Overview

This analysis examines the **31 sub-item rankings** within the six retention constructs to identify which specific elements pilots prioritize and how these priorities vary by demographics.

## Analysis File

**Primary file:** `subfactor_analysis.qmd`

This Quarto document contains comprehensive analysis of all six retention constructs:

1. **Financial** (6 sub-items) - Competitive salary, allowances/soft pay, benefits package, disability insurance, job security, new hire/longevity bonuses
2. **Quality of Life** (6 sub-items) - Predictable schedule, vacation time, family-friendly policies, home base possibility, travel benefits, work-life balance
3. **Professional Opportunity** (5 sub-items) - Financially stable airline, rapid upgrade opportunity, fly larger aircraft, merit-based promotion, seniority-based upgrade
4. **Recognition** (4 sub-items) - Professional uniforms, vacation for long service, professional respect/recognition, airline recognition
5. **Schedule** (5 sub-items) - Fixed schedule, variable schedule, flexible work rules, bid line seniority system, vacation bidding rules
6. **Operational** (5 sub-items) - Unambiguous SOPs, proactive training, well-maintained aircraft, well-equipped aircraft, highly skilled pilots

## For Each Construct, the Analysis Performs:

### 1. Descriptive Statistics
- Sample size (n)
- Median rank for each sub-item
- Mean and standard deviation
- Percentage ranked #1

### 2. Within-Construct Analysis
- **Friedman Test**: Tests if rankings differ significantly across sub-items within the construct

### 3. Demographic Comparisons

For each sub-item, tests if rankings differ by:

- **Age Group** (≤35 vs >35) - Mann-Whitney U test
- **Gender** (Male vs Female) - Mann-Whitney U test
- **Position** (Captain vs First Officer) - Mann-Whitney U test
- **Military Background** (Military vs Civilian) - Mann-Whitney U test
- **Experience** (Quartiles Q1-Q4) - Kruskal-Wallis test

### 4. Multiple Testing Correction

- Applies **Bonferroni correction** to all demographic comparisons
- Total tests: 155 demographic comparisons across all constructs
- Significance threshold: p.adj < 0.05

## How to Run the Analysis

### Option 1: Use Render Script (Recommended)

```r
source("render_subfactor_analysis.R")
```

This will:
- Render both HTML and DOCX formats
- Save outputs to `output/reports/`
- Display progress and completion status

### Option 2: In Positron/RStudio

1. Open `scripts/analysis/subfactor_analysis.qmd`
2. Click the **Render** button (or press Cmd+Shift+K)
3. Select format (HTML or DOCX)

### Option 3: Command Line

```bash
cd /path/to/retention
quarto render scripts/analysis/subfactor_analysis.qmd
```

## Expected Output

### Reports
- `output/reports/subfactor_analysis.html` - Interactive HTML report with formatted tables and visualizations
- `output/reports/subfactor_analysis.docx` - Word document for sharing/editing

Both reports include:
- Demographic summary tables
- Descriptive statistics for all 31 subfactors
- Friedman test results (formatted tables) for within-construct comparisons
- Mann-Whitney U and Kruskal-Wallis test results with Bonferroni corrections
- **Effect sizes** (rank-biserial r for Mann-Whitney, eta-squared for Kruskal-Wallis)
- Bar chart visualizations showing median ranks (highest priority on top)
- Conclusion summarizing key findings

### CSV Tables (42 files)
Automatically generated to `output/tables/subfactor_analysis/`:

**For each construct (Financial, QoL, Professional, Recognition, Schedule, Operational):**
- `[construct]_descriptive.csv` - Median ranks, means, SDs, % ranked #1
- `[construct]_friedman.csv` - Within-construct Friedman test results
- `[construct]_age.csv` - Mann-Whitney tests by age group (≤35 vs >35)
- `[construct]_gender.csv` - Mann-Whitney tests by gender
- `[construct]_position.csv` - Mann-Whitney tests by position (Captain vs FO)
- `[construct]_military.csv` - Mann-Whitney tests by military background
- `[construct]_experience.csv` - Kruskal-Wallis tests by experience quartiles

**Note:** All demographic tables include effect sizes and magnitude interpretations. Tables may be empty if insufficient group sizes.

### Figures (6 files)
Automatically generated to `output/figures/`:
- `[construct]_median_ranks.png` - Bar charts showing median rank for each subfactor (lower rank = higher priority, displayed top to bottom)

## Expected Runtime

- Full analysis completes in **1-2 minutes**
- Generates 155 statistical tests across all constructs

## Key Findings

The analysis revealed **no significant demographic differences** (p.adj < 0.05) in how pilots ranked subfactor priorities within any retention construct after Bonferroni correction. Pilots demonstrate remarkably consistent preferences regardless of age, gender, position, military background, or years of experience.

## Package Requirements

Core packages used:
- `tidyverse` - Data manipulation and visualization
- `rstatix` - Statistical tests (wilcox_test, kruskal_test, friedman_test)
- **`coin`** - Required for Mann-Whitney effect size computation (rank-biserial r)
- `knitr` - Report generation
- `janitor` - Data cleaning
- `DescTools` - Descriptive statistics

All packages are managed via `renv` for reproducibility. Run `renv::restore()` to install all required packages.

⚠️ **Critical:** The `coin` package is essential for effect size computation. Without it, all Mann-Whitney effect sizes will be `NA`.

## Notes

- **Sample size**: n=76 valid responses (after exclusions based on finished, consent, and screener criteria)
- **Non-parametric methods**: All tests use distribution-free methods appropriate for ranked data
- **Multiple testing correction**: Bonferroni correction applied to control Type I error rate
- **Readable labels**: All output uses survey instrument labels instead of variable names

## Troubleshooting

If you encounter errors:

1. **Effect sizes showing as NA**: This is the most common issue, caused by missing `coin` package.
   ```r
   # Install coin package
   renv::install("coin")

   # Verify installation
   library(coin)

   # Re-render analysis
   source("render_subfactor_analysis.R")

   # Check outputs
   read.csv("output/tables/subfactor_analysis/financial_age.csv")
   # effsize column should show numeric values, not NA
   ```

2. Ensure renv is activated and in sync:
   ```r
   renv::status()
   renv::restore()
   ```

   **Note:** If `renv::restore()` fails (e.g., Matrix compilation errors), manually install coin:
   ```r
   renv::install("coin")
   ```

3. Check that Quarto is installed:
   ```bash
   quarto --version
   ```

4. Verify you're in the project root directory when running the render script

## Questions?

See the main project README or contact the analysis team.
