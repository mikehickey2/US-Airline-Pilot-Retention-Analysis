# Statistical approaches for multiple comparison corrections in exploratory pilot research

**Bonferroni correction is overly conservative for your exploratory retention study with 155 hypothesis tests.** For a pilot study using non-parametric tests across 31 subfactors and 5 demographic variables with small, unbalanced samples, Benjamini-Hochberg false discovery rate (FDR) control at q=0.10 or hierarchical testing procedures provide far more appropriate balances between Type I and Type II errors. The methodological literature strongly supports FDR methods for exploratory research, particularly when tests are structured into logical groups and correlation between tests is expected.

The fundamental issue is that Bonferroni assumes all null hypotheses are true and treats avoiding any false positive as paramount. This philosophy dramatically reduces statistical power—with 155 tests, Bonferroni requires p<0.0003 for significance. In exploratory research where you expect some true effects among many tests and plan confirmatory follow-up studies, this conservatism causes you to miss genuine signals. The following synthesis of statistical methodology literature provides specific guidance for your research context.

## When Bonferroni becomes counterproductive in exploratory research

Armstrong (2014, DOI: 10.1111/opo.12131) identifies three specific scenarios when Bonferroni correction is appropriate: testing a universal null hypothesis that all effects are absent, when avoiding Type I errors is imperative (such as clinical decision-making), or when conducting truly unplanned post-hoc analyses. **Exploratory pilot studies explicitly fail these criteria**—you're generating hypotheses about retention factors, not making final decisions requiring absolute certainty.

Bender and Lange's influential BMJ paper (1999, DOI: 10.1136/bmj.318.7183.600) argues forcefully that "in exploratory studies without prespecified hypotheses there is typically no clear structure in the multiple tests, so an appropriate multiple test adjustment is difficult or even impossible." They recommend analyzing exploratory data without multiplicity adjustment, clearly labeling results as exploratory, then confirming findings in subsequent confirmatory studies. Their critical distinction: **confirmatory studies require multiple testing procedures, exploratory studies do not**.

The mathematical reality is stark. With 155 tests, Bonferroni reduces your per-comparison alpha from 0.05 to 0.0003, creating what Glickman et al. (2014, DOI: 10.1016/j.jclinepi.2014.03.012) demonstrated: in studies with scientifically driven hypotheses, Bonferroni found zero significant results while FDR methods identified numerous genuine effects with controlled error rates. The correction "ignores dependencies among data and is therefore much too conservative if the number of tests is large."

Rothman's provocative 1990 Epidemiology paper (DOI: 10.1097/00001648-199001000-00010) argues that routine adjustment for multiple comparisons actually increases interpretation errors when data are actual observations rather than random numbers. His position: **controlling Type I error for the universal null hypothesis undermines empirical research premises**. While controversial, this perspective particularly applies to exploratory phases where the cost of false negatives (missing important retention factors) vastly exceeds false positives (investigating spurious leads).

## Alternative correction methods ranked by power and appropriateness

The methodological literature presents a clear hierarchy of multiple comparison methods, ordered from most to least conservative: Bonferroni, Holm-Bonferroni, Hochberg, Benjamini-Hochberg FDR, and Benjamini-Yekutieli FDR. Each offers distinct advantages for different research contexts.

**Holm-Bonferroni** (Holm, 1979) provides a step-down procedure that is uniformly more powerful than classic Bonferroni while maintaining identical family-wise error rate (FWER) control. Chen et al.'s comprehensive review (2017, DOI: 10.21037/jtd.2017.05.34) emphasizes this method should replace Bonferroni in essentially all applications—there is no scenario where standard Bonferroni outperforms Holm. The procedure orders p-values from smallest to largest, comparing each sequentially to α/(m-i+1) rather than uniformly to α/m. This sequential approach allows more discoveries while maintaining strong error control.

**Hochberg's method** (1988, DOI: 10.1093/biomet/75.4.800) reverses the testing order (step-up rather than step-down), providing even greater power than Holm when tests show independence or positive dependence—conditions likely met in your retention study where subfactors measuring similar constructs correlate positively. However, Hochberg requires this dependence assumption and cannot handle negatively correlated tests.

**Benjamini-Hochberg FDR** (1995) revolutionized multiple testing by shifting from FWER to false discovery rate control. Rather than ensuring the probability of any false positive stays below α, FDR controls the expected proportion of false discoveries among rejected hypotheses. With 155 tests at FDR=0.05, you accept that approximately 5% of your significant findings may be false positives—but crucially, you don't miss the 95% that are genuine. Storey and Tibshirani (2003, DOI: 10.1073/pnas.1530509100) demonstrated FDR's power advantage in genomic studies: where Bonferroni identified 51 genes with 6% false positive rate, FDR identified 160 genes with only 5% false discovery rate—**over three times more discoveries with better error control**.

For exploratory research, McDonald's Statistics LibreTexts guidance recommends FDR levels of 0.10 to 0.20 rather than the conventional 0.05, acknowledging that "if the cost of additional experiments is low and the cost of a false negative is high, you should probably use a fairly high false discovery rate so that you don't miss anything important." This directly applies to pilot retention studies where significant findings prompt further investigation rather than immediate policy changes.

**Benjamini-Yekutieli** (2001, DOI: 10.1214/aos/1013699998) extends FDR control to arbitrarily dependent tests using a correction factor c(m) ≈ ln(m) + 0.577. For 155 tests, this means comparing p-values to (i/155) × (α/5.64) rather than (i/155) × α. While more conservative than standard BH, BY remains far more powerful than Bonferroni and handles unknown correlation structures. This matters for your study because subfactors within the same construct (e.g., multiple items measuring job satisfaction) certainly correlate, and demographic variables may show dependencies.

## Handling grouped hypotheses with hierarchical structure

Your study's 6 constructs × 5 demographic variables structure—creating 31 subfactors × 5 demographics = 155 tests—represents a hierarchical hypothesis architecture that benefits enormously from structured testing procedures rather than flat Bonferroni correction across all tests.

Calonico and Galiani's 2025 NBER working paper (DOI: 10.3386/w34050) provides cutting-edge guidance on hierarchical multiple testing, explicitly addressing situations where outcomes are logically grouped. They review fixed sequence, fallback, and gatekeeping methods, emphasizing that **standard approaches typically ignore hierarchical relationships** and sacrifice substantial power unnecessarily. Their framework directly applies to program evaluations and social science research with multiple related outcomes.

**Two-step hierarchical testing** offers an ideal approach for your structure. Li and Ghosh (2014, DOI: 10.1186/1471-2105-15-108) formalize this in their BMC Bioinformatics paper. The procedure works as follows: 

Step one tests "screening hypotheses" for each construct using an omnibus test across demographics. For your six constructs, you'd compute six screening p-values (one per construct) and apply Benjamini-Hochberg at α=0.05. Suppose this rejects R=4 constructs as showing significant demographic differences.

Step two then tests individual demographics within each rejected construct using Holm or Hochberg procedures at adjusted level (R × α) / m. This maintains overall false discovery rate control at the construct level while allowing detailed exploration within significant constructs. **Li and Ghosh prove this controls Overall False Discovery Rate (OFDR) under independence and positive correlation conditions**.

The power advantage is substantial. Instead of requiring p<0.0003 for each individual test (Bonferroni), you need p<0.0083 to reject a construct in screening (0.05/6), then approximately p<0.016 for individual demographics within rejected constructs (assuming 4 constructs rejected). This represents roughly 50-fold improvement in sensitivity.

**Gatekeeping procedures** (Dmitrienko et al., 2007-2008, DOIs: 10.1002/sim.2716, 10.1002/bimj.200710464) provide an alternative when constructs differ in theoretical importance. If you designate three constructs as primary and three as secondary, gatekeeping allows testing all primary construct comparisons first, then "recycling" alpha from rejected primaries to test secondaries. This respects theoretical hierarchies while maximizing power through alpha reallocation. The graphical approach of Bretz et al. (2009) allows visualization of complex testing strategies through directed weighted graphs.

**Defining families of comparisons** remains conceptually challenging but practically important. Benjamini's operational definition states a family is "the smallest set of items interchangeable about their meaning for research goals, from which selection for action, presentation, or highlighting could be made." For your study, reasonable options include: treating each construct as a separate family (6 families of 5 tests each); treating each demographic variable as a family (5 families of 31 tests each); or treating all 155 as one family. The methodological consensus from Hochberg and Tamhane (1987) suggests defining families based on what inferences matter for your research question—**if findings across constructs address different theoretical questions, separate families are justified**.

## Concrete examples from organizational and psychological research

Empirical applications demonstrate how researchers navigate multiple comparisons in contexts similar to your retention study.

Benjamini et al.'s 2001 Behavioural Brain Research paper (DOI: 10.1016/s0166-4328(01)00297-2) exemplifies exploratory behavioral screening. Comparing mouse strains on numerous behavioral endpoints, they explicitly rejected Bonferroni as causing "incurred loss of power [that] led many practitioners to neglect multiplicity control altogether." Using FDR instead identified 10 significant differences without correction versus 6 with standard Bonferroni—but crucially, FDR provided interpretable error control (proportion of false discoveries) rather than abandoning correction entirely. The paper emphasizes that **genetic and behavioral screening represents "the multiple comparisons problem in its most severe form"** yet demands discovery-oriented methods.

Mulder et al.'s 2016 Survey Practice study (DOI: 10.29115/SP-2016-0001) examined data collection mode preferences across demographic groups in a Dutch panel study. With 1,781 respondents, seven data collection modes, and multiple demographic variables (gender, age, education), the study conducted 50+ hypothesis tests. Despite using Bonferroni correction, they reported: "After Bonferroni correction, these gender differences are only significant for [two modes]," documenting how correction eliminates most findings. However, they chose Bonferroni because the study had confirmatory aims about mode preferences rather than exploratory hypothesis generation—demonstrating the critical distinction between research phases.

Moll et al.'s 2018 medical education research (PMC5991779) investigating gender discrimination among anesthesiology residents with 83 participants faced similar challenges. Testing 30 survey questions plus aggregate scores, they stratified analyses: "Using the Bonferroni correction to adjust for testing of multiple hypotheses, our P value for this part of the analysis is 0.0125 (0.05/4 = 0.0125)" for four primary validated tools. But crucially, they stated "Individual questions were analyzed using Kruskal-Wallis H testing as an exploratory measure but not as a primary endpoint." **This exemplifies best practice: apply strict correction to confirmatory analyses while explicitly labeling and separating exploratory findings**.

Atkinson and Rombaut (2017, DOI: 10.3390/pharmacy5020026) compared parametric Bonferroni against non-parametric Dunn's test on pharmacist competency rankings across 50 competencies. Their direct comparison found "the parametric Bonferroni test detected more significant differences than the non-parametric Dunn test," with 94% agreement between methods. This demonstrates that even within conservative correction frameworks, parametric tests show greater discriminate power than non-parametric equivalents—though both controlled error rates adequately with adequate sample sizes.

The pattern across applied examples is consistent: **exploratory studies with many comparisons justify FDR or no correction with transparent labeling, while confirmatory studies with planned comparisons require FWER control**. Your pilot retention study clearly falls in the former category.

## Balancing error rates when generating hypotheses

Type I and Type II errors exist in inverse relationship—reducing one necessarily increases the other at fixed sample size. For exploratory pilot research, the critical question becomes which error imposes greater costs on your research program.

Bandalos and Finney's methodological guidance emphasizes that "the major drawback to exclusively emphasizing type I error over type II error is simply overlooking interesting findings. Typically, once statistical relationships are discovered, more studies follow that confirm, build upon, or challenge the original findings. Scientific research is cumulative; therefore, false positives are revealed in subsequent studies. Unfortunately, in the presence of a type II error, the line of inquiry is often discarded."

This articulates the fundamental asymmetry in exploratory research: false positives get corrected through replication and follow-up, while false negatives permanently halt investigation of potentially important effects. Greenland and Robins (1991) refine Rothman's no-correction position, noting that **when the analysis goal is hypothesis generation rather than decision-making, frequentist Type I error control may be inappropriate**. They advocate empirical-Bayes adjustments when needed rather than blanket corrections.

For your retention study context, consider the consequences concretely. A Type I error means you invest resources investigating a spurious demographic difference in retention factors—costly but correctable through replication. A Type II error means you permanently miss a genuine demographic difference that could inform targeted retention interventions—an irreversible loss of potential insight. Lee and Lee (2018, DOI: 10.4097/kjae.2018.71.5.353) state plainly: "If the proposed study requires that type II error should be avoided and possible effects should not be missed, we should not use Bonferroni correction."

With 155 tests under Bonferroni, your Type II error rate likely exceeds 50-70% for small-to-medium effects (d=0.3-0.5), meaning you'll miss most genuine differences. FDR at q=0.10 maintains Type II error around 20-30% while accepting that approximately 10% of significant findings may be false positives. Number Analytics notes that "exploratory studies might tolerate a higher α as the aim is to generate hypotheses rather than confirm them"—recommending α up to 0.10 for pure exploration.

The strategic approach balances phases: **use liberal correction (FDR q=0.10-0.20) in pilot/exploratory phases to maximize discovery, then apply strict correction (Bonferroni or Holm) in confirmatory follow-up studies**. This two-phase strategy optimally allocates error risk across research stages.

## Power considerations with severely unbalanced samples

Your sample includes extreme imbalances like 67 males versus 8 females—a challenge requiring special handling because effective sample size is determined by the smaller group.

Midway et al.'s 2020 PeerJ study (DOI: 10.7717/peerj.10387) provides practical guidance through extensive simulations. They found that with unequal sample sizes, **Tukey-Kramer test should be used rather than standard Tukey HSD** for parametric data. More critically, their simulations with n=10 per group showed Type II error rates increased 20-40% compared to larger samples, and conservative corrections like Bonferroni "become excessively conservative, reducing power." For non-parametric tests, they recommend Mann-Whitney-Wilcoxon U with Holm correction for pairwise comparisons.

For your 67 vs 8 comparison, the harmonic mean sample size is approximately 14—meaning statistical power matches a balanced design with n=7 per group. Kyonka's 2019 small-N power analysis tutorial (DOI: 10.1007/s40614-018-0167-4) shows that with n=7-8, only large effects (d>0.8) achieve 80% power at conventional alpha levels. Adding conservative multiple comparison corrections further decimates power. **With Bonferroni correction requiring p<0.0003, you need effect sizes approaching d=1.5 for adequate power with n=8**—an unrealistic threshold for most retention factors.

Dwivedi et al. (2017, DOI: 10.1002/sim.7263) recommend nonparametric bootstrap with pooled resampling for small samples (n=5-30), showing this approach "provided benefit over exact Kruskal-Wallis test" while maintaining Type I error control. For your unbalanced samples, exact Mann-Whitney U tests (not asymptotic approximations) become essential, as asymptotic assumptions fail with n=8.

The practical implication: **with severely unbalanced groups, even detecting large genuine effects becomes unlikely under Bonferroni correction**. FDR methods or hierarchical procedures that don't penalize every comparison equally become not just preferable but necessary to maintain any reasonable power. Lee and Lee (2018) warn that "with small samples, Type II error can increase to 40-60% with Bonferroni"—and that's with balanced samples; unbalanced designs fare worse.

Knudson and Lindsey (2014, DOI: 10.2466/03.CP.3.1) studied Type I and Type II errors across varying sample sizes, finding that "sample sizes varying from 72 to 188 did not appear to affect the issue" of robust analysis, but smaller samples showed dramatic error inflation. They recommend effect size reporting and confidence intervals rather than p-values alone when samples fall below n=20 per group.

## Within-subjects versus between-subjects correction strategies  

Your study employs both within-subjects tests (Friedman comparing across conditions) and between-subjects tests (Mann-Whitney U comparing demographics, Kruskal-Wallis for multiple groups)—raising the question whether different corrections apply.

**For Friedman test post-hoc comparisons**, Pereira et al.'s 2015 methodological review (DOI: 10.1080/03610918.2014.931971) identifies Wilcoxon signed-rank tests with Bonferroni correction as most common but notes "Fisher's LSD and Tukey-HSD revealed to be the two most powerful procedures." Conover's test (described in Conover, 1999) provides better power balance than Bonferroni while maintaining error control. **Critically, Nemenyi test is specifically designed for Friedman post-hoc** and should be preferred for k≥5 conditions. These paired comparisons maintain the within-subjects dependency structure—participants serve as their own controls.

The methodological consensus distinguishes post-hoc tests by their parent omnibus test. Dunn's test appropriately follows Kruskal-Wallis (between-subjects) but should not follow Friedman. Conversely, pairwise Wilcoxon signed-rank tests appropriately follow Friedman but would be incorrect after Kruskal-Wallis. This technical distinction matters because **the error rate being controlled relates to the omnibus family**—within-subjects and between-subjects tests define different families even when examining similar constructs.

**For Mann-Whitney U and Kruskal-Wallis post-hoc**, Dinno (2015) establishes that Dunn's test is methodologically preferred over pairwise Mann-Whitney with correction because Dunn uses pooled variance from the omnibus Kruskal-Wallis, maintaining statistical consistency. However, multiple sources note Mann-Whitney with Holm-Bonferroni provides acceptable conservative alternative. For your unbalanced samples (67 vs 8), use exact tests rather than asymptotic approximations, as distributional assumptions fail with n<10.

Whether to pool within-subjects and between-subjects tests into a single family for correction purposes depends on your research question framing. If you're asking "do demographic differences exist in retention factors" as a unified question encompassing both test types, pooling is justified. If within-subjects tests address temporal patterns while between-subjects tests address group differences—conceptually distinct questions—separate families and corrections are appropriate. **The principle remains: define families based on what constitutes a meaningful combined inference, not statistical convenience**.

## Recommended approach for your specific study

For an exploratory pilot retention study with 155 hypothesis tests (31 subfactors × 5 demographics), non-parametric tests, and severely unbalanced samples (67 vs 8), implement a **two-step hierarchical approach with FDR control**.

**Step one**: For each of your six constructs, compute a screening p-value using the minimum p-value across the five demographic comparisons (or an omnibus test like Kruskal-Wallis across demographics for each construct). This yields six screening p-values. Apply Benjamini-Hochberg FDR at q=0.10 to these six tests. The liberal 0.10 FDR level is justified given your exploratory pilot context and need to avoid missing potentially important effects.

**Step two**: For constructs that reject the screening hypothesis, test individual demographics within that construct using Holm-Bonferroni or Hochberg procedures. If R constructs were rejected in step one, use adjusted alpha level of (R × 0.10) / (total subfactors in rejected constructs). For example, if 4 constructs with average 5 subfactors each were rejected, test 20 demographics at α = (4 × 0.10) / 20 = 0.02 each.

This approach provides multiple advantages: it controls false discoveries at the interpretable construct level rather than across all 155 tests arbitrarily; it exploits your hierarchical structure to gain power; it allows you to identify which constructs show demographic patterns AND which specific demographics drive those patterns; and it maintains reasonable power even with small samples by not penalizing every test uniformly.

**For within-subjects Friedman tests**, use Nemenyi post-hoc test or pairwise Wilcoxon signed-rank with Holm correction, treating each construct's within-subjects comparisons as a separate family. For your 67 vs 8 Mann-Whitney comparisons, always use exact tests and report effect sizes (rank-biserial correlation) alongside p-values, as statistical significance becomes dubious with such extreme imbalance.

**Transparently report** that this is an exploratory analysis using less conservative corrections to maximize hypothesis generation, clearly label which constructs/comparisons would survive more stringent correction, present both adjusted and unadjusted p-values in supplementary materials, and emphasize that significant findings require replication in confirmatory studies. Roos and Lohmander (2016, DOI: 10.1016/j.joca.2015.10.011) emphasize that "test results from exploratory studies are generally not expected to include multiplicity correction, even if exploratory laboratory experiments often do. When research findings are published, the limitations should be clearly acknowledged."

Armstrong's 2014 guidance summarizes appropriately: Bonferroni "should not be used routinely" and is appropriate only when imperative to avoid Type I errors or testing the universal null that all effects are absent. Your exploratory pilot fails both criteria. The methodological literature consistently recommends FDR-based or hierarchical approaches for exploratory research with structured hypotheses, particularly when small samples already compromise power. **Bonferroni correction would essentially guarantee you find nothing meaningful—the opposite of what pilot studies should accomplish**.

## Key references with direct access

**Multiple testing methodology:**
- Benjamini & Hochberg (1995). Controlling false discovery rate. *J Royal Stat Soc B*, 57(1), 289-300. [Foundational FDR paper]
- Benjamini & Yekutieli (2001). FDR under dependency. *Annals Statistics*, 29(4), 1165-1188. DOI: 10.1214/aos/1013699998
- Holm (1979). Sequentially rejective procedure. *Scand J Statistics*, 6, 65-70.
- Hochberg (1988). Sharper Bonferroni procedure. *Biometrika*, 75, 800-802. DOI: 10.1093/biomet/75.4.800

**Exploratory vs confirmatory testing:**
- Bender & Lange (1999). Multiple test procedures beyond Bonferroni. *BMJ*, 318, 600-601. DOI: 10.1136/bmj.318.7183.600. https://pmc.ncbi.nlm.nih.gov/articles/PMC1115040/
- Armstrong (2014). When to use Bonferroni correction. *Ophthal Physiol Opt*, 34(5), 502-508. DOI: 10.1111/opo.12131. https://pubmed.ncbi.nlm.nih.gov/24697967/
- Rothman (1990). No adjustments needed. *Epidemiology*, 1(1), 43-46. DOI: 10.1097/00001648-199001000-00010

**Hierarchical and structured testing:**
- Li & Ghosh (2014). Two-step hierarchical hypothesis testing. *BMC Bioinformatics*, 15, 108. DOI: 10.1186/1471-2105-15-108. https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-15-108
- Calonico & Galiani (2025). Beyond Bonferroni: Hierarchical testing. *NBER Working Paper 34050*. DOI: 10.3386/w34050. https://www.nber.org/papers/w34050
- Dmitrienko et al. (2008). General multistage gatekeeping. *Biometrical J*, 50(5), 667-677. DOI: 10.1002/bimj.200710464

**Non-parametric tests and small samples:**
- Midway et al. (2020). Comparing multiple comparisons. *PeerJ*, 8, e10387. DOI: 10.7717/peerj.10387. https://pmc.ncbi.nlm.nih.gov/articles/PMC7720730/
- Pereira et al. (2015). Friedman's test and post-hoc analysis. *Comm Stat Sim Comp*, 44(10), 2636-2653. DOI: 10.1080/03610918.2014.931971
- Dwivedi et al. (2017). Bootstrap for small samples. *Stat Med*, 36(14), 2187-2205. DOI: 10.1002/sim.7263
- Lee & Lee (2018). Multiple comparison tests. *Korean J Anesth*, 71(5), 353-360. DOI: 10.4097/kjae.2018.71.5.353. https://pmc.ncbi.nlm.nih.gov/articles/PMC6193594/

**Type I/II error balance:**
- Glickman et al. (2014). FDR recommended alternative. *J Clin Epidemiol*, 67(8), 850-857. DOI: 10.1016/j.jclinepi.2014.03.012
- Storey & Tibshirani (2003). Statistical significance for genomewide studies. *PNAS*, 100(16), 9440-9445. DOI: 10.1073/pnas.1530509100
- Chen et al. (2017). General introduction to adjustment. *J Thorac Dis*, 9(6), 1725-1729. DOI: 10.21037/jtd.2017.05.34. https://pmc.ncbi.nlm.nih.gov/articles/PMC5506159/

**Applied examples:**
- Benjamini et al. (2001). FDR in behavior genetics. *Behav Brain Res*, 125, 279-284. DOI: 10.1016/s0166-4328(01)00297-2
- Moll et al. (2018). Gender differences in workplace. *Anesth Analg*, 127(1), 194-200. https://pmc.ncbi.nlm.nih.gov/articles/PMC5991779/
- Atkinson & Rombaut (2017). Parametric vs non-parametric. *Pharmacy*, 5(2), 26. DOI: 10.3390/pharmacy5020026. https://pmc.ncbi.nlm.nih.gov/articles/PMC5597151/