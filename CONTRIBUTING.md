# Contributing to US Airline Pilot Retention Analysis

Thank you for your interest in contributing to this research project.

## License Reminder

This repository is licensed under **CC BY-NC 4.0** (Creative Commons Attribution-NonCommercial 4.0). By contributing, you agree that your contributions will be licensed under the same terms. See [LICENSE.md](LICENSE.md) for details.

## Forking and Cloning

### For Academic/Research Use (Non-Commercial)

You are welcome to:
- **Fork** this repository to create your own copy on GitHub
- **Clone** the repository to work locally
- **Adapt** the code and analysis for your own non-commercial research
- **Share** your modifications with proper attribution

**Requirements:**
- Provide attribution to the original authors (see README for citation format)
- Indicate any changes you make
- Keep your use non-commercial

### For Commercial Use

Commercial use requires prior written permission. Contact michael.j.hickey@und.edu to discuss licensing.

---

## Project Governance

- **Primary Maintainer:** Michael J. Hickey (michael.j.hickey@und.edu)
- **Write Access:** Only the primary maintainer has direct write access to the main branch
- **All Changes:** Must be submitted via pull request for review

## Branch Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Feature | `feature/<description>` | `feature/add-power-analysis` |
| Bug fix | `fix/<description>` | `fix/effect-size-calculation` |
| Documentation | `docs/<description>` | `docs/update-methods-section` |
| Analysis | `analysis/<description>` | `analysis/turnover-intention` |

## Pull Request Requirements

1. **Create a descriptive branch** following the naming conventions above
2. **Test your changes** - Ensure `source("render_unified_analysis.R")` completes without error
3. **Verify outputs** - Check that all expected CSV/PNG files are generated
4. **Document changes** - Update relevant documentation if modifying analysis logic
5. **Submit PR** with:
   - Clear title describing the change
   - Summary of what was changed and why
   - Any relevant issue references

## Code Review Expectations

- All PRs require review by the primary maintainer before merging
- Changes to statistical methodology require explicit approval
- Do not merge your own PRs without review

## Code Standards

### R Code

- Use explicit namespace prefixes for `rstatix::` functions (due to `coin` package conflicts)
- Use `.data[[var]]` for dynamic column selection in tidyverse pipelines
- Use `reformulate()` for dynamic formula creation (not `!!sym()`)

### Quarto Documents

- Use chunk labels only once (either `{r label}` or `#| label:`, not both)
- Prefer `#| output: false` over `echo: false` for diagnostic chunks
- Use Quarto callouts (`::: {.callout-warning}`) for warnings/notes

## Questions?

Open an issue or contact the primary maintainer at michael.j.hickey@und.edu.
