# renv Setup - Clean Minimal Configuration

## ✅ Rebuild Complete!

Your renv environment has been successfully rebuilt with **only the packages needed for this project**.

### What Changed

**Before:** 200+ packages with broken symlinks and compilation errors

**Now:** 11 core packages + dependencies (~160 total packages)

### Core Packages Installed

1. **tidyverse** - Data manipulation (dplyr, ggplot2, tidyr, readr, stringr, purrr, etc.)
2. **rstatix** - Statistical tests (Friedman, Mann-Whitney, Kruskal-Wallis)
3. **knitr** - Document rendering
4. **rmarkdown** - R Markdown/Quarto support
5. **FSA** - Fisheries statistics and post-hoc tests
6. **PMCMRplus** - Post-hoc multiple comparisons
7. **janitor** - Data cleaning utilities
8. **DescTools** - Descriptive statistics (Skew, Kurt, etc.)
9. **here** - Project-relative paths
10. **gmodels** - CrossTable and modeling
11. **usethis** - Project setup utilities

All dependencies were automatically installed as binaries (no compilation required).

## How to Use

### Starting R/Positron

When you open the project, renv will **automatically activate**. You'll see:
```
Project loaded: renv 1.1.5
```

### Running Your Analysis

Just open and render your `.qmd` or `.Rmd` files as normal:

```r
# In Positron/RStudio
# Open: scripts/analysis/subfactor_analysis.qmd
# Click: Render button
```

Or use the render script:
```r
source("render_subfactor_analysis.R")
```

### Package Management

**Installing new packages:**
```r
install.packages("package_name")
renv::snapshot()  # Save to lockfile
```

**Updating packages:**
```r
renv::update("package_name")  # Or update all with renv::update()
```

**Checking status:**
```r
renv::status()  # See if project is in sync
```

**Restoring packages (on another computer):**
```r
renv::restore()  # Install all packages from lockfile
```

## Benefits of This Setup

✅ **Reproducible** - Anyone can clone your repo and run `renv::restore()` to get exact package versions

✅ **Isolated** - Project packages don't conflict with your system R libraries

✅ **Fast** - Uses binary packages (no compilation)

✅ **Clean** - Only packages you actually use

✅ **Version controlled** - `renv.lock` tracks exact package versions

## Files in This Setup

- `renv.lock` - Lockfile with all package versions (commit to git)
- `renv/` - Package library (don't commit to git, in .gitignore)
- `.Rprofile` - Auto-activates renv when R starts
- `renv/activate.R` - renv activation script

## Troubleshooting

**If renv doesn't activate:**
```r
renv::activate()
```

**If packages are out of sync:**
```r
renv::restore()  # Install missing packages
# OR
renv::snapshot()  # Update lockfile with current packages
```

**To disable renv temporarily:**
```r
renv::deactivate()
```

**To completely remove renv:**
1. Delete `renv/` folder
2. Delete `.Rprofile`
3. Delete `renv.lock`

## Next Steps

You're all set! Just:

1. **Restart Positron/RStudio** (to ensure clean renv activation)
2. **Run your analysis**: Open and render `subfactor_analysis.qmd`
3. **Commit the lockfile**: `git add renv.lock && git commit -m "Add clean renv setup"`

---

**Created:** November 9, 2025
**renv version:** 1.1.5
**R version:** 4.5.2
**Core packages:** 11
**Total packages (with dependencies):** 161
