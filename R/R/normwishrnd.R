normwishrnd <- function(a, W, mu, n0) {
  #' Sample from Normal-Wishart distribution
  #' 
  #' This function generates a random number from Normal-Wishart distribution.
  #'
  #' @param a d.o.f. of the normal-Whishart distribution (a > dim_y - 1)
  #' @param W scale matrix of the normal-Whishart distribution
  #' @param mu mean of the normal-Whishart distribution
  #' @param n0 n0 * Omega is the precision matrix of the normal-Whishart distribution
  #'
  #' @details 
  #' \Omega ~ Wishart(a, W)
  #' \theta | \Omega ~ Normal(\mu, n0 * \Omega)
  #' 
  #' @return list with sampled \Omega, \theta, \Sigma=\Omega^{-1}
  #' @references The Bayesian Choice, Chapter 3, p. 147 and Chapter 4, p. 189
  #' @export

  Omega <- rWishart(n=1, df=a, Sigma=W)[,,1]
  Sigma <- solve(Omega)
  theta <- mvtnorm::rmvnorm(1, mean=mu, sigma=Sigma / n0)
  return(list(Omega=Omega, theta=theta, Sigma=Sigma))
}
