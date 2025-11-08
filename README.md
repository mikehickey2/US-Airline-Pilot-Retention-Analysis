# US Airline Pilot Retention Analysis

## Overview

Statistical analysis of factors influencing pilot retention at U.S. airlines, focusing on demographic differences in retention priorities using non-parametric methods.

## Recent Updates

**Transition to Positron IDE & Quarto:** The project has migrated from RStudio/.Rmd to Positron/.qmd workflow. Recent experimental work focused on:
- Converting article manuscript to Quarto format with APA7 styling (apaquarto)
- Refining table formatting and professional column labels
- Adding complete manuscript sections (Abstract, Introduction, Method, Results)
- Creating automated render script for consistent output generation

The `.qmd` files now serve as the primary analysis documents, while `.Rmd` files are archived.

## Directory Structure

```
.
├── data/
│   ├── raw/                    # Original survey data (untouched)
│   └── processed/              # Cleaned, analysis-ready data
├── scripts/
│   ├── analysis/               # Quarto (.qmd) and R Markdown (.Rmd) analysis files
│   └── functions/              # Reusable R functions
├── output/
│   ├── figures/                # Generated plots and visualizations
│   ├── tables/                 # Generated statistical tables
│   └── reports/                # Rendered reports (.html, .pdf, .docx)
├── documentation/              # Codebooks, data dictionaries, methodology notes
├── archive/                    # Archived files and old versions
└── tmp/                        # Temporary files (gitignored)
```

## Key Files

- **`scripts/analysis/retention.qmd`** - Full comprehensive analysis (all demographic variables) - Quarto format
- **`scripts/analysis/ret_age_gender_art.qmd`** - Article-focused analysis (age and gender only) - APA format
- **`scripts/analysis/retention.Rmd`** - Full comprehensive analysis (R Markdown - archived)
- **`scripts/analysis/ret_age_gender_art.Rmd`** - Article-focused analysis (R Markdown - archived)
- **`data/processed/retention.csv`** - Primary working dataset
- **`data/processed/retention_cleaned.csv`** - Cleaned dataset output from analysis
- **`data/raw/US_Pilot_Retention_Survey_May_14_2025.csv`** - Original survey export

## Requirements

**R Version:** 4.5.1 or higher

**Required R Packages:**
- tidyverse (dplyr, ggplot2, tidyr, readr, stringr)
- rstatix (Friedman, Mann-Whitney, Kruskal-Wallis tests)
- DescTools (skewness, kurtosis)
- janitor (data cleaning)
- here (path management)
- knitr (reporting)
- FSA, PMCMRplus (post-hoc tests)
- gmodels, usethis

**Quarto Extensions:**
- [apaquarto](https://wjschne.github.io/apaquarto/) - APA-formatted manuscripts (7th edition)

## Quick Start

1. Open the R project in Positron or RStudio
2. Install required packages (see Requirements section)
3. Install Quarto extensions: `quarto add wjschne/apaquarto`
4. Open `scripts/analysis/retention.qmd` or `scripts/analysis/ret_age_gender_art.qmd`
5. Click "Render" (Quarto) to run the analysis

## Data

- **Input data:** Located in `data/processed/retention.csv`
- **Raw survey data:** Available in `data/raw/` (for reference only)
- **Cleaned output:** Generated to `data/processed/retention_cleaned.csv` when analysis runs

## Output

Analysis outputs are generated to:
- **Reports:** `output/reports/` (.docx and .html files from rendered .qmd)
- **Figures:** `output/figures/` (plots and visualizations)
- **Tables:** `output/tables/` (statistical tables)
