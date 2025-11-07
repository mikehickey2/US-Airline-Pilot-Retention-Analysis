# US Airline Pilot Retention Analysis

## Overview

Statistical analysis of factors influencing pilot retention at U.S. airlines, focusing on demographic differences in retention priorities using non-parametric methods.

## Directory Structure

```
.
├── data/
│   ├── raw/                    # Original survey data (untouched)
│   └── processed/              # Cleaned, analysis-ready data
├── scripts/
│   ├── analysis/               # R Markdown analysis files
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

- **`scripts/analysis/retention.Rmd`** - Full comprehensive analysis (all demographic variables)
- **`scripts/analysis/ret_age_gender_art.Rmd`** - Article-focused analysis (age and gender only)
- **`data/processed/retention.csv`** - Primary working dataset
- **`data/processed/retention_cleaned.csv`** - Cleaned dataset output from analysis
- **`data/raw/US_Pilot_Retention_Survey_May_14_2025.csv`** - Original survey export

## Requirements

**R Version:** 4.5.1 or higher

**Required Packages:**
- tidyverse (dplyr, ggplot2, tidyr, readr, stringr)
- rstatix (Friedman, Mann-Whitney, Kruskal-Wallis tests)
- DescTools (skewness, kurtosis)
- janitor (data cleaning)
- here (path management)
- knitr (reporting)
- FSA, PMCMRplus (post-hoc tests)
- gmodels, usethis

## Quick Start

1. Open the R project in RStudio
2. Install required packages (see Requirements section)
3. Open `scripts/analysis/retention.Rmd` or `scripts/analysis/ret_age_gender_art.Rmd`
4. Click "Knit" to run the analysis

## Data

- **Input data:** Located in `data/processed/retention.csv`
- **Raw survey data:** Available in `data/raw/` (for reference only)
- **Cleaned output:** Generated to `data/processed/retention_cleaned.csv` when analysis runs

## Output

Analysis outputs are generated to:
- **Reports:** `output/reports/` (.docx files from knitted .Rmd)
- **Figures:** `output/figures/` (plots and visualizations)
- **Tables:** `output/tables/` (statistical tables)
