# Independent free-eta starts on the existing dataset; no restarts or continuation.
# Run from this directory: Rscript --vanilla initializations.R 10000
.libPaths(c('r-library', '../01-understand-RSparsePro/r-library', .libPaths()))
stopifnot(as.character(packageVersion('susieRobust')) == '0.0.0.9002',
          as.character(packageVersion('susieR')) == '0.14.2')
initial <- as.numeric(commandArgs(TRUE)[1])
stopifnot(initial %in% c(10,100,1000,10000))
dir.create('initializations', showWarnings=FALSE)
target <- sprintf('initializations/start_%g.rds', initial)
if (file.exists(target)) stop('Checkpoint already exists; inspect before rerunning')
meta <- jsonlite::fromJSON('data/metadata.json')
con <- file('data/R0.bin','rb')
R0 <- matrix(readBin(con,'double',n=meta$p^2,size=8,endian='little'),meta$p,meta$p,byrow=TRUE)
close(con)
truth <- read.delim('data/truth.tsv')
started <- proc.time()[3]
fit <- susieRobust::susie_iw(v=truth$v,R0=R0,N=meta$N,L=10,
  eta0_init=initial,lambda_min=1e-5,lambda_max=.2,
  scaled_prior_variance=.2,estimate_prior_variance=TRUE,
  max_iter=3000,tol=1e-8,optimizer_starts=3,
  restart_on_nonconvergence=FALSE,ser_fallback=TRUE,partition_ser=FALSE,
  coverage=.95,min_abs_corr=.5,purity_matrix='R0',track_fit=TRUE,verbose=TRUE)
elapsed <- unname(proc.time()[3]-started)
raw <- fit$raw_fit
str(fit$diagnostics,max.level=2)
row <- data.frame(initial_eta0=initial,eta0=fit$eta0,lambda=fit$selected_lambda,
  core_elbo=tail(raw$elbo,1),core_converged=fit$diagnostics$posterior$converged,
  optimizer_converged=fit$diagnostics$optimizer$converged,
  converged=fit$converged,iterations=length(raw$elbo),
  relative_change=fit$diagnostics$posterior$relative_change,
  raw_n_cs=length(fit$raw_sets),raw_cs_sizes=paste(lengths(fit$raw_sets),collapse=', '),
  fallback=fit$postprocess$fallback_used,final_n_cs=length(fit$sets$cs),
  final_cs_sizes=paste(lengths(fit$sets$cs),collapse=', '),elapsed_seconds=elapsed)
trace <- fit$optimization_trace
if (is.null(trace)) trace <- raw$optimization_trace
if (is.null(trace)) stop('Missing optimization trace')
stopifnot(nrow(trace)==length(raw$elbo),all.equal(trace$elbo,raw$elbo)==TRUE)
state <- list(effects=raw$effects,prior_variances=raw$prior_variances,lambda=fit$selected_lambda)
saveRDS(list(row=row,trace=trace,state=state,raw_sets=fit$raw_sets,
  final_sets=fit$sets,diagnostics=fit$diagnostics),target)
write.csv(row,sprintf('initializations/start_%g_summary.csv',initial),row.names=FALSE)
write.csv(trace,sprintf('initializations/start_%g_trace.csv',initial),row.names=FALSE)
print(row)
