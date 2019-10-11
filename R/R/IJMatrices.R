IJMatrices <- function(f, theta, x)
{
  k <- length(theta)
  tol1 <- 1e-2
  tol2 <- 1e-4
  h <- tol1 * pmax(abs(theta), tol2)
  
  N  <- length(f(theta, x))
  
  J <- matrix(0, ncol = k, nrow = k)
  for (i in 1:k){
    for (j in 1:i-1){
      perturb_i    <- rep(0,k) 
      perturb_j    <- rep(0,k)
      perturb_i[i] <- h[i]
      perturb_j[j] <- h[j]
      fipjp <- sum(f(theta + perturb_i + perturb_j, x), na.rm = T)
      fipjm <- sum(f(theta + perturb_i - perturb_j, x), na.rm = T)
      fimjp <- sum(f(theta - perturb_i + perturb_j, x), na.rm = T)
      fimjm <- sum(f(theta - perturb_i - perturb_j, x), na.rm = T)
      J[i, j] <- (fipjp - fipjm - fimjp + fimjm) / (4 * h[i] * h[j])
      J[j, i] <- J[i, j]
    }
  }
  for (i in 1:k){
    perturb_i    <- rep(0,k)
    perturb_i[i] <- h[i]
    fi0 <- sum(f(theta, x), na.rm = T)
    fip <- sum(f(theta + perturb_i, x), na.rm = T)
    fim <- sum(f(theta - perturb_i, x), na.rm = T)
    J[i, i] <- (fip - 2 * fi0 + fim) / (h[i] ^ 2)
  }
  J <- - J / N
  
  s <- matrix(0, nrow = N, ncol = k)
  for (i in 1:k){
    perturb_i    <- rep(0,k)
    perturb_i[i] <- h[i]
    fip <- f(theta + perturb_i, x)
    fim <- f(theta - perturb_i, x)
    s[,i] <- (fip - fim) / (2 * h[i])
  }
  I <- t(s) %*% s / N
  
  return(list(I = I, J = J))
}
