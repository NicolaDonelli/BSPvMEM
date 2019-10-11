Gamma2Param_h <- function(alpha_j, alpha_0, mu_0, nj, Sj, LnPj, mu_j)
{
  (alpha_0 - 1 + nj*alpha_j)*log(alpha_j) - 
    nj*alpha_j*log(mu_j) - 
    nj*lgamma(alpha_j) + 
    (alpha_j - 1)*LnPj - 
    (alpha_0/mu_0 + Sj/mu_j)*alpha_j
}