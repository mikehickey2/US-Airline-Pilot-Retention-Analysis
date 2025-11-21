# Archived Scripts

**Archive Date:** November 21, 2025
**Reason:** Replaced by unified analysis workflow

## Archived Files

| File | Original Purpose | Replacement |
|------|-----------------|-------------|
| `render_retention.R` | Render retention.qmd | `render_unified_analysis.R` |
| `render_subfactor_analysis.R` | Render subfactor_analysis.qmd | `render_unified_analysis.R` |
| `render_article.sh` | Render ret_age_gender_art.qmd | N/A (file no longer exists) |

## New Workflow

All analysis is now consolidated in a single unified document:

```r
# From project root:
source("render_unified_analysis.R")
```

This renders `scripts/analysis/unified_retention_analysis.qmd` which combines:
- General retention factor analysis (formerly retention.qmd)
- Subfactor analysis (formerly subfactor_analysis.qmd)

## Do Not Use

These scripts reference QMD files that have been moved to `archive/original_qmds/`.
