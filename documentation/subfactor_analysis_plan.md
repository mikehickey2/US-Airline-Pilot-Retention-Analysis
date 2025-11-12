# Phase 1A: Subfactor Analysis - COMPLETED

**Status:** ✅ Complete
**Date:** November 9, 2025
**Analysis File:** `scripts/analysis/subfactor_analysis.qmd`
**Branch:** `subfactor_analysis`

## Completed Work

### Analysis Implementation
- Created comprehensive Quarto document analyzing all 31 subfactors across 6 retention constructs
- Implemented proper variable labels from survey instrument (readable output)
- Applied non-parametric statistical methods appropriate for ranked data:
  - Mann-Whitney U tests for binary demographic comparisons
  - Kruskal-Wallis tests for experience quartiles
  - Friedman tests for within-construct comparisons
- Applied Bonferroni correction for multiple testing (155 total tests)
- **Statistical enhancements:**
  - Added effect sizes to all demographic comparisons (rank-biserial r for Mann-Whitney, eta-squared for Kruskal-Wallis)
  - Implemented split tryCatch blocks in safe wrappers for graceful degradation when effect size computation fails
  - Formatted Friedman test outputs using kable() for professional table presentation
- **Output generation:**
  - Automated CSV export for all 42 statistical tables (7 tables × 6 constructs)
  - Generated 6 bar chart visualizations of median ranks with reversed ordering (highest priority on top)
  - All outputs saved to appropriate directories with consistent naming conventions

### Technical Infrastructure
- Rebuilt renv environment from 200+ broken packages to 11 clean core packages
- Migrated from R Markdown to Quarto (.qmd) format
- Fixed military demographic recoding using pattern matching
- Created automated render script (`render_subfactor_analysis.R`)
- Implemented safe test wrappers to handle insufficient group sizes

### Key Finding
**No significant demographic differences detected** (p.adj < 0.05) in how pilots ranked subfactor priorities within any retention construct. After conducting 155 statistical tests across all subfactors and demographic groups:
- Age (≤35 vs >35): 0 significant findings
- Gender (Male vs Female): 0 significant findings
- Position (Captain vs First Officer): 0 significant findings
- Military Experience (Military vs Civilian): 0 significant findings
- Experience Quartiles (Q1-Q4): 0 significant findings

**Interpretation:** Pilots demonstrate remarkably consistent preferences for specific retention factors within each construct, regardless of age, gender, position, military background, or years of experience.

### Output Files
- **Reports:**
  - `output/reports/subfactor_analysis.html` - Interactive HTML report with formatted tables and visualizations
  - `output/reports/subfactor_analysis.docx` - Word document for collaboration
  - Both include descriptive statistics, Friedman tests, demographic comparisons with effect sizes, and conclusion
- **CSV Tables (42 files):** `output/tables/subfactor_analysis/`
  - 7 tables per construct (descriptive, Friedman, age, gender, position, military, experience)
  - All demographic tables include effect sizes and magnitude interpretations
- **Figures (6 files):** `output/figures/`
  - Bar charts of median ranks for each construct (highest priority displayed on top)

### Documentation
- Updated README.md with Phase 1A completion
- Updated SUBFACTOR_README.md with accurate usage information
- Created RENV_SETUP.md documenting clean package rebuild
- Archived old experimental files

### Git History Summary
- **Commit 5bcab66** (Nov 9): HOTFIX - Fixed critical Friedman test statistical error (persistent respondent IDs)
- **Commit 49b2888** (Nov 11): Phase 2 - Added effect sizes, CSV/figure outputs, formatting improvements
- **Commit 08fa1ba** (Nov 11): BUGFIX - Fixed effect size computation bugs (coin package dependency, join keys)

## Phase 2: Validation and Bugfixes - COMPLETED

**Date:** November 11, 2025
**Status:** ✅ Complete - Effect sizes verified, statistical methods validated

### Critical Bugs Fixed

**Bug 1: Mann-Whitney Effect Sizes All NA**
- **Root Cause:** `wilcox_effsize()` requires `coin` package which was in renv.lock but not installed (renv::restore() failed due to Matrix compilation issues)
- **Fix:** Manually installed coin package via `renv::install('coin')` and updated join keys
- **Location:** `scripts/analysis/subfactor_analysis.qmd:106, 117-118`
- **Result:** All Mann-Whitney tests now compute rank-biserial r effect sizes correctly

**Bug 2: Kruskal-Wallis Cartesian Join Duplication**
- **Root Cause:** Join only used `.y.` column (always "rank"), not including grouping column `item`, causing cross-product (6 subfactors × 6 effect sizes = 36 rows)
- **Fix:** Updated both safe wrappers to include `item` in select and join operations
- **Location:** `scripts/analysis/subfactor_analysis.qmd:179, 190-191`
- **Result:** Kruskal-Wallis tests now show one row per subfactor with correct eta-squared values

### Validation Results

**Statistical Appropriateness Confirmed:**
- Non-parametric tests appropriate for ordinal rankings with small n=76
- Mann-Whitney U for binary comparisons, Kruskal-Wallis for quartiles - correct choices
- Hierarchical FDR control now applied across all 155 demographic tests (BH construct screening at q=0.10, Holm within selected constructs at α=0.05) to balance Type I/II error in exploratory research
- Zero statistically significant findings even under the more powerful FDR approach, and all effect sizes remain "small"

**Output Verification:**
- ✅ All 42 CSV tables contain proper effect sizes (no NA, no duplication)
- ✅ All 6 PNG figures generated with correct ordering (highest priority on top)
- ✅ HTML and DOCX reports render with formatted tables and visualizations
- ✅ Spot-checked: `financial_age.csv`, `financial_gender.csv`, `qol_gender.csv`, `financial_experience.csv`

### Phase 2b: Type I Error Rework – COMPLETED (Nov 11, 2025)

**Objective:** Replace the overly conservative Bonferroni scheme with a hierarchical false discovery rate (FDR) procedure suitable for exploratory pilot work.

**Implementation:**
- Added construct-level screening immediately after the demographics block. For each construct, we compute the minimum p-value across the five demographic families (age, gender, position, military, experience) and apply Benjamini–Hochberg FDR at q = 0.10 to those six screening p-values.
- For any construct passing the screen, all child demographic tests retain Holm adjustments at α = 0.05 (i.e., FWER control within the construct). All demographic CSVs now include both raw p-values and Holm-adjusted p-values so downstream reviewers can apply alternative thresholds if desired.
- Updated statistical-methods sections, README, and SUBFACTOR_README to document the hierarchical approach, its rationale, and references.

**Screening Outcome (latest run, Nov 11):**
- Only the **Quality of Life** construct cleared the BH screen (min p = 0.0147, p_adj = 0.0588). All other constructs showed no evidence of demographic differences at q = 0.10.
- Within Quality of Life, Holm-adjusted comparisons all exceeded 0.05 and effect sizes remained small, so no follow-up “discoveries” were declared. All tables flag the exploratory nature of comparisons for constructs that did not pass screening.

**Known Data Characteristics:**
- Sample size: n=76 valid responses
- Demographic imbalances:
  - Gender: 8 females vs 67 males (extremely imbalanced)
  - Age: 18 (≤35) vs 58 (>35) (moderately imbalanced)
  - Experience quartiles: as low as 14 per group
- Effect sizes: all "small" magnitude (appropriate for exploratory analysis)

### Critical Dependency Warning

⚠️ **IMPORTANT:** The `coin` package is now required for Mann-Whitney effect size computation. Future users must:
1. Run `renv::restore()` successfully (or manually install coin via `renv::install('coin')`)
2. If coin is not installed, wilcox_effsize() will fail silently and all Mann-Whitney effect sizes will revert to NA
3. This dependency is documented in renv.lock but requires successful package installation

---

## Next Steps: Prioritized Action Plan

**Status:** Planning phase - awaiting user approval before proceeding

### High Priority - Maintainability & Documentation

**0. Research appropriateness of using Bonferroni correction across 155 tests**
- Validate that Bonferroni correction is required and/or good practicefor this analysis
- Locate references that support or refute the selection Bonferroni correction for this data structure, sample size, or other factors of this analysis
- If necessary, adjust analysis and .qmd  to meet findings of this research.

**1. Document coin Package Dependency (30 min)**
- Add prominent warning in README.md about coin requirement
- Update SUBFACTOR_README.md troubleshooting section
- Include instruction: "If effect sizes show NA, run `renv::install('coin')`"
- Document in render script comments

**2. Add Low-Power Warnings for Small Sample Sizes (45 min)**
- Add code comments flagging comparisons with extreme imbalance
- Document in report narrative:
  - Gender: 8 females vs 67 males (Cohen's guidelines suggest n≥15 per group)
  - Age: 18 vs 58 split
- Add caveat text in HTML/DOCX conclusion sections
- Consider adding sample size columns to CSV outputs

**3. Refactor: Create Parameterized Helper Function (2-3 hours)**
- **Problem:** ~600 lines of near-identical code duplicated across 6 constructs
- **Solution:** Single reusable function taking:
  - Variable prefix (financial_, qol_, professional_, etc.)
  - Label vector
  - Number of items per construct
  - Runs all descriptive stats, Friedman tests, demographic comparisons
  - Generates all CSV/PNG outputs
- **Benefits:**
  - Easier maintenance (fix once, applies to all constructs)
  - Consistent logic across all constructs
  - Reduced risk of copy-paste errors
  - Cleaner codebase (~200 lines vs ~800 lines)

### Medium Priority - Robustness

**4. Add Output Verification to Render Script (30 min)**
- After `quarto_render()`, verify expected files exist:
  - Check for 42 CSV files in `output/tables/subfactor_analysis/`
  - Check for 6 PNG files in `output/figures/`
  - Verify HTML and DOCX reports exist
- Print summary: "Generated X/42 CSV tables, X/6 figures"
- Return error if any files missing

**5. Add Error Handling to Render Script (20 min)**
- Wrap `quarto_render()` in tryCatch
- Catch and report failures clearly instead of silent exit
- Log error messages to help debugging
- Return non-zero exit code on failure

**6. Strengthen Safe Wrappers with Minimum Group Size Thresholds (1 hour)**
- **Problem:** Current wrappers only check ≥2 groups, but tests run with n=1 per group (unstable)
- **Solution:** Add minimum count threshold (e.g., n≥5 per group)
- Skip tests when threshold not met
- Report why tests were skipped in output
- Add "skipped_reason" column to CSV tables

### Lower Priority - Polish

**7. Clean Up Console Output in Rendered Reports (1 hour)**
- Replace verbose `cat()` statements with:
  - Conditional logging (only in interactive mode)
  - Quarto callouts for reader-friendly structure
  - Remove "--- Test ---" separators from rendered output
- Keep console output helpful for developers, cleaner for readers

**8. Add Narrative Low-Power Notes in Report (30 min)**
- Add prose section in report explaining:
  - Sample size limitations (n=76)
  - Demographic imbalances and interpretation caveats
  - Why "no significant differences" is still meaningful finding
  - Effect sizes provide practical importance context

### Estimated Total Time
- High Priority (1-3): 3.5-4.5 hours
- Medium Priority (4-6): 2 hours
- Lower Priority (7-8): 1.5 hours
- **Total:** 7-8 hours of development work

### Outstanding Structural Issues
From validation report that remain for future consideration:
- Consider persisting figure references in render script metadata
- Potential future enhancement: interactive visualizations
- Consider adding power analysis section to report
- Explore effect size confidence intervals if sample size permits

---

# Original Analysis Plan

**Comprehensive Survey Instrument & Data Review**

**Survey Data Overview**

**Sample Size:** n = 76 valid responses (from 113 total collected)

•   30 excluded: did not finish survey

•   7 excluded: did not consent or not air carrier pilots

**Survey Structure:** Multi-level ranked preference survey with turnover intention measures

**What Was Already Analyzed (Original Thesis)**

The retention.Rmd analysis examined **ONLY the top-level general retention factors**:

**Variables Analyzed:**

•   general_1 through general_6 - Rankings of the 6 main retention constructs:

1                    **Financial** (salary, benefits, bonuses)

2                    **Quality of Life/Lifestyle** (schedule, family, work-life balance)

3                    **Professional Opportunity** (stability, upgrade, aircraft type)

4                    **Recognition** (uniform, respect, awards)

5                    **Schedule** (fixed vs variable, bidding systems)

6                    **Operational** (SOPs, training, equipment, pilot skill)

**Statistical Tests Applied:**

1  **Friedman Test** - Overall ranking differences across the 6 factors

2  **Mann-Whitney U Tests** - Binary comparisons:

•                     Age groups (≤35 vs \>35)

•                     Gender (Male vs Female)

•                     Military background (Military vs Civilian)

•                     Position (Captain vs First Officer)

3  **Kruskal-Wallis Tests** - Multi-group comparisons:

•                     Experience quartiles

•                     Carrier type groups

**Key Finding:**

The thesis identified which of the 6 broad retention constructs pilots prioritize overall, but **did NOT examine the specific sub-items within each construct**.

**What Was NOT Analyzed - Unexamined Data**

**1. Detailed Sub-Item Rankings (31 variables)**

These represent the **granular priorities within each retention construct** that could reveal actionable insights:

**Financial Sub-Items (6 items, ranked 1-6)**

•   financial_1 - Competitive salary

•   financial_2 - Allowances and soft pay (per diem, productivity pay, etc.)

•   financial_3 - Benefits package

•   financial_4 - Disability insurance

•   financial_5 - Job security

•   financial_6 - New hire/longevity bonuses

**Quality of Life Sub-Items (6 items, ranked 1-6)**

•   qol_1 - Predictable schedule

•   qol_2 - Vacation time

•   qol_3 - Family-friendly policies

•   qol_4 - Possibility of being based at home

•   qol_5 - Travel benefits

•   qol_6 - Work-life balance

**Professional Opportunity Sub-Items (5 items, ranked 1-5)**

•   professional_1 - Financially stable airline

•   professional_2 - Opportunity for rapid upgrade

•   professional_3 - Opportunity to fly larger aircraft

•   professional_4 - Promotion/upgrade based on merit

•   professional_5 - Upgrade based on length of service (seniority)

**Recognition Sub-Items (4 items, ranked 1-5)**

•   recognition_1 - Professional-looking uniforms

•   recognition_3 - Additional vacation time for long service

•   recognition_4 - Recognition as a professional/respected by peers

•   recognition_7 - Airline recognition

**Schedule Sub-Items (5 items, ranked 1-5)**

•   schedule_1 - Fixed schedule

•   schedule_2 - Variable schedule

•   schedule_3 - Flexible work rules

•   schedule_4 - Bid line seniority system

•   schedule_5 - Vacation bidding rules

**Operational Sub-Items (5 items, ranked 1-5)**

•   operational_1 - Unambiguous standard operating procedures (SOPs)

•   operational_2 - Proactive training environment

•   operational_3 - Well-maintained aircraft

•   operational_4 - Well-equipped aircraft

•   operational_5 - Highly skilled fellow pilots

**2. Turnover Intention Data (3 variables)**

Critical unanalyzed data on actual retention risk:

•   **leaving** - "Are you considering leaving your current employer?"

•                     30 Yes (39.5%)

•                     24 Maybe (31.6%)

•                     22 No (28.9%)

•   **when** - "When do you plan to leave?"

•                     9 Within 1 year (11.8%)

•                     24 1-2 years (31.6%)

•                     15 3-4 years (19.7%)

•                     6 Over 4 years (7.9%)

•                     22 NA (not leaving)

•   **why** - Open-ended text responses explaining reasons for leaving

**Comprehensive Analysis Plan for Unexamined Data**

**Phase 1: Sub-Item Ranking Analysis**

**Objective:**

Identify which specific elements within each retention construct pilots value most, providing actionable insights beyond the general construct rankings.

**Analysis Strategy:**

**1A. Within-Construct Sub-Item Analysis (6 separate analyses)**

For each of the 6 retention constructs, perform:

**Descriptive Statistics:**

•   Median rank and IQR for each sub-item

•   Frequency counts for #1 rankings

•   Visualization: Bar charts showing median ranks or % ranked #1

**Statistical Tests:**

•   **Friedman Test**: Test if rankings differ significantly across sub-items within each construct

•   **Post-hoc Pairwise Tests**: If Friedman is significant, use Wilcoxon signed-rank tests with Bonferroni correction to identify which specific sub-items differ

**Example for Financial construct:**

H0: Financial sub-items (salary, benefits, bonuses, etc.) are ranked equally

HA: At least one financial sub-item is ranked differently

**Expected Insights:**

•   Within "Financial," do pilots prioritize base salary over bonuses?

•   Within "QoL," is home-based assignment more important than vacation time?

•   Within "Schedule," do pilots prefer fixed or variable schedules?

•   Within "Professional," is rapid upgrade more valued than flying larger aircraft?

**1B. Demographic Differences in Sub-Item Rankings**

For each sub-item set, test if rankings vary by demographics:

**Age Group Comparisons (≤35 vs \>35):**

•   Mann-Whitney U tests for each sub-item

•   **Research Question:** Do younger vs. older pilots prioritize different specific elements?

•   **Example:** Do younger pilots value rapid upgrade while older pilots value seniority-based systems?

**Gender Comparisons (Male vs Female):**

•   Mann-Whitney U tests for each sub-item

•   **Research Question:** Do female pilots prioritize family-friendly policies differently than males?

**Position Comparisons (Captain vs First Officer):**

•   Mann-Whitney U tests

•   **Research Question:** Do FOs value upgrade opportunities more than Captains?

**Experience Level (Quartiles or Groups):**

•   Kruskal-Wallis tests

•   **Research Question:** How do specific priorities evolve with career progression?

**Military Background:**

•   Mann-Whitney U tests

•   **Research Question:** Do military pilots value SOPs and training differently?

**Multiple Testing Correction:**

•   Use Bonferroni or FDR correction given the large number of tests

•   Report both raw and adjusted p-values

**1C. Cross-Construct Priority Analysis**

**Research Question:** When pilots rank Financial #1 overall, which specific financial sub-items do they prioritize?

**Analysis:**

•   Segment sample by their general_1-6 rankings

•   Within each segment, analyze the sub-item rankings

•   **Example:** Among pilots who ranked "Financial" as their #1 overall factor, what % ranked "salary" as their #1 financial sub-item vs "job security"?

**Statistical Approach:**

•   Conditional descriptive statistics

•   Chi-square tests of independence (if sample size permits)

**Phase 2: Turnover Intention Analysis**

**Objective:**

Understand who is leaving, when, why, and what retention factors differentiate those staying vs. leaving.

**2A. Descriptive Analysis of Turnover Intention**

**Basic Frequencies:**

•   Count and % for leaving (Yes/Maybe/No)

•   Count and % for when (Within 1yr / 1-2yr / 3-4yr / 4+yr)

•   Qualitative coding of "why" responses

**Why Text Analysis:**

•   **Qualitative Coding Approach:**

•                     Read all 54 "why" responses (Yes + Maybe leavers)

•                     Develop coding scheme aligned with the 6 retention constructs

•                     Code each response (can assign multiple codes)

•                     Calculate frequency of each theme

•   **Suggested Codes:**

•                     Financial (pay, benefits)

•                     QoL/Schedule (work-life balance, commuting, bases)

•                     Professional (upgrade, career progression, airline type)

•                     Recognition (respect, culture)

•                     Operational (safety, training, equipment)

•                     Other (personal reasons, location, etc.)

**Expected Output:**

•   Table showing % of leavers citing each retention construct as reason

•   Comparison to quantitative ranking data (do stated reasons align with ranked priorities?)

**2B. Demographic Predictors of Turnover Intention**

**Research Question:** Which demographic groups show higher turnover risk?

**Contingency Table Analyses:**

**Chi-Square Tests:**

•   leaving × age_group

•   leaving × gender

•   leaving × position

•   leaving × experience_level

•   leaving × military_background

•   leaving × carrier_type

**Fisher's Exact Test:** Use if expected cell counts \< 5

**Logistic Regression (if sample permits):**

DV: leaving (binary: Yes/Maybe vs No)

IVs: age, gender, position, experience, military, carrier_type

⚠️ **Sample Size Consideration:** With n=76, multivariable regression may be limited to 3-4 predictors

**Expected Insights:**

•   Are younger pilots more likely to leave?

•   Do First Officers have higher turnover intention than Captains?

•   Does carrier type predict leaving?

**2C. Retention Factor Differences by Turnover Intention**

**Research Question:** Do pilots planning to leave rank retention factors differently than those staying?

**Analysis Strategy:**

**Create Turnover Groups:**

•   Group 1: "Stayers" (leaving = No)

•   Group 2: "Uncertain" (leaving = Maybe)

•   Group 3: "Leavers" (leaving = Yes)

**Kruskal-Wallis Tests:**

•   For each of the 6 general retention factor rankings (general_1-6)

•   For each of the 31 sub-item rankings

•   **H0:** Rankings don't differ by turnover intention

•   **HA:** At least one group ranks this factor differently

**Post-hoc Pairwise Comparisons:**

•   If significant, use Dunn's test with Bonferroni correction

•   Identify which specific comparisons differ (Stayers vs Leavers, etc.)

**Mann-Whitney U Alternative:**

•   Simplify to binary: "Staying" (No) vs "Leaving/Maybe" (Yes+Maybe)

•   Compare rankings between these two groups

**Expected Insights:**

•   Do leavers rank Financial higher and QoL lower than stayers?

•   Do leavers prioritize specific sub-items like "upgrade opportunity" or "home base"?

•   Can we identify retention factors that predict staying?

**2D. Timing of Departure Analysis**

**Research Question:** Does planned departure timing correlate with demographics or retention priorities?

**Among Leavers/Maybe (n=54):**

**Contingency Analyses:**

•   when × demographics

•   Test if younger pilots plan to leave sooner

**Ordinal Regression:**

DV: when (ordinal: within 1yr \< 1-2yr \< 3-4yr \< 4+yr)

IVs: age, position, experience, retention factor rankings

**Kruskal-Wallis Tests:**

•   Do retention factor rankings differ by departure timing?

•   **Example:** Do those leaving within 1 year rank Financial higher than those leaving in 4+ years?

**Phase 3: Integrative & Advanced Analyses**

**3A. Profile Analysis**

**Research Question:** Can we identify distinct pilot profiles based on retention priorities?

**Cluster Analysis:**

•   Use k-means or hierarchical clustering on the 6 general retention rankings

•   Identify 2-4 distinct pilot profiles

•   **Example Profiles:**

•                     "Career Progressors" (high Professional, low Recognition)

•                     "Work-Life Balancers" (high QoL, low Financial)

•                     "Financially Motivated" (high Financial, low Schedule)

**Profile Validation:**

•   Chi-square tests: Do profiles differ by demographics?

•   Do profiles differ in turnover intention?

**3B. Predictive Modeling (if sample permits)**

**Logistic Regression:**

DV: Turnover intention (binary)

IVs: General retention factor rankings + demographics

Goal: Identify strongest predictors of leaving

**Stepwise or LASSO Regression:**

•   Variable selection given limited sample size

•   Report odds ratios with confidence intervals

**3C. Alignment Analysis**

**Research Question:** Is there alignment between what pilots say they value (rankings) and why they're leaving (text responses)?

**Mixed-Methods Approach:**

•   For each leaver, compare:

•                     Their ranked priorities (which factors ranked highest)

•                     Their stated reasons for leaving (coded themes)

•   **Concordance Analysis:** Do stated reasons match ranked priorities?

•   **Example:** If someone ranks Financial #6 (lowest) but states leaving for "better pay," note the discrepancy

**Methodological Considerations**

**1. Statistical Power Concerns**

**Challenge:** n=76 is relatively small for sub-group analyses

**Mitigation Strategies:**

•   Use non-parametric tests (don't assume normality)

•   Apply conservative multiple testing corrections

•   Report effect sizes (not just p-values): r, η², Cliff's delta

•   Acknowledge power limitations in interpretation

•   Focus on practical significance, not just statistical significance

•   Consider combining small demographic groups if theoretically justified

**2. Multiple Testing Problem**

**Issue:** With 31 sub-items × multiple demographic groups, risk of Type I error inflation

**Solutions:**

•   Apply Bonferroni correction: α = 0.05 / number of tests

•   Use False Discovery Rate (FDR) control (Benjamini-Hochberg)

•   Report both raw and adjusted p-values

•   Focus on patterns across multiple tests, not isolated significant findings

**3. Missing Data**

**Recognition Variables:**

•   Only 4 of 7 recognition items present

•   Document this limitation

•   Consider if missing items are systematic

**Turnover "Why" Text:**

•   May have missing or vague responses

•   Code conservatively; use "unclear" category when needed

**4. Qualitative Data Analysis**

**"Why" Text Responses:**

•   **Inter-rater Reliability:** If possible, have 2 coders independently code 20% of responses, calculate Cohen's kappa

•   **Codebook Development:** Create clear operational definitions for each code

•   **Multiple Themes:** Allow responses to be coded into multiple categories

•   **Exemplar Quotes:** Include representative quotes in reporting

**Recommended Analysis Workflow**

**Step 1: Data Preparation**

1  Load cleaned data

2  Verify variable types (numeric for rankings, factor for categorical)

3  Handle any missing values

4  Create derived variables:

•                     Age groups (≤35 vs \>35)

•                     Experience quartiles

•                     Turnover binary (Staying vs Leaving/Maybe)

•                     Carrier type groups

**Step 2: Sub-Item Analysis (Phase 1)**

1  Financial sub-items analysis

2  QoL sub-items analysis

3  Professional sub-items analysis

4  Recognition sub-items analysis

5  Schedule sub-items analysis

6  Operational sub-items analysis

**For each:**

•   Descriptive stats and visualization

•   Friedman test + post-hoc

•   Demographic comparisons (Mann-Whitney / Kruskal-Wallis)

**Step 3: Turnover Analysis (Phase 2)**

1  Descriptive turnover statistics

2  Qualitative coding of "why" responses

3  Demographic predictors (chi-square tests)

4  Retention factor differences by turnover group

5  Departure timing analysis

**Step 4: Integration (Phase 3)**

1  Profile/cluster analysis

2  Predictive modeling (if appropriate)

3  Alignment analysis (rankings vs stated reasons)

**Step 5: Reporting**

1  Create comprehensive tables and figures

2  Write results sections for each analysis

3  Interpret practical significance

4  Acknowledge limitations

5  Provide recommendations

**Expected Outputs & Deliverables**

**Tables (estimated 25-30):**

1  Descriptive statistics for each sub-item set (6 tables)

2  Friedman test results for each construct (6 tables)

3  Demographic comparison tables (12-18 tables)

4  Turnover frequency tables (3-4 tables)

5  Turnover predictor tables (chi-square, regression) (4-5 tables)

6  Qualitative coding summary table (1 table)

**Figures (estimated 15-20):**

1  Bar charts for sub-item median rankings (6 figures)

2  Turnover intention visualizations (3-4 figures)

3  Demographic comparison plots (4-6 figures)

4  Profile/cluster visualizations (2-3 figures)

**Narrative Outputs:**

1  Codebook for "why" responses

2  Results sections for each analysis phase

3  Discussion of key findings

4  Recommendations for airline management

**Research Questions Answered by This Plan**

**Original Thesis:**

Which of the 6 broad retention constructs do pilots prioritize?

**Proposed Extended Analysis:**

**RQ1:** Within each retention construct, which specific elements matter most?

•   Which financial aspects? (salary vs bonuses vs benefits?)

•   Which QoL aspects? (home base vs schedule vs family policies?)

•   Which professional aspects? (upgrade speed vs aircraft type?)

**RQ2:** How do specific retention priorities vary by demographics?

•   Age-related differences in sub-item priorities

•   Gender differences in family-friendly policy importance

•   Position differences in upgrade opportunity value

•   Experience-related priority evolution

**RQ3:** Who is leaving and why?

•   Demographic profile of leavers

•   Stated reasons for leaving (qualitative themes)

•   Timeline of planned departures

**RQ4:** Do retention priorities predict turnover intention?

•   Do leavers rank factors differently than stayers?

•   Which specific priorities increase leaving risk?

•   Is there alignment between ranked priorities and stated leaving reasons?

**RQ5:** Can we identify distinct pilot retention profiles?

•   Are there clusters of pilots with similar priority patterns?

•   Do these profiles differ in demographics and turnover risk?

**Potential Publication Opportunities**

This comprehensive analysis could yield **2-3 journal articles:**

1  **Article 1:** "Granular Retention Priorities: What Specific Factors Drive U.S. Airline Pilot Retention?"

•                     Focus: Phase 1 sub-item analyses

•                     Contribution: Moving beyond broad constructs to actionable specifics

2  **Article 2:** "Predicting Pilot Turnover: The Relationship Between Retention Priorities and Leaving Intentions"

•                     Focus: Phase 2 turnover analyses

•                     Contribution: Linking attitudes to behavioral intentions

3  **Article 3:** "Pilot Retention Profiles: A Person-Centered Approach to Understanding Heterogeneity in U.S. Airline Pilots"

•                     Focus: Phase 3 cluster/profile analysis

•                     Contribution: Identifying pilot segments for targeted retention strategies

**Summary**

**Current State:** The original thesis analyzed only the top-level retention construct rankings (6 variables).

**Unexamined Data:** 31 sub-item rankings + 3 turnover intention variables representing rich, actionable data.

**Proposed Plan:** Comprehensive 3-phase analysis examining:

•   Within-construct priorities

•   Demographic variations in sub-item priorities

•   Turnover intention patterns and predictors

•   Alignment between priorities and leaving intentions

**Value:** This extended analysis would provide **actionable, specific insights** for airline management (e.g., "Young pilots prioritize home-based assignments and rapid upgrade over salary") rather than just broad construct importance.

**Feasibility:** All analyses are appropriate for n=76 with non-parametric methods, though power for some sub-group analyses will be limited.
