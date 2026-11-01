# IW eta0 profile results

Numerical outputs from the local experiment `experiments/16-iw-eta-profile`,
run on 2026-11-01. The workflowr page `analysis/04-IW-eta-profile.Rmd` reads
the saved data and directly refits IW from eta0 starts 10, 100, 1000, 5000,
and 10000. Only the fixed-eta profile uses saved fit results.

- `example.rds`: original R, R0, v, N, N0, one-based causal indices, beta,
  and simulation settings. Exported losslessly from the local binary LD and
  truth table; the saved object was checked against the original in memory.
  The two LD matrices are 1752 by 1752. No new dataset was simulated.

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
- `initialization_summary.csv`, `initialization_trajectories.csv`, and
  `initialization_settings.json`: four new independent native susie_iw fits
  with free eta0 and lambda, initial eta0 in {10,100,1000,10000}, relative
  tolerance 1e-8, maximum 3000 iterations, no restart, and actual SER fallback
  enabled. All four converged. ELBOs and traces describe the IW core before
  fallback. The script is `code/iw-eta-profile/initializations.R`.
  These are archived results from the previous four-start comparison; the
  page now fits all five starts directly instead of reading these tables.

Refinement uses 25 log-spaced eta0 values from 200 to 600, two continuation
directions, and one independent fit at the best grid point; maximum 2000
iterations and relative tolerance 1e-10. All fixed-eta fits disable SER
fallback. The original completed free-eta initialized-at-100 control is retained
in branch_cs_summary.csv; the unfinished original initialized-at-10000 control
is excluded. The new four-start comparison is complete and includes 10000.
The original fit checkpoints remain in the local experiment directory.
The page needs `example.rds` and installed susieRobust 0.0.0.9002 and
susieR 0.14.2 to reproduce the direct fits. The build uses those pinned
libraries through R_LIBS_USER; it does not modify the user's default library.
