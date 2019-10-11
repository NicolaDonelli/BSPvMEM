MEM_h <- function(oab, x, mu, d){
  # Arguments:
  # oab: vector of parameters of the conditional mean specification
  # x: vector of observations
  # mu: vector of means of the mixture components
  # d: vector of latent labels assigning every observation in x to a mixture component
  # 
  # Values:
  # the function returns the vector of conditional means (at every time), obtained 
  # from the MEM specification with the given parameters.

  n <- length(x)
  o <- oab[1]
  a <- oab[2]
  b <- oab[3]
  
  h <- NaN*x
  h[1] <- mean(x)/mean(mu[d], na.rm = T)
  for (t in 2:n){
    h[t] <- o + a*x[t - 1] + b*h[t - 1]
  }
  return(h)
}