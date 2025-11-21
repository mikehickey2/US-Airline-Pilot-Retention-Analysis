# Original QMD Files Archive

**Archive Date:** November 21, 2025
**Branch:** `subfactor_analysis` (files from before `refactor_combine` work)
**Purpose:** Preserve original analysis files before unification and refactoring
**Status:** ARCHIVE COMPLETE

## Archived Files

| File | Original Location | Description |
|------|-------------------|-------------|
| `retention_original.qmd` | `scripts/analysis/retention.qmd` | General retention factor analysis (1,041 lines) |
| `retention.qmd` | `scripts/analysis/retention.qmd` | Copy of retention analysis |
| `subfactor_analysis_original.qmd` | `scripts/analysis/subfactor_analysis.qmd` | Subfactor analysis within constructs (1,543 lines) |
| `subfactor_analysis.qmd` | `scripts/analysis/subfactor_analysis.qmd` | Copy of subfactor analysis |
| `SUBFACTOR_README.md` | `scripts/analysis/SUBFACTOR_README.md` | Documentation for subfactor analysis |

## Replacement

These files have been replaced by:
- **`scripts/analysis/unified_retention_analysis.qmd`** - Single unified analysis combining both notebooks

## Why Archived

These files were combined into a single unified QMD as part of the `refactor_combine` branch work. The originals are preserved here for:

1. **Reference** - Compare refactored output to original
2. **Rollback** - Restore if issues discovered
3. **Audit trail** - Document the state before changes

## Do Not Modify

These files should remain unchanged. They represent the analysis state as of the `subfactor_analysis` branch completion (commit 0b21eb7).

## Related Documentation

- Design document: `documentation/refactor_combine_design.md`
- Project plan: `documentation/refactor_combine_project_plan.md`
- Function architecture: `documentation/function_architecture.md`
