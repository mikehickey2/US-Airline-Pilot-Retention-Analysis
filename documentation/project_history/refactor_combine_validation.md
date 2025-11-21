# Refactor Combine Branch - Validation Report

**Branch:** `subfactor_analysis` (refactor_combine work)
**Validation Date:** November 21, 2025
**Validator:** Claude Code (r-test-validator agent)

---

## Executive Summary

| Category | Expected | Actual | Status |
|----------|----------|--------|--------|
| Subfactor CSV files | 43 | 43 | PASS |
| PNG figures | 6 | 6 | PASS |
| Unified CSV files | 2 | 2 | PASS |
| HTML report | 1 | 1 | PASS |
| DOCX report | 1 | 1 | PASS |
| Render completes without error | Yes | Yes | PASS |

**Overall Status:** ALL CHECKS PASSED

---

## 1. File Inventory Verification

### 1.1 Subfactor Analysis CSVs (43 files)

**Location:** `output/tables/subfactor_analysis/`

| Construct | Descriptive | Friedman | Age | Gender | Position | Military | Experience |
|-----------|-------------|----------|-----|--------|----------|----------|------------|
| Financial | financial_descriptive.csv | financial_friedman.csv | financial_age.csv | financial_gender.csv | financial_position.csv | financial_military.csv | financial_experience.csv |
| Quality of Life | quality_of_life_descriptive.csv | quality_of_life_friedman.csv | quality_of_life_age.csv | quality_of_life_gender.csv | quality_of_life_position.csv | quality_of_life_military.csv | quality_of_life_experience.csv |
| Professional | professional_descriptive.csv | professional_friedman.csv | professional_age.csv | professional_gender.csv | professional_position.csv | professional_military.csv | professional_experience.csv |
| Recognition | recognition_descriptive.csv | recognition_friedman.csv | recognition_age.csv | recognition_gender.csv | recognition_position.csv | recognition_military.csv | recognition_experience.csv |
| Schedule | schedule_descriptive.csv | schedule_friedman.csv | schedule_age.csv | schedule_gender.csv | schedule_position.csv | schedule_military.csv | schedule_experience.csv |
| Operational | operational_descriptive.csv | operational_friedman.csv | operational_age.csv | operational_gender.csv | operational_position.csv | operational_military.csv | operational_experience.csv |

**Plus:** `screening_results.csv` (hierarchical FDR screening)

**Count:** 6 constructs × 7 files + 1 screening = **43 files** - VERIFIED

### 1.2 PNG Figures (6 files)

**Location:** `output/figures/subfactor_analysis/`

| File | Description |
|------|-------------|
| financial_median_ranks.png | Financial subfactor priorities |
| quality_of_life_median_ranks.png | QoL subfactor priorities |
| professional_median_ranks.png | Professional subfactor priorities |
| recognition_median_ranks.png | Recognition subfactor priorities |
| schedule_median_ranks.png | Schedule subfactor priorities |
| operational_median_ranks.png | Operational subfactor priorities |

**Count:** 6 files - VERIFIED

### 1.3 Unified Analysis CSVs (2 files)

**Location:** `output/tables/unified_analysis/`

| File | Description |
|------|-------------|
| retention_factor_summary.csv | General factor demographic comparisons |
| combined_results_summary.csv | Combined Part 1 + Part 2 summary |

**Count:** 2 files - VERIFIED

### 1.4 Rendered Reports

**Location:** `output/reports/`

| File | Size | Status |
|------|------|--------|
| unified_retention_analysis.html | ~3 MB | Generated |
| unified_retention_analysis.docx | ~240 KB | Generated |

---

## 2. Render Execution Verification

### 2.1 Entry Point Test

```r
source("render_unified_analysis.R")
```

**Result:** Completed successfully with all checks passed

### 2.2 Console Output Summary

```
============================================================
  UNIFIED RETENTION ANALYSIS RENDER SCRIPT
============================================================

Input:   scripts/analysis/unified_retention_analysis.qmd
Output:  output/reports

Rendering document (this may take 2-3 minutes)...

Moving rendered files to final location...

============================================================
  OUTPUT VERIFICATION
============================================================

Subfactor CSVs:  43 / 43
Unified CSVs:    2 / 2
PNG figures:     6 / 6

HTML report:     OK
DOCX report:     OK

============================================================
  RENDER COMPLETE - ALL CHECKS PASSED
============================================================
```

---

## 3. Functional Requirements Verification

| Requirement | Description | Status |
|-------------|-------------|--------|
| FR-1 | Single unified document | PASS - `unified_retention_analysis.qmd` |
| FR-2 | Archive originals | PASS - `archive/original_qmds/` contains retention.qmd, subfactor_analysis.qmd |
| FR-3 | Optimize analysis code | PASS - Helper functions replace duplicated code |
| FR-4 | Self-contained script | PASS - All logic in QMD, no external helpers |
| FR-5 | Remove shell-script dependencies | PASS - R-only workflow |

---

## 4. Output Schema Verification

### 4.1 Demographic CSV Schema (Spot Check)

**File:** `financial_age.csv`

| Column | Type | Description |
|--------|------|-------------|
| item | character | Subfactor label |
| statistic | numeric | Mann-Whitney U statistic |
| p | numeric | Raw p-value |
| p_adj_holm | numeric | Holm-adjusted p-value |
| p.adj.signif | character | Significance stars |
| effsize | numeric | Rank-biserial r |
| magnitude | character | Effect size interpretation |

**Schema matches expected format:** PASS

### 4.2 Effect Sizes Populated

Verified effect sizes are not NA:
- `financial_age.csv`: effsize values populated
- `financial_gender.csv`: effsize values populated
- `quality_of_life_experience.csv`: eta-squared values populated

**No NA regressions:** PASS

---

## 5. Known Limitations

1. **Gender comparisons:** n=8 females vs n=67 males - extremely underpowered
2. **Age split:** n=18 (<=35) vs n=58 (>35) - moderately imbalanced
3. **Multiple testing:** 155 tests with hierarchical FDR control

These are documented in the Limitations section of the unified analysis.

---

## 6. Validation Checklist Summary

- [x] All 43 subfactor CSVs generated
- [x] All 6 PNG figures generated
- [x] All 2 unified CSVs generated
- [x] HTML report renders
- [x] DOCX report renders
- [x] Effect sizes populated (no NA regression)
- [x] Holm-adjusted p-values included
- [x] Screening results CSV generated
- [x] Render script completes without error
- [x] Output directory structure correct

---

**Validation Complete:** November 21, 2025
**Validated By:** Claude Code
**Status:** APPROVED FOR MERGE
