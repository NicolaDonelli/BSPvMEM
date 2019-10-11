MEMFullCond <- function(oab, d, alpha, mu, x, VC_hyperparam_oab){
  # Arguments:
  # oab: vector of parameters of the conditional mean specification
  # d: numeric vector of the latent label associated to each observation
  # alpha: vector of shape parameters of the (Gamma) mixture components
  # mu: vector of means of the (Gamma)
  # x: vector of observations
  # VC_hyperparam_oab: matrix representing the covariance matric of the prior 
  #                    Truncated Normal distribution on oab
  # Values:
  # The full conditional density of the parameters oab given the data, alpha and mu.
  
  require(mvtnorm)
  
  n <- length(x)
  
  o <- oab[1]
  a <- oab[2]
  b <- oab[3]
  
  h <- NaN*x
  h[1] <- mean(x) / mean(mu[d], na.rm = T)
  for (t in 2:n){
    h[t] <- o + b*h[t - 1] + a*x[t - 1]
  }
  
  shape_x <- alpha[d]
  scale_x <- h*mu[d]/alpha[d]
  
  sum(ifelse(dgamma(x, shape = shape_x, scale = scale_x) == 0, 
             log(1e-323), 
             log(dgamma(x, shape = shape_x, scale = scale_x))), na.rm = T) + 
    log(dmvnorm(oab, mean = rep(0, length(oab)), sigma = VC_hyperparam_oab) * 
          (min(oab) >= 0))
}  