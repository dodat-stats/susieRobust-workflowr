# IW eta0 profile results

Numerical outputs from the local experiment `experiments/16-iw-eta-profile`,
run on 2026-11-01. The workflowr page `analysis/04-IW-eta-profile.Rmd` reads
these results and regenerates the figure without refitting.

- `profile_results.csv`: 63 fixed-eta fits on the 21-point coarse grid.
- `refined_results.csv`: 51 refinement fits; one did not converge.
- `settings.json`: coarse fitting settings and original fitter/data hashes.
- `metadata.json`: simulation parameters, seeds, causal indices (zero-based),
  effects, SNP count, and relative Frobenius distance.

Refinement uses 25 log-spaced eta0 values from 200 to 600, two continuation
directions, and one independent fit at the best grid point; maximum 2000
iterations and relative tolerance 1e-10. All fixed-eta fits disable SER
fallback. The slower supplementary free-eta controls are not included in
this report. Large LD matrices and fit checkpoints remain in the local
experiment directory and are not needed to render the page.
