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