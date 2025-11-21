# US Airline Pilot Retention Analysis

## Overview

Statistical analysis of factors influencing pilot retention at U.S. airlines, focusing on demographic differences in retention priorities using non-parametric methods.

**View the analysis online:** [https://mikehickey2.github.io/US-Airline-Pilot-Retention-Analysis/](https://mikehickey2.github.io/US-Airline-Pilot-Retention-Analysis/)

## Repository Origins

This repository was created on **November 7, 2025** by cloning the original thesis repository:

**Source:** [MS-Thesis-US-Airline-Pilot-Retention](https://github.com/mikehickey2/MS-Thesis-US-Airline-Pilot-Retention)

The thesis repository contains the complete doctoral dissertation work. This repository extracts and extends the retention factor analysis for peer-reviewed journal publication.

## Quick Start

```r
# 1. Open project in RStudio/Positron
# 2. Restore R environment
renv::restore()

# 3. Render the unified analysis
source("render_unified_analysis.R")
```

This generates HTML and DOCX reports in `output/reports/`.

## Project Entry Points

| File | Purpose |
|------|---------|
| `render_unified_analysis.R` | Main render script (start here) |
| `rebuild_renv.R` | Utility to rebuild R environment |

## Analysis Document

**`scripts/analysis/unified_retention_analysis.qmd`** - The single unified analysis combining:

- **Part 1: General Retention Factors** - Rankings of 6 broad constructs with demographic comparisons
- **Part 2: Subfactor Analysis** - 31 subfactors within constructs with hierarchical FDR control

### Statistical Methods

- **Non-parametric tests**: Friedman, Mann-Whitney U, Kruskal-Wallis
- **Multiple testing correction**:
  - General factors: Benjamini-Hochberg FDR at q=0.10
  - Subfactors: Hierarchical FDR (BH screening + Holm within constructs)
- **Effect sizes**: Rank-biserial r, eta-squared

## Directory Structure

```
.
├── scripts/analysis/
│   └── unified_retention_analysis.qmd   # Main analysis document
├── data/
│   ├── raw/                             # Original survey data
│   └── processed/                       # Cleaned analysis-ready data
├── output/
│   ├── reports/                         # Rendered HTML/DOCX reports
│   ├── tables/                          # CSV statistical tables
│   └── figures/                         # PNG visualizations
├── documentation/
│   ├── project_history/                 # Development evolution docs
│   │   └── PROJECT_EVOLUTION.md         # Master timeline index
│   └── function_architecture.md         # Helper function specs
├── renv/                                # R environment (managed by renv)
├── render_unified_analysis.R            # Main entry point
├── rebuild_renv.R                       # renv utility
└── renv.lock                            # Package lockfile
```

*Note: `archive/` and `_freeze/` directories exist locally but are gitignored.*

## Requirements

**R Version:** 4.5.1 or higher

**Critical Package:** The `coin` package is required for effect size calculations.

```r
# Install all packages from lockfile
renv::restore()

# Or manually install coin if needed
renv::install("coin")
```

## Output Files

After running `render_unified_analysis.R`:

| Location | Contents |
|----------|----------|
| `output/reports/` | HTML and DOCX rendered reports |
| `output/tables/subfactor_analysis/` | 43 CSV files (descriptive stats, tests) |
| `output/tables/unified_analysis/` | 2 CSV files (summary tables) |
| `output/figures/subfactor_analysis/` | 6 PNG figures (median rank charts) |

## Verification

After rendering, verify output completeness:

```r
# Check CSV counts
length(list.files("output/tables/subfactor_analysis", pattern = "\\.csv$"))
# Expected: 43

# Check PNG counts
length(list.files("output/figures/subfactor_analysis", pattern = "\\.png$"))
# Expected: 6
```

## Sample

- **Total n:** 76 U.S. airline pilots
- **Demographic comparisons:** Age, gender, position, military background, experience
- **Note:** Limited power for some comparisons (especially gender: 8 females)

## Web Deployment

The analysis is published to GitHub Pages via Quarto's built-in publishing workflow.

**Live site:** [https://mikehickey2.github.io/US-Airline-Pilot-Retention-Analysis/](https://mikehickey2.github.io/US-Airline-Pilot-Retention-Analysis/)

**To update the site after making changes:**
```bash
quarto publish gh-pages scripts/analysis/unified_retention_analysis.qmd
```

This renders the QMD locally and pushes only the HTML output to the `gh-pages` branch. GitHub Pages automatically serves the updated content.

*Note: This is manual deployment, not CI/CD. The R environment with all dependencies runs locally, avoiding complex GitHub Actions configuration.*

## Documentation

| Document | Description |
|----------|-------------|
| [LICENSE.md](LICENSE.md) | CC BY-NC 4.0 license terms |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Fork/clone guidelines, PR requirements, code standards |
| [RENV_SETUP.md](RENV_SETUP.md) | R environment setup and troubleshooting |
| [documentation/function_architecture.md](documentation/function_architecture.md) | Helper function specifications |
| [documentation/project_history/PROJECT_EVOLUTION.md](documentation/project_history/PROJECT_EVOLUTION.md) | Development timeline and branch history |

## Version History

| Date | Milestone |
|------|-----------|
| Nov 7, 2025 | Repository created (cloned from [thesis repo](https://github.com/mikehickey2/MS-Thesis-US-Airline-Pilot-Retention)) |
| Nov 8, 2025 | Subfactor analysis branch: 31 subfactors within 6 constructs |
| Nov 19, 2025 | Type I error control: Hierarchical FDR implementation |
| Nov 21, 2025 | Refactor & combine: Unified analysis document created |
| Nov 21, 2025 | GitHub Pages deployment: Analysis published online |

See [PROJECT_EVOLUTION.md](documentation/project_history/PROJECT_EVOLUTION.md) for detailed development history.

## License

This repository is licensed under the **Creative Commons Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0)**.

See [LICENSE.md](LICENSE.md) for full details.

### Summary

- **Non-commercial use only** - You may use, copy, adapt, and share for academic research, teaching, and personal study
- **Attribution required** - Credit must be given to the authors
- **Modifications allowed** - You may adapt the work, but must indicate changes and retain attribution
- **Commercial use requires permission** - Contact michael.j.hickey@und.edu for commercial licensing inquiries

### Research Team

| Author | Institution |
|--------|-------------|
| Michael J. Hickey (Lead, Corresponding) | University of North Dakota |
| Marina Efthymiou | Dublin City University |
| James Higgins | University of North Dakota |
| Aman Gupta | Embry-Riddle Aeronautical University |
| Robert Walton | Embry-Riddle Aeronautical University |

### Data Notice

Survey response data in `data/` may be subject to additional restrictions beyond the CC BY-NC 4.0 license. Contact the corresponding author before redistributing raw data.

### Citation

**Repository:**
> Hickey, M. J., Efthymiou, M., Higgins, J., Gupta, A., & Walton, R. (2025). *U.S. Airline Pilot Retention Analysis* [Code repository]. GitHub. https://github.com/mikehickey2/US-Airline-Pilot-Retention-Analysis

**Thesis:**
> Hickey, M. J. (2025). *Rethinking Pilot Retention in the United States: An Analysis of Key Factors* [Doctoral dissertation, University of North Dakota]. ProQuest Dissertations & Theses. https://www.proquest.com/docview/3246414757

**BibTeX:**
```bibtex
@misc{hickey2025retention_repo,
  author = {Hickey, Michael J. and Efthymiou, Marina and Higgins, James and Gupta, Aman and Walton, Robert},
  title = {U.S. Airline Pilot Retention Analysis},
  year = {2025},
  publisher = {GitHub},
  url = {https://github.com/mikehickey2/US-Airline-Pilot-Retention-Analysis}
}

@phdthesis{hickey2025retention_thesis,
  author = {Hickey, Michael J.},
  title = {Rethinking Pilot Retention in the United States: An Analysis of Key Factors},
  school = {University of North Dakota},
  year = {2025},
  note = {ProQuest ID: 3246414757},
  url = {https://www.proquest.com/docview/3246414757}
}
```
