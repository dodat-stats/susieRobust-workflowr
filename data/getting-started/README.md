# Getting-started LD matrices

`ld.rds` stores the simulation used by `analysis/01-get-started.Rmd` as an R list:

- `R`: in-sample LD correlation matrix.
- `R0`: reference LD correlation matrix, in the same SNP order.
- `position`: SNP positions in base pairs.
- `settings`: simulation parameters.
- `versions`: software versions used to generate this saved simulation.

The simulation uses 200,000 study individuals, 5,000 reference individuals,
a split 200 generations ago, a 700,000 bp locus, seed 1, recombination rate
1e-8, and mutation rate 2.36e-8. Both populations follow the EUR growth
history from stdpopsim's OutOfAfrica_2T12 model, with migration removed and
a shared-growth reference branch. Ancestry uses DTWF for 100 generations,
then Hudson. All single-mutation sites with study MAF at least 1% and
polymorphism in both cohorts are retained, without SNP thinning.

The commented simulation in section 1.1 reproduces the matrices. Run the
loading code from the workflowr project root (the usual workflowr setup).

Demographic sources: Tennessen et al. (2012), doi:10.1126/science.1219240;
Fu et al. (2013), Fig. S5, doi:10.1038/nature11690.
