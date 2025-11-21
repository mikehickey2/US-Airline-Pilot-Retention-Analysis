# renv Setup - Clean Minimal Configuration

## Current Status: In Sync

Your renv environment is configured and working. All packages needed for the unified analysis are installed.

### Core Packages

| Package | Purpose |
|---------|---------|
| tidyverse | Data manipulation (dplyr, ggplot2, tidyr, readr, stringr, purrr) |
| rstatix | Statistical tests (Friedman, Mann-Whitney, Kruskal-Wallis) |
| **coin** | Required for Mann-Whitney effect sizes (rank-biserial r) |
| DescTools | Descriptive statistics (Skew, Kurt) |
| knitr | Document rendering |
| rmarkdown | Quarto support |
| janitor | Data cleaning utilities |
| here | Project-relative paths |
| FSA | Post-hoc tests |
| PMCMRplus | Multiple comparisons |
| gmodels | CrossTable and modeling |
| usethis | Project setup utilities |

## Quick Start

```r
# 1. Open project (renv activates automatically)
# 2. Restore packages if needed
renv::restore()

# 3. Run the unified analysis
source("render_unified_analysis.R")
```

## How renv Works

### Automatic Activation

When you open the project in RStudio/Positron, renv **automatically activates** via `.Rprofile`:

```
Project loaded: renv 1.1.5
```

### Running Your Analysis

```r
# Option 1: Use the render script (recommended)
source("render_unified_analysis.R")

# Option 2: Render directly
quarto::quarto_render("scripts/analysis/unified_retention_analysis.qmd")
```

## Package Management

### Installing New Packages

```r
renv::install("package_name")
renv::snapshot()  # Save to lockfile
```

### Updating Packages

```r
renv::update("package_name")  # Update specific package
renv::update()                # Update all packages
renv::snapshot()              # Save changes
```

### Checking Status

```r
renv::status()  # See if project is in sync
```

### Restoring Packages (New Computer)

```r
renv::restore()  # Install all packages from lockfile
```

## Critical: coin Package

The `coin` package is **required** for computing Mann-Whitney U effect sizes. Without it, effect sizes will show as `NA`.

**Verify coin is installed:**
```r
library(coin)  # Should load without error
```

**If missing:**
```r
renv::install("coin")
renv::snapshot()
```

## Files in This Setup

| File | Purpose | Git? |
|------|---------|------|
| `renv.lock` | Package versions | Yes (commit) |
| `renv/` | Package library | No (.gitignore) |
| `.Rprofile` | Auto-activation | Yes (commit) |
| `rebuild_renv.R` | Rebuild utility | Yes (commit) |

## Troubleshooting

### renv doesn't activate

```r
renv::activate()
```

### Packages are out of sync

```r
renv::status()    # Check what's different
renv::restore()   # Install missing packages
# OR
renv::snapshot()  # Update lockfile with current packages
```

### Effect sizes showing NA

The `coin` package is missing:
```r
renv::install("coin")
renv::snapshot()
# Restart R and re-render
```

### Complete rebuild

If renv is corrupted, run:
```r
source("rebuild_renv.R")
```

### Disable renv temporarily

```r
renv::deactivate()
```

## Benefits

- **Reproducible** - Clone repo, run `renv::restore()`, get exact versions
- **Isolated** - Project packages don't conflict with system R
- **Fast** - Uses binary packages (no compilation)
- **Clean** - Only packages you actually use
- **Version controlled** - `renv.lock` tracks exact versions

---

**Last Updated:** November 21, 2025
**renv version:** 1.1.5
**R version:** 4.5.1+
**Status:** In sync
