LogLikMEM1_vec <- function(theta, x)
{
  # Base Symmetric MEM
  # input x is Realized Volatility (sqrt of realized variance)
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
  
  h    <- rep(0,L)
  h[1] <- mean(x)
  for (t in 2:L)
    h[t] <- o + b * h[t - 1] + a * x[t - 1]
  
  
  shape_x <- phi
  scale_x <- h / phi
  
  -shape_x*log(scale_x) - lgamma(shape_x) + (shape_x-1)*log(x) - x/scale_x
}