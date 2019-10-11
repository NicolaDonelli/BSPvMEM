.sample_u <- function(xi, d, alpha){
  #' Sample u
  #' 
  #' Sample u_t from the uniform distribution U(0; \xi_{l_{t}})
  #' @param xi auxiliary vector as defined by Kalli et al. (2011)
  #' @param d vector of sampled latent labels
  #' @param alpha Dirichlet Process concentration parameter
  #'
  #' @return list with
  #'     \item u       auxiliary latent variable as defined in Kalli et al. used to truncate the infinite mixture
  #'     \item N       number of active components
  #'     \item n_vec   number of observations per component
  #'     \item n_vec2  number of observations after each component
  
  kappa <- 1/(xi[1]*(alpha+1))
  
  TT <- length(d)
  u <- xi[d] * runif(length(d))
  N <- floor(log(min(u * alpha)) / log((alpha / (kappa * (1 + alpha)))))
  
  return(list(u = u, 
              N = N, 
              n_vec = colSums(matrix(d, TT, N, byrow = FALSE) == matrix(1:N, TT, N, byrow = TRUE)), 
              n_vec2 = colSums(matrix(d, TT, N, byrow = FALSE) > matrix(1:N, TT, N, byrow = TRUE))))
}

.sample_w <- function(u_list, alpha){
  
  #' Sample mixture weights
  #' 
  #' @param u_list output list from .sample_u
  #' @param alpha DP concentration parameter
  #' 
  #' @return w
  
  .compute_w <- function(v, i=1, w=c()){
    # Equivalent to
    # w <- v[1]
    # for (i_w in 2:N){
    #   w <- c(w, v[i_w] * prod(1 - v[1:i_w-1]))
    # }
    
    if (i <= length(v))
      w <- .compute_w(v, i+1 , ifelse(rep(i==1, i), c(w, v[i]), c(w, v[i]  * prod(1 - v[1:i-1]))))
    return(w)
  }
  
  v <- rbeta(u_list$N, 1 + u_list$n_vec, alpha + u_list$n_vec2)
  return(.compute_w(v))
}

.sample_muTauSigma <- function(n_vec, y_log, d, NW_a, NW_W, NW_Winv, NW_mu, NW_n0){
  
  #' Sample mu, Tau and Sigma from Normal-Wishart prior 
  #' 
  #' Sample mean vector and inverse covariance matrix for lognormal multivariate mixture components
  #' 
  #' @param n_vec vector of number of observation for each component
  #' @param y_log log of estimated innovations
  #' @param d vector of labels, that specifies to which component every observation belongs to
  #' @param NW_a d.o.f. of the normal-Whishart prior distribution (a > dim_y - 1)
  #' @param NW_W Scale matrix of the normal-Whishart prior distribution
  #' @param NW_mu mean of the normal-Whishart prior distribution
  #' @param NW_n0 n0 * Omega is the precision matrix of the normal-Whishart prior distribution
  #' @param NW_Winv inverse of the scale matrix of the Wishart distribution
  #' 
  #' @return list of arrays mu, Tau and Sigma, with one page for every dimension
  
  source("R/normwishrnd.R")
  dim_y <- dim(y_log)[2]
  mu <- matrix(NaN, dim_y, length(n_vec))
  Tau <- Sigma <- array (NaN, dim=c(dim_y, dim_y, length(n_vec)))
  
  for (comp in 1:length(n_vec)){
    if (n_vec[comp] == 0){
      NW_a_comp <- NW_a
      NW_W_comp <- NW_W
      NW_mu_comp <- NW_mu
      NW_n0_comp <- NW_n0
    }else{
      # Auxiliary variables
      nj <- n_vec[comp]
      y_comp <- matrix(y_log[d == comp,], nrow = sum(d == comp), ncol = dim_y)
      # futile.logger::flog.debug(paste("dim(y_comp):", (paste(dim(y_comp), collapse = ", "))))
      y_comp_m <- colMeans(y_comp)
      # futile.logger::flog.debug(paste("y_comp_m:", paste(y_comp_m, collapse = ", ")))
      # y_comp_S <- cov(y_comp) * (dim(y_comp)[1] - 1) # This does not work when we have only one observation in given component
      y_comp_S <- t(y_comp - matrix(y_comp_m, nrow=nrow(y_comp), ncol=ncol(y_comp), byrow = T)) %*% 
        (y_comp - matrix(y_comp_m, nrow=nrow(y_comp), ncol=ncol(y_comp), byrow = T))
      # futile.logger::flog.debug(paste(y_comp_S, collapse = ", "))
      # Full Conditional Parameters
      NW_a_comp <- NW_a + nj
      NW_W_comp <- solve(NW_Winv + y_comp_S + (nj * NW_n0) / (nj + NW_n0) * (y_comp_m - NW_mu) %*% t(y_comp_m - NW_mu))
      NW_mu_comp <- (NW_n0 * NW_mu + nj * y_comp_m) / (NW_n0 + nj)
      NW_n0_comp <- NW_n0 + nj
    }
    # Sample from Full Conditional
    NW_list <- normwishrnd(NW_a_comp, NW_W_comp, NW_mu_comp, NW_n0_comp)
    Tau[,,comp] <- NW_list$Omega
    mu[, comp] <- NW_list$theta
    Sigma[,,comp] <- NW_list$Sigma   
  }
  
  return(list(mu=mu, Tau=Tau, Sigma=Sigma))
}

.update_mbar <- function(w, muSigma, eps_mbar, NW_a, NW_W, NW_mu, NW_n0, alpha){
  #' Update mbar
  #' 
  #' Calculate m_bar, necessary for the post-processing transformation
  #' @param w vector of mixture weights
  #' @param muSigma list with parameters of the DPM components. It must have
  #'      \item mu     dim_x * N matrix of means of the component of the DPM
  #'      \item Sigma  dim_x * dim_x * N array in which each page is the VC matrix of a component of the DPM
  #' @param eps_mbar stopping level
  #' @param NW_a d.o.f. of the normal-Whishart prior distribution (a > dim_y - 1)
  #' @param NW_W Scale matrix of the normal-Whishart prior distribution
  #' @param NW_mu mean of the normal-Whishart prior distribution
  #' @param NW_n0 n0 * Omega is the precision matrix of the normal-Whishart prior distribution
  #' @param alpha DP concentration parameter
  #'      
  #' @return mbar vector as described in Donelli et al. (2019)
  
  source("R/normwishrnd.R")
  source("R/diagarray.R")
  
  N <- length(w)
  w_extended <- w
  mu_extended <- muSigma$mu
  Sigma_extended <- diagarray(muSigma$Sigma[,,1:N])
  while (sum(w_extended) < 1-eps_mbar){
    NW_temp <- normwishrnd(NW_a, NW_W, NW_mu, NW_n0)
    v_ex <- rbeta(1, 1, alpha)
    w_extended <- c(w_extended, v_ex * (1 - sum(w_extended)))
    mu_extended <- cbind(mu_extended, t(NW_temp$theta))
    Sigma_extended <- cbind(Sigma_extended, diag(NW_temp$Sigma))
  }
  return(as.vector(exp(mu_extended + 0.5 * Sigma_extended) %*% as.matrix(w_extended)))
}

.sample_d <- function(y, u, w, xi, muSigma){
  #' Sample labels vector
  #' 
  #' Sample the vector of labels from the updated posterior
  #' @param y matrix of estimated innovations
  #' @param u vector of auxiliary variables required to truncate the mixture
  #' @param w vector of mixture weigths
  #' @param xi auxiliary vector as defined by Kalli et al. (2011)
  #' @param muSigma list with parameters of lognormal mixture components. It must have
  #'      \item mu     matrix with a column for each mean vector 
  #'      \item Sigma  array with a page for each covariance matrix
  #'      
  #' @return vector of labels assigning each observation to a given mixture component
  
  N <- length(w)
  TT <- dim(y)[1]
  y_log <- log(y)
  p01 <- (matrix(xi[1:N], N, TT) > matrix(u, N, TT, byrow = TRUE)) * matrix(w, N, TT) / matrix(xi[1:N], N, TT)
  p02 <- matrix(NaN, N, TT)
  for (i in 1:N){
    p02[i,] <- mvtnorm::dmvnorm(y_log, muSigma$mu[, i],  muSigma$Sigma[,,i]) / apply(y, MARGIN=1, FUN=prod)
  }
  p0  <- p01 * p02
  p <- p0 / matrix(colSums(p0), N, TT, byrow = TRUE) # array of probability weights for the possible values of d
  q <- apply(p, MARGIN=2, FUN=cumsum)
  # sampling d_t using the inverse p.d. sampling method (with a discrete p.d.)
  
  return(1 + colSums(matrix(runif(TT), N, TT) > q))
  
}
