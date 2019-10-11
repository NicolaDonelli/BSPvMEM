Gamma2ParamMode <- function(alpha_init, alpha_0, mu_0, nj, Sj, LnPj, mu_j, dx = 1e-3){
  # Arguments:
  # alpha_init: vector 
  # alpha_0: numeric value indicating the prior shape
  # mu_0: numeric value indicating the prior mean
  # nj: numeric value representing the j-th value of nvec
  # Sj: numeric value representing the sum of the 
  # LnPj: numeric value representing the sum of the logs
  # mu_j: numeric
  # dx = tolerance levels
  funpath <- "/Users/nicoladonelli/Documents/BSP vMEM Research Proposal/Programs/R/functions/"
  source(paste0(funpath,"Gamma2Param_hprime.R"))
  
  x = c(alpha_init / 2, alpha_init * 2)
  y = Gamma2Param_hprime(x, alpha_0, mu_0, nj, Sj, LnPj, mu_j)
  while(prod(y) > 0){
    if (y[2] > 0){
      x[1] <- x[2]
      y[1] <- y[2]
      x[2] <- 2*x[1]
      y[2] <- Gamma2Param_hprime(x[2], alpha_0, mu_0, nj, Sj, LnPj, mu_j)
    }
    if (y[1] < 0){
      x[2] = x[1];
      y[2] = y[1];
      x[1] = x[2] / 2;
      y[1] = Gamma2Param_hprime(x[1], alpha_0, mu_0, nj, Sj, LnPj, mu_j);
    }
  }
  
  
  while ((x[2] - x[1])/mean(x) > dx){
    xm <- mean(x)
    ym <- Gamma2Param_hprime(xm, alpha_0, mu_0, nj, Sj, LnPj, mu_j)
    if (ym >= 0){
      x[1] <- xm
    }else{
      x[2] <- xm
    }
  }
  
  return(xm)
}