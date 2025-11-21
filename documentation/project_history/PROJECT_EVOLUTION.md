# Project Evolution

This document traces the development history of the US Airline Pilot Retention Analysis repository, from its origins through major refactoring milestones.

---

## Repository Origins

| Field | Value |
|-------|-------|
| **Created** | November 7, 2025 |
| **Cloned From** | [MS-Thesis-US-Airline-Pilot-Retention](https://github.com/mikehickey2/MS-Thesis-US-Airline-Pilot-Retention) |
| **Purpose** | Article-focused analysis extracted from doctoral thesis |

This repository was created by cloning the original thesis repository and restructuring for journal article publication. The thesis repository contains the complete dissertation work; this repository focuses on the retention factor analysis suitable for peer-reviewed publication.

---

## Development Timeline

### Phase 0: Repository Creation (Nov 7, 2025)

**Branch:** `main`

- Cloned from thesis repository
- Reorganized project structure with professional R workflow
- Migrated to Positron IDE and Quarto workflow
- Established `renv` for reproducible package management

### Phase 1: Subfactor Analysis Development (Nov 8-19, 2025)

**Branch:** `subfactor_analysis`

Extended the original general retention factor analysis to examine 31 individual subfactors within 6 constructs.

| Document | Description |
|----------|-------------|
| [subfactor_analysis_plan.md](subfactor_analysis_plan.md) | Original analysis plan and methodology |
| [subfactor_analysis_validation.md](subfactor_analysis_validation.md) | Validation results for subfactor branch |

**Key Deliverables:**
- Friedman tests for subfactor prioritization within constructs
- Demographic comparisons (age, gender, position, military, experience)
- Effect size calculations (rank-biserial r, eta-squared)
- Median rank visualizations

### Phase 2: Type I Error Control (Nov 19-20, 2025)

**Branch:** `TypeI_error_rework`

Implemented rigorous multiple testing correction using hierarchical FDR approach.

**Changes:**
- Benjamini-Hochberg screening at construct level (q=0.10)
- Holm correction within significant constructs
- 155 total statistical tests controlled

### Phase 3: Refactor & Combine (Nov 20-21, 2025)

**Branch:** `refactor_combine`

Major refactoring to consolidate two separate QMD files into a single unified analysis document.

| Document | Description |
|----------|-------------|
| [refactor_combine_design.md](refactor_combine_design.md) | Software design document with architecture decisions |
| [refactor_combine_project_plan.md](refactor_combine_project_plan.md) | Implementation plan with task breakdown |
| [refactor_combine_validation.md](refactor_combine_validation.md) | Final validation report |

**Key Changes:**
- Combined `retention.qmd` + `subfactor_analysis.qmd` → `unified_retention_analysis.qmd`
- Created reusable helper functions (1,411 lines of R code)
- Implemented hierarchical FDR workflow
- Added comprehensive licensing and documentation

**Outputs Verified:**
- 43 CSV statistical tables
- 6 PNG median rank figures
- HTML and DOCX rendered reports

---

## Branch Merge History

```
main
 │
 ├── subfactor_analysis (Nov 8)
 │    │
 │    ├── TypeI_error_rework (Nov 19)
 │    │    └── merged back to subfactor_analysis (Nov 20)
 │    │
 │    └── refactor_combine (Nov 20)
 │         └── merged back to subfactor_analysis (Nov 21)
 │
 └── subfactor_analysis merged to main (Nov 21)
```

---

## Archived Materials

The `archive/` directory (gitignored) contains:

| Directory | Contents |
|-----------|----------|
| `original_qmds/` | Pre-refactor `retention.qmd` and `subfactor_analysis.qmd` |
| `old_scripts/` | Superseded render and setup scripts |
| `subfactor_analysis/` | Old rendered outputs and extensions |
| `refactor_combine/` | Branch-specific validation artifacts |

These files are preserved locally for reference but excluded from version control to reduce repository size. Git history preserves all prior states if retrieval is needed.

---

## Current State

As of November 21, 2025:

- **Active Document:** `scripts/analysis/unified_retention_analysis.qmd`
- **Entry Point:** `render_unified_analysis.R`
- **Package Management:** `renv.lock` with `coin` dependency
- **License:** CC BY-NC 4.0

See [README.md](../../README.md) for usage instructions.
