
# Retention & Subfactor Analysis QMD Refactor – Software Design Document

## 0. Document Meta

- **Author(s):** Michael Hickey  
- **Date:** November 21, 2025  
- **Version:** 3.0
- **Status:** COMPLETE
- **Reviewers:** Michael Hickey, Claude
- **Revision History:**
  | Date             | Version | Author         | Change                                           |
  |------------------|---------|----------------|--------------------------------------------------|
  | November 21 2025 | 2.0     | Michael Hickey | Clean-sheet refactor design for QMD consolidation |
  | November 21 2025 | 3.0     | Claude Code    | Mark complete; all phases implemented successfully |

---

## 1. Overview

### 1.1 Problem Statement

For this branch, there are currently two QMD (Quarto notebook) files:

1. A QMD from an older retention analysis.
2. A QMD from a more recently completed subfactor analysis.

The purpose of this effort is to:

- Combine these two QMD notebooks into a single, unified notebook.
- Refactor and optimize the code for the subfactor analysis.
- Review and tune the entire script from front to back so that the combined QMD is appropriate and complete for academic publishing.

### 1.2 Background / Context

- The retention analysis and the subfactor analysis were initially implemented in separate QMD notebooks.
- The subfactor analysis has already gone through a more recent iteration, including updated Type I error control statistics (e.g., raw p-values, adjusted p-values such as Bonferroni or similar).
- The current codebase contains duplicated logic, ad-hoc loops, and possibly shell-script helpers. This increases maintenance cost, makes debugging harder, and complicates academic review.
- The long-term intent is to publish the unified analysis as a Quarto-based document (eventually deployed as a GitHub Pages site) for use by the research team and for transparency of methods.

### 1.3 Goals

1. **Optimize subfactor analysis.**  
   Refactor the subfactor analysis portion of the notebook to clean and optimize the code.

2. **Combine QMDs.**  
   Merge the retention QMD and the subfactor QMD into a single unified QMD that runs the entire pipeline.

3. **Optimize the entire script.**  
   Review and optimize the full notebook so that all analysis steps are clean, consistent, and efficient.

4. **Document results with tables and figures.**  
   Ensure that all key results are clearly documented using appropriate tables and figures suitable for academic publishing.

5. **Create summary tables of findings.**  
   - Summary table for the earlier retention analysis.  
   - Summary table for the subfactor analysis using updated Type I error statistics.  
   - For each analysis, present three statistics side by side:
     - Raw results,
     - New/updated error control statistics,
     - Older Bonferroni-based (or previous) error control results.

### 1.4 Non-Goals

- Do **not** make the Quarto document ready for web deployment in this branch (web polishing is deferred).
- Do **not** change the underlying analysis methodology (statistical approach remains the same).
- Do **not** add substantial new discussion or results-driven narrative that would materially change the interpretation of the existing work.

### 1.5 Success Metrics

- A **single QMD** that:
  - Runs the entire pipeline from start to finish, without external shell scripts or helper functions.
  - Produces all required tables, figures, and summary outputs in a reproducible way.
- Subfactor analysis code:
  - Uses shared, reusable loops or functions for repeated subfactor patterns.
  - Reduces duplicated code substantially while preserving correctness.
- The notebook:
  - Can be executed start-to-finish in a single run.
  - Is in a state suitable to be adapted, polished, and reproducible for academic publishing.

---

## 2. Stakeholders and Users

- **Primary user / owner:**  
  - Michael Hickey (author, maintainer).

- **Academic research team:**  
  - Co-authors and collaborators who will use the unified QMD to review the statistical analysis results for both the retention and subfactor analyses.

- **AI coding assistants:**  
  - Claude Code (and other coding agents) that will:
    - Refactor and optimize code.
    - Assist with testing, profiling, and validation.

### 2.1 Key Contacts and Governance Rules

- All substantive revisions to the analysis code and methodology must pass through Michael Hickey.
- No code work (especially refactoring or optimization) should begin until this design plan is completed and formally “approved” by Michael Hickey.
- No changes that materially alter the methodology or documented description of the analyses may be made without explicit prior approval by Michael Hickey.

---

## 3. Requirements

### 3.1 Functional Requirements

1. **FR-1: Single unified document.**  
   Combine the retention analysis QMD and the subfactor analysis QMD into one unified notebook.

2. **FR-2: Archive originals.**  
   Archive the two existing QMDs (retention and subfactor) in a safe location to ensure they remain unmodified and recoverable.

3. **FR-3: Optimize analysis code.**  
   Ensure that the subfactor analysis code, and ultimately the entire notebook, is refactored and optimized for clarity, maintainability, and efficiency.

4. **FR-4: Self-contained script.**  
   Ensure the entire pipeline can run from start to finish within the unified QMD without relying on external helper scripts or functions scattered elsewhere.

5. **FR-5: Remove shell-script dependencies.**  
   Eliminate any shell scripts currently required to run the full analysis, such that a single `quarto render` (or equivalent) is sufficient.

### 3.2 Non-Functional Requirements

- **Performance**
  - Execution time should be reasonable for iterative development (i.e., not excessively long), but ultra-high performance is not the primary goal.
- **Scalability**
  - Scaling to very large datasets is not required in the near term.
- **Reliability and Availability**
  - The notebook should execute deterministically from raw inputs to final outputs without manual intervention.
  - It should be robust to common failure modes (e.g., missing intermediate objects, stale caches).
- **Security**
  - The repository will be public-facing (or at least accessible to the research team) in the future.
  - No sensitive or private data should be embedded directly in the public repo.
  - Long-term: introduce appropriate licensing, clearly documented.

### 3.3 Constraints and Assumptions

- **Constraints**
  - Time and AI usage limits (e.g., rate limits, token costs) are significant and must be respected while using AI agents to refactor code.
  - Only Michael Hickey has direct write access to the main branch of the repository; others must use forks/branches/PRs.
- **Assumptions**
  - The initial optimization and merge work is expected to be done over the next three days (time-boxed effort).
  - The data and existing QMDs are already backed up in multiple locations.
  - Additional sub-agent infrastructure (for coding, testing, profiling, validation) will be available or actively developed during this work.

---

## 4. System Context and High-Level Architecture

### 4.1 System Context

- The primary artifact is a **unified Quarto QMD notebook** that:
  - Reads raw or pre-processed data.
  - Runs retention and subfactor analyses.
  - Produces statistical output, tables, and figures suitable for academic review.
- The notebook will be stored in a version-controlled repository (e.g., GitHub), and future plans include:
  - Deployment as a static Quarto site (e.g., GitHub Pages).
  - Review by the research team via a web interface.

### 4.2 High-Level Components

- **Unified Analysis QMD**
  - Contains all retention and subfactor analysis code and narrative.
- **Archived Legacy QMDs**
  - Original retention QMD.
  - Original subfactor QMD.
- **AI Agents (Planned Workflow)**
  - **Statistical coding agent**: performs refactors, implements loops and helper routines.
  - **Testing agent**: runs the notebook and verifies that all chunks execute without errors.
  - **Profiling/optimization agent**: analyzes performance and code structure, proposes or applies optimizations.
  - **Validation/publishing-readiness agent**: checks that outputs, tables, and figures are coherent, consistent, and suitable for academic publishing.

### 4.3 Key Data Flows

- Data input → unified QMD → retention analysis → subfactor analysis → summary tables → final figures/tables for publication.
- AI agents operate on:
  - The unified QMD source.
  - Supporting configuration files (if any).
  - Generated logs or profiling output (where applicable).

### 4.4 AI Agent Architecture

**Status:** IMPLEMENTED - Agent specifications finalized November 21, 2025

Four specialized agents were developed to support the refactoring workflow. These are configured as local Claude Code agents (gitignored) but documented here for reproducibility.

| Agent | Purpose | Key Responsibilities |
|-------|---------|---------------------|
| **r-statistical-coder** | Statistical coding | Implement helper functions, handle namespace conflicts, NSE patterns |
| **quarto-integrator** | Document integration | Chunk configurations, callouts, inline R, cross-references |
| **r-test-validator** | Output validation | Verify file counts, CSV schemas, render success |
| **academic-reviewer** | Publishing readiness | APA formatting, table/figure standards, limitations review |

#### Critical Lessons Learned (Captured in Agent Specs)

1. **Namespace Conflicts:** `coin` package masks `rstatix`; always use explicit `rstatix::` prefix
2. **Formula Creation:** Use `reformulate()` not `!!sym()` for dynamic formulas
3. **Column Selection:** Use `.data[[var]]` not `!!sym()` in tidyverse pipelines
4. **Chunk Labels:** Use label only once (either `{r label}` or `#| label:`, not both)
5. **Effect Sizes:** `coin` package required; check with `renv::restore()` or `renv::install("coin")`

> **Agent Specifications:** Local files in `.claude/agents/` (gitignored for local configuration)
>
> **Reuse Pattern:** Copy agent specs to new projects for consistent R/Quarto coding patterns

---

## 5. Detailed Design

**Status:** COMPLETE - Implementation documented November 21, 2025

### 5.1 Components / Modules

The unified QMD (`scripts/analysis/unified_retention_analysis.qmd`) contains these sections:

| Section | Lines (approx) | Responsibility |
|---------|----------------|----------------|
| **YAML/Setup** | 1-100 | Document metadata, package loading, helper function definitions |
| **Overview & Methods** | 100-200 | Statistical methods narrative, FDR approach documentation |
| **Data Loading** | 200-350 | Load CSV, demographic recoding, sample filtering |
| **Part 1: General Factors** | 350-750 | Retention analysis - Friedman test, 5 demographic comparisons |
| **Part 2: Subfactors** | 750-1500 | Helper functions, 6 construct analyses, hierarchical FDR |
| **Combined Summary** | 1500-1700 | Summary tables, limitations, references |

> **Full architecture details:** See `documentation/function_architecture.md`

### 5.2 Data Model

#### Input Data Structure
- **Source:** `data/processed/retention.csv`
- **Sample:** n=76 after exclusions (consent + finished filters)

#### Demographic Variables (hardcoded for reliability)
```r
demo_cols <- c("age_group", "gender_clean", "position", "military_clean", "exp_q")
```

#### Construct Variable Naming (IMPORTANT: Inconsistent)
| Construct | Pattern | Example |
|-----------|---------|---------|
| Financial | `financial_N` | `financial_1` through `financial_6` |
| Quality of Life | `qo_l_N` | `qo_l_1` through `qo_l_6` (underscore before number) |
| Professional | `professional_N` | `professional_1` through `professional_5` |
| Recognition | Non-sequential | `recognition_1`, `recognition_3`, `recognition_4`, `recognition_7` |
| Schedule | `schedule_N` | `schedule_1` through `schedule_5` |
| Operational | `operational_N` | `operational_1` through `operational_5` |

#### Output Data Structures
- **construct_data:** Long-format tibble with `respondent_id`, `item`, `rank`, demographic columns
- **demographic_results:** List of tibbles with `item`, `statistic`, `p`, `p_adj_holm`, `effsize`, `magnitude`

### 5.3 APIs and Interfaces

- **Entry Point:** `source("render_unified_analysis.R")` or `quarto render scripts/analysis/unified_retention_analysis.qmd`
- **Internal Interfaces:** All helper functions return tibbles; orchestrator `analyze_construct()` returns a named list

### 5.4 Core Logic / Workflows

#### Helper Function Pipeline (implemented in unified QMD)

```
analyze_construct()          # Main orchestrator
├── prepare_construct_data() # Wide → Long format with respondent_id
├── compute_descriptives()   # Median, mean, SD, %ranked#1
├── run_friedman_test()      # Within-construct rankings
├── run_demographic_comparison() × 5  # Per demographic
│   ├── Mann-Whitney U (binary)
│   └── Kruskal-Wallis (multi-level)
├── apply_holm_correction()  # Within-construct FDR
├── export_construct_tables() # CSV output
└── create_median_rank_chart() # PNG figure
```

#### Hierarchical FDR Workflow
1. Run all 6 constructs, collect minimum p-value per construct
2. Apply BH-FDR at q=0.10 to 6 screening p-values
3. For constructs passing screen: apply Holm at α=0.05 within construct

### 5.5 Implementation Summary - Design Deviations

The following changes were required during implementation due to R/Quarto runtime behavior:

| Design Assumption | Implementation Reality | Rationale |
|-------------------|----------------------|-----------|
| `!!sym()` for dynamic formulas | `reformulate(var, "rank")` | NSE doesn't work in formula context |
| `!!sym()` for column selection | `.data[[var]]` | More reliable in tidyverse pipelines |
| Demographics from config list | Hardcoded `demo_cols` vector | Avoid runtime evaluation issues |
| Implicit package namespaces | Explicit `rstatix::` prefix | `coin` masks `rstatix` functions |
| ~250 lines estimated | ~610 lines actual | Verbose output formatting, debug fixes |

> **Full details:** See "Critical Implementation Changes from Design" in `function_architecture.md`

### 5.6 Success Metrics Verification

| Metric | Status | Evidence |
|--------|--------|----------|
| Single QMD runs end-to-end | ✅ PASS | `render_unified_analysis.R` completes without error |
| No external shell scripts required | ✅ PASS | R-only workflow via `source()` |
| Subfactor code uses reusable functions | ✅ PASS | `analyze_construct()` + 6 helpers |
| Reduces duplicated code | ✅ PASS | Single pipeline vs 6× duplicated blocks |
| Produces all tables and figures | ✅ PASS | 43 CSVs, 6 PNGs, HTML+DOCX |
| Suitable for academic publishing | ✅ PASS | APA-style methods, limitations section |

---

## 6. Security and Privacy

- **Repository Permissions**
  - Only Michael Hickey has direct permission to edit files on the main branch.
  - Claude Code and other agents operate using borrowed credentials and must follow governance rules.
  - All other collaborators must work via branches, forks, or pull requests.

- **Licensing**
  - Licensing is not yet fully defined.
  - A future task is to select and document an appropriate license (e.g., for academic/open use) and ensure it is clearly included in the repository.

- **Threats**
  - Internal threat: a collaborator with write access could inadvertently change or break analysis code or documentation.
  - Current state: repository permissions and protections have not yet been fully locked down.

---

## 7. Performance, Scalability, and Reliability

- **Performance**
  - The notebook should run fast enough to support iterative development and repeated execution.
  - Profiling and optimization will focus on removing redundant computations and consolidating repeated code.

- **Scalability**
  - No immediate need to run at massive scale; dataset is assumed to be modest (academic research scale).

- **Reliability**
  - The unified QMD should:
    - Run from start to finish without manual intervention.
    - Fail with clear, understandable errors if inputs or configuration are missing.
    - Produce consistent results across runs given the same inputs.

---

## 8. Observability

- The project is small enough that full observability tooling (metrics, traces) is not required.
- Recommended practices:
  - Use clear, concise logging or console output within the QMD for key steps (e.g., “Data loaded”, “Retention analysis complete”).
  - Optionally use AI testing agents to:
    - Capture execution logs.
    - Report on failures, runtime, and any warnings.

---

## 9. Deployment and Environments

- **Current Environment**
  - Development and execution within a local environment capable of running Quarto notebooks (and the underlying language/tooling used in the current QMDs).

- **Target Deployment**
  - Deploy the final refined notebook as:
    - A Quarto-based GitHub Pages site.
  - The research team will access this web version to review methodology and results.

- **Future Enhancements**
  - Explore making the published document interactive (e.g., parameterized Quarto, interactive tables/plots) once the underlying code is stable and optimized.

---

## 10. Testing and Validation

- Testing and validation are integral to this branch, not an afterthought.

### 10.1 Testing Approach

- **Continuous execution testing**
  - After major refactors, run the unified QMD from start to finish.
  - Ensure no code chunks fail and that all expected outputs are generated.

- **Code correctness**
  - Compare key outputs (e.g., summary statistics, p-values, tables) against those from the original retention and subfactor QMDs to verify that refactoring did not change results unintentionally.

- **Optimization testing**
  - Validate that optimized loops and shared routines produce the same results as the original, more verbose code.

### 10.2 Validation for Academic Publishing

- Use a validation agent (and manual review) to check:
  - Tables and figures are formatted and labeled appropriately.
  - All key results are reproducible from raw or pre-processed data.
  - The narrative and code are consistent with the documented methodology.

---

## 11. Migration and Rollout Plan

### 11.1 Backup and Archival

1. Create explicit backups of:
   - Original retention QMD.
   - Original subfactor QMD.
2. Store them in a dedicated “archive” location in the repo (read-only in practice).

### 11.2 Unification Steps

1. Create a new branch for the refactor and unification work.
2. Copy content from both QMDs into a new unified QMD.
3. Gradually consolidate and refactor overlapping code sections.

### 11.3 Transition and Deployment

- Once validated:
  - Merge the unified QMD into the main branch.
  - Keep archived originals for reference.
  - Configure the repo for Quarto-based site deployment (e.g., GitHub Pages).
  - Direct the research team to the published site for review.

---

## 12. Risks, Trade-Offs, and Open Questions

### 12.1 Design Trade-Offs

- **Optimization vs. Documentation & Web Packaging**
  - This branch prioritizes:
    - Code optimization.
    - Unification of analyses.
  - Over:
    - Web polish.
    - Documentation enhancements and interactive features.
  - Rationale: correctness and clean, unified analysis are prerequisites for any presentation or deployment work.

### 12.2 Risks and Mitigations

- **Risk: Data or code loss**
  - Mitigation: 
    - Maintain multiple backups of data and QMDs.
    - Explicitly archive original QMDs before refactoring.

- **Risk: Internal accidental modifications**
  - Mitigation:
    - Restrict main-branch write access to Michael Hickey.
    - Enforce branch/PR workflow for all others.

- **Risk: Time and AI usage limits**
  - Mitigation:
    - Time-box work.
    - Prioritize optimization of critical sections.
    - Use agents efficiently with clear prompts and scoped tasks.

### 12.3 Open Questions

- ~~Exact design and responsibilities of AI agents~~ → **RESOLVED:** See Section 4.4 (AI Agent Architecture)
- Final licensing choice and how the license will govern reuse of code and analysis. → **PENDING:** To be addressed in future maintenance work

---

## 13. Maintenance and Future Work

- **Security and licensing**
  - Define and apply an appropriate open-source or research-friendly license.
  - Enforce repository permissions and branch protection rules.

- **Interactive/Published Output**
  - Enhance the Quarto site with interactive features (if useful), such as:
    - Interactive tables.
    - Filterable plots.
    - Parameterized runs.

- **Ongoing upkeep**
  - Periodic review of:
    - Code clarity and performance.
    - Relevance of analyses.
    - Alignment between notebook, paper, and published results.