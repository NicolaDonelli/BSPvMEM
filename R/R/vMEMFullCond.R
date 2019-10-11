vMEMFullCond <- function (eta,d,muSigma,x,Mean_prior,VC_prior,h_1,Pos,model){
  
  #' Compute the full conditional of the parmaters
  #' 
  #' Computes the value of the full conditional of the vector, eta, containing the 
  #' parameters of the conditional mean
  #' 
  #' @param eta is a vector that contains in this order (if present)
  #'      \item omega (dim_x*1 vector)
  #'      \item B (dim_x*dim_x matrix)
  #'      \item A (dim_x*dim_x matrix)
  #'      \item Aneg (dim_x*dim_x matrix)
  #'      \item F (dim_x*dim_x matrix)
  #'      \item K (dim_x*(l-1) matrix)
  #'      \item G (dim_x*dim_x*(l-1) array)
  #'      \item Gneg (dim_x*dim_x*(l-1) array)
  #'      (MATRICES AND ARRAYS ARE VECTORIZED BY COLUMN)
  #' @param d dim_x * TT vector of latent labels
  #' @param muSigma list with parameters of the DPM components. It must have
  #'      \item mu     dim_x * N matrix of means of the component of the DPM
  #'      \item Sigma  dim_x * dim_x * N array in which each page is the VC matrix of a component of the DPM
  #' @param x dim_x * TT data vector
  #' @param Mean_prior prior vector mean of the eta vector
  #' @param VC_prior prior VC matrix of the eta vector
  #' @param h_1 dim_x * 1 vector of initial values of h
  #' @param Pos Logical flag that indicates wheter or not the eta vector 
  #'            has to be constrained on the positive orthant
  #' @param model list the specification of the conditional mean
  #' 
  #' @return list with
  #'       \item LogPost:      value of the full conditional in the given eta value.
  #'       \item h:            dim_x * TT matrix of conditional means
  
  source("R/vMEMh.R")
  
  h <- vMEMh(x=x, eta=eta, h_1=h_1, model=model)
  
  if ((!Pos & (min(min(h)) > 0 & max(max(h)) < Inf)) | (Pos & min(eta) > 0)){
    CenterData <- log(x) - log(h) - t(muSigma$mu[,d])
    uniq_d <- unique(d)
    SumKerLogLik <- rep(0,length(uniq_d))
    for (j in 1:length(uniq_d)){
      SumKerLogLik[j] <- sum((CenterData[d==uniq_d[j],] %*% solve(chol(muSigma$Sigma[,,uniq_d[j]])))^2)
    }
    LogPost <- -0.5 * (sum(SumKerLogLik, na.rm = TRUE) + t(eta - Mean_prior) %*% solve(VC_prior) %*% as.matrix(eta - Mean_prior))
  }else{
    LogPost <- -Inf
  }
  return(list(LogPost=LogPost, h=h))
}
