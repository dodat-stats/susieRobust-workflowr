# IW eta0 profile results

Numerical outputs from the local experiment `experiments/16-iw-eta-profile`,
run on 2026-11-01. The workflowr page `analysis/04-IW-eta-profile.Rmd` reads
these results and regenerates the figure without refitting.

- `profile_results.csv`: 63 fixed-eta fits on the 21-point coarse grid.
- `refined_results.csv`: 51 refinement fits; one did not converge.
- `settings.json`: coarse fitting settings and original fitter/data hashes.
- `metadata.json`: simulation parameters, seeds, causal indices (zero-based),
  effects, SNP count, and relative Frobenius distance.
- `branch_cs_summary.csv`: credible sets recovered from the saved lower-peak,
  higher-peak, and free-eta initialized-at-100 posteriors with susieR 0.14.2.
  Uses 95% coverage, exact minimum absolute correlation >= 0.5 in R0, and
  default deduplication. Fallback is a hypothetical trigger (retained CS
  count <= 1); these diagnostics did not apply fallback or refit IW.

Refinement uses 25 log-spaced eta0 values from 200 to 600, two continuation
directions, and one independent fit at the best grid point; maximum 2000
iterations and relative tolerance 1e-10. All fixed-eta fits disable SER
fallback. The completed free-eta initialized-at-100 control is summarized
in the CS table; the unfinished initialized-at-10000 control is excluded.
Large LD matrices and fit checkpoints remain in the local
experiment directory and are not needed to render the page.
