GradientFullCond <- function(oab, d, alpha, mu, x, VC_hyperparam_oab)
{
  LnPostCurr <- MEMFullCond(oab, d, alpha, mu, x, VC_hyperparam_oab)
  h <- MEM_h(oab, x, mu, d)
  
  n <- length(x)
  o <- oab[1]
  a <- oab[2]
  b <- oab[3]
  
  dhdo <- (1 - b^(0:(n-1))) / (1 - b)
  dhdo[1] <- 0
  
  dhda <- matrix(0, n, 1)
  for (t in 1:(n-1)){
    dhda[t + 1] <- x[t] + b * dhda[t]
  }
  
  dhdb = matrix(0, n, 1)
  for (t in 1:(n-1)){
    dhdb[t + 1] <- h[t] + b * dhdb[t]
  }
  
  go <- - o / VC_hyperparam_oab[1, 1] -
    sum(alpha[d] / h * dhdo) +
    sum(alpha[d] * x * dhdo / mu[d] / (h^2))
  
  ga <- - a / VC_hyperparam_oab[2, 2]   -
    sum(alpha[d] / h * dhda) +
    sum(alpha[d] * x * dhda / mu[d] / (h ^ 2))
  
  gb <- - b / VC_hyperparam_oab[3, 3] -
    sum(alpha[d] / h * dhdb) +
    sum(alpha[d] * x * dhdb / mu[d] / (h ^ 2))
  
  return(c(go,ga,gb))
}