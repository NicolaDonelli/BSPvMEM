Gamma2Param_hprime_neg <- function(alpha_j, alpha_0, mu_0, nj, Sj, LnPj, mu_j){
  -((alpha_0 - 1)/alpha_j + 
    nj*(1 + log(alpha_j/mu_j) - digamma(alpha_j)) + 
    LnPj - alpha_0/mu_0 - Sj/mu_j)
}

