LogLikMEM1 <- function(theta, x){
  # Base Symmetric MEM
  # input x is a strictly positive time series
  # theta = (omega, a, b, phi)
  # x_t = h_t * e_t
  # e_t: shape = phi,
  #      scale = 1 / phi
  # h(t) = o + b * h(t-1) + a * x(t-1)
  
  L <- length(x)
  
  o   <- theta[1]
  a   <- theta[2]
  b   <- theta[3]
  phi <- theta[4]
  
  h    <- NaN * 1:L
  h[1] <- mean(x)
  for (t in 2:L){
    h[t] <- o + b * h[t - 1] + a * x[t - 1]
  }
  
  shape_x <- phi
  scale_x <- h/phi
  
  sum(- shape_x * log(scale_x) - lgamma(shape_x) + (shape_x - 1) * log(x) - x/scale_x, na.rm = TRUE)
}