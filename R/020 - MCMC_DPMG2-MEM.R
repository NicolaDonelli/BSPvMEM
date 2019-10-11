library(chron)
library(ggplot2)
library(zoo)
library(dplyr)
library(mvtnorm)
library(coda)
library(pracma)
library(ggplot2)

source("R/Gamma2ParamMode.R")
source("R/Gamma2Param_hprime.R")
source("R/Gamma2Param_h.R")
source("R/MEMFullCond.R")
source("R/MEM_h.R")
source("R/GradientFullCond.R")

#### Import data ####
# Simulations
# load("~/Documents/BSP vMEM Research Proposal/Programs/R/SimulatedSampleAndMLE.RData")
# Heny-Hub daily square-root prices
# load("~/Documents/BSP vMEM Research Proposal/Programs/R/HHSqrtPrices_v2.RData")
# Heny-Hub daily log prices
load("~/Documents/Personale/BSPvMEM/BSPvMEM/data/rdata/HHLogPrices_v1.RData")

#### MCMC ####
# The considered model is a Mulitplicative Error Model with innovations that are 
# Dirichlet Process Mixtures of Gammas with two free parameters (DPMG2 MEM)
# 
# Considering a strictly positive time series x,
# 
# x_t = h_t * e_t
# e_t ~ DPM( DP concetration = M, 
#            mixture components = Gamma(shape, scale)) 
# h(t) = o + b * h(t-1) + a * x(t-1)

MC <- NULL
NBurnIn <- 1e3
NMCMC0  <- 1e3
NMCMC1  <- 1e4
NPlot <- 1e2
NPlotWindow <- 4e3
NAdapt <- 1e2
pb <- tcltk::tkProgressBar(max = NBurnIn + NMCMC0 + NMCMC1)

ALL_PROB_alpha <- matrix(NaN, nrow = NBurnIn + NMCMC0 + NMCMC1, ncol = 30)
ALL_PROB_oab <- c()

Scale <- 1
Proposal_Sigma <- MLE$VC_MLE1[1:3,1:3]
eps2 <- 1e-6

# Adaptation of the Scale parameter
MALA_Scale <- 0.4
eps_Scale <- 1e-7
A_Scale <- 1e7
tau <- 0.4

# Initialization of the innovations
y <- MLE$e_MLE

n <- length(x)

# Prior of (o, a, b) (MEM Parameters): 
# Truncated Normal
VC_hyperparam_oab <- matrix(100*c(1,0,0, 0,1,0, 0,0,1), nrow = 3, ncol = 3);

# Hyperparameters of alpha (vector of shape parameters of the gamma mixture components): 
# Gamma (shape = alpha_0, scale =  mu_0 / alpha_0) [i.e. mean = mu_0]
alpha_lambda <- 3

m_0 <- 10
s_0 <- 10
v_0 <- s_0^2
beta_0  <- m_0 / v_0
alpha_0 <- m_0 * beta_0
mu_0 <- m_0

# Hyperparameters of mu (vector of mean parameters of the gamma mixture components): 
# Inverse-Gamma(shape, scale)
m_mu <- mean(y)
s_mu <- 5*mean(y)
gamma <- m_mu^2/s_mu^2 + 2
delta <- m_mu*(m_mu^2/s_mu^2 + 1)

# Hyperparameters of M (DP's concent. param.)
kappa <- 1.5
M <- 1
xi <- (M / (kappa * (1 + M))) ^ (0:(1e3-1)) / M
prior_M_shape <- 2
prior_M_rate  <- 1/2

# Initialization of d
N0_Components <- 5
d <- floor(N0_Components * runif(n)) + 1

# Initialization of (o, a, b) and the matrices in which MCMC results will be stored
# oab <- c(MLE$o_MEM_MLE, MLE$a_MEM_MLE, MLE$b_MEM_MLE)
oab <- c(0.1, 0.8, 0.1)
oab_matrix <- matrix(NaN, nrow = NBurnIn + NMCMC0 + NMCMC1, ncol = 3)
oab_Mapped_MATRIX <- matrix(NaN, nrow = NBurnIn + NMCMC0 + NMCMC1, ncol = 3)

# 1) Sampling u: d
u <- xi[d] * runif(n)
# MC[[1]]$u <- u
# M0 <- 1
N <- floor(log(min(u * M)) / log((M / (kappa * (1 + M)))))
# N <- floor(log(min(u * M0)) / log((M0 / (kappa * (1 + M0)))))
MC[[1]]$N <- N
# vector of nj values
n_vec <- colSums(matrix(rep(d,N), nrow = n) == matrix(rep(1:N, n), nrow = n, byrow = TRUE))
n_vec2 <- colSums(matrix(rep(d,N), nrow = n) > matrix(rep(1:N, n), nrow = n, byrow = TRUE))

# Initialize mu and alpha
mu <- 1 / rgamma(N, shape = gamma,  scale = 1 / delta)
alpha <- rgamma(N, shape = alpha_0, scale = mu_0 / alpha_0)

# 2) Sampling v: d (through n_vec and n_vec2)
v <- rbeta(N, 1 + n_vec, M + n_vec2)
# MC[[1]]$v = v
w <- matrix(0,N,1)
w[1] <- v[1]
for (i_w in 2:N){
  w[i_w] = v[i_w] * prod(1 - v[1:(i_w-1)])
}
MC[[1]]$w <- w

# 3) Sampling alpha (scale parameters): d (through nj, Sj, LnPj) and mu

Sj_vec <- matrix(0,N, 1)
for (j_alpha in 1:N){
  if (n_vec[j_alpha] == 0){
    alpha[j_alpha] <- rgamma(1, shape = alpha_0, scale = mu_0 / alpha_0)
  }else{
    nj <- n_vec[j_alpha]
    Sj <- sum(y[d == j_alpha])
    Sj_vec[j_alpha] <- Sj
    LnPj <- sum(log(y[d == j_alpha]))

    # Proposal is a Gamma PDF
    xm <- Gamma2ParamMode(alpha_init = 1, alpha_0, mu_0, nj, Sj, LnPj, mu_j = mu[j_alpha])
    xs1 <- xm / alpha_lambda
    xs2 <- xm * alpha_lambda
    hprime_s1 <- Gamma2Param_hprime(xs1, alpha_0, mu_0, nj, Sj, LnPj, mu[j_alpha])
    hprime_s2 <- Gamma2Param_hprime(xs2, alpha_0, mu_0, nj, Sj, LnPj, mu[j_alpha])
    q_shape <- (hprime_s1/(1/xs1 - 1/xm) + hprime_s2/(1/xs2 - 1/xm))/2 + 1
    q_scale <- xm/(q_shape - 1)

    # MH sampler's Proposal
    alpha_prop <- rgamma(1, shape = q_shape, scale = q_scale)

    # Probability of Acceptance
    h_prop <- Gamma2Param_h(alpha_prop, alpha_0, mu_0, nj, Sj, LnPj, mu[j_alpha])
    h_curr <- Gamma2Param_h(alpha[j_alpha], alpha_0, mu_0, nj, Sj, LnPj, mu[j_alpha])
    LnKq_curr_to_prop <- log(dgamma(alpha_prop, shape = q_shape, scale = q_scale))
    LnKq_prop_to_curr <- log(dgamma(alpha[j_alpha], shape = q_shape, scale = q_scale))
    prob_acc_alpha <- min(1, exp(h_prop - h_curr + LnKq_prop_to_curr - LnKq_curr_to_prop))
    ALL_PROB_alpha[1,j_alpha] <- prob_acc_alpha
    if (runif(1) < prob_acc_alpha){
      alpha[j_alpha] <- alpha_prop
    }
  }
}
MC[[1]]$alpha <- alpha


h <- MEM_h(oab, x, mu, d)
y <- x / h

Sj_vec <- matrix(0,N, 1)
for (j_alpha in 1:N){
  if (n_vec[j_alpha] > 0)
    Sj_vec[j_alpha] <- sum(y[d == j_alpha])
}

# 4) Sampling mu
mu <- 1 / rgamma(N, shape = gamma + n_vec*alpha, scale = 1/(delta+alpha*Sj_vec))
MC[[1]]$mu <- mu
h <- MEM_h(oab, x, mu, d)
y <- x / h

# 5) Sampling d : u, v(w), alpha, mu
p01 <- (matrix(rep(xi[1:N],n), nrow = N) > matrix(rep(u,N),nrow = N, byrow = TRUE)) *
  matrix(rep(w,n),nrow = N)/matrix(rep(xi[1:N],n),nrow = N)
p02 <- dgamma(matlab::reshape(matrix(rep(y, N), nrow = N, byrow = TRUE), N*n,1), 
              shape = matlab::reshape(matrix(rep(alpha, n), nrow = N), N*n,1),
              scale = matlab::reshape(matrix(rep(mu, n), nrow = N), N*n,1) / 
                      matlab::reshape(matrix(rep(alpha, n), nrow = N), N*n,1))
p0 <- p01 * matlab::reshape(p02, N, n)
p <- p0 / matrix(rep(colSums(p0),N), nrow = N, byrow = TRUE)
q <- apply(p, MARGIN = 2, FUN = cumsum)

d <- 1 + colSums(rep(runif(n), ncol = N, byrow = TRUE) > q)
h <- MEM_h(oab, x, mu, d)
y <- x / h
MC[[1]]$d <- d

# Mean of the innovations' distribution
omega <- t(w) %*% mu / sum(w)
MC[[1]]$omega <- omega

# 6) Sampling Dirichlet Process Precision Parameter
k_Active_Comp <- length(unique(d))
Eta_M <- rbeta(1, M + 1, n)
pi_Eta_M <- 1 / (1 + n * (prior_M_rate - log(Eta_M)) / (prior_M_shape + k_Active_Comp - 1))
u_Mixture_M <- runif(1)
if (u_Mixture_M < pi_Eta_M){
  M <- rgamma(1, shape = prior_M_shape + k_Active_Comp, scale = 1/(prior_M_rate - log(Eta_M)))
}else{
  M <- rgamma(1, shape = prior_M_shape + k_Active_Comp - 1, scale = 1/(prior_M_rate - log(Eta_M)));
}
MC[[1]]$M <- M
xi <- (M / (kappa * (1 + M))) ^ (0:(1e3-1)) / M
MC[[1]]$xi <- xi

# 7) Sampling oab = (o, a, b)
oab_prop <- exp(rmvnorm(1, mean = log(oab), sigma = MLE$VC_MLE1[1:3, 1:3]))
LnPostCurr <- MEMFullCond(oab, d, alpha, mu, x, VC_hyperparam_oab)
h <- MEM_h(oab, x, mu, d)
LnPostProp <- MEMFullCond(oab_prop, d, alpha, mu, x, VC_hyperparam_oab)
h_prop <- MEM_h(oab_prop, x, mu, d)
LnQPropCurr <- log(dmvnorm(log(oab), mean = log(oab_prop), sigma = MLE$VC_MLE1[1:3, 1:3]) / prod(oab))
LnQCurrProp <- log(dmvnorm(log(oab_prop), mean = log(oab), sigma = MLE$VC_MLE1[1:3, 1:3]) / prod(oab_prop))
prob_acc <- min(1, exp(LnPostProp - LnPostCurr + LnQPropCurr - LnQCurrProp))

# prob_acc = min(1, exp(LnPostProp - LnPostCurr))
ALL_PROB_oab = c(ALL_PROB_oab, prob_acc)
if(runif(1) < prob_acc){
  oab <- oab_prop
  h <- h_prop
  LnPostCurr <- LnPostProp
}
MC[[1]]$oab <- oab
oab_matrix[1,] <- oab

y <- x / h
MC[[1]]$y <- y
MC[[1]]$h <- h
MC[[1]]$mu_mapped <- MC[[1]]$mu / MC[[1]]$omega
MC[[1]]$y_mapped <- MC[[1]]$y / MC[[1]]$omega

oab_Mapped <- oab * c(omega,omega,1)
oab_Mapped_MATRIX[1, ] <- oab_Mapped
oab_MEAN <- oab_Mapped


Stm1 <- NaN
u_MH_OAB <- runif(NBurnIn + NMCMC0 + NMCMC1)
system.time(
for (t in 2:(NBurnIn + NMCMC0 + NMCMC1)){
  # 1) Sampling u
  u <- xi[d] * runif(n)
  # MC[[t]]$u <- u
  N <- floor(log(min(u * M)) / log((M / (kappa * (1 + M)))))
  # N <- floor(log(min(u * M0)) / log((M0 / (kappa * (1 + M0)))))
  MC <- append(MC, list(list(N = N)))
  # vector of nj values
  n_vec <- colSums(matrix(rep(d,N), ncol = N) == matrix(rep(1:N, n), ncol = N, byrow = TRUE))
  n_vec2 <- colSums(matrix(rep(d,N), ncol = N) > matrix(rep(1:N, n), ncol = N, byrow = TRUE))
  
  # 2) Sampling v
  v <- rbeta(N, 1 + n_vec, M + n_vec2)
  # MC[[t]]$v = v
  w <- matrix(0,N,1)
  w[1] <- v[1]
  for (i_w in 2:N){
    w[i_w] = v[i_w] * prod(1 - v[1:(i_w-1)])
  }
  MC[[t]]$w <- w
  
  # 3) Sampling alpha
  if (MC[[t]]$N > MC[[t-1]]$N){
    mu[(MC[[t-1]]$N+1):MC[[t]]$N] <-
      1 / rgamma(MC[[t]]$N - MC[[t-1]]$N, shape = gamma, scale = 1/delta)
    alpha[(MC[[t-1]]$N + 1):MC[[t]]$N] <- 
      rgamma(MC[[t]]$N - MC[[t-1]]$N, shape = alpha_0, scale = mu_0/alpha_0)
  }
  Sj_vec <- matrix(0,N, 1)
  for (j_alpha in 1:N){
    if (n_vec[j_alpha] == 0){
      alpha[j_alpha] <- rgamma(1, shape = alpha_0, scale = mu_0 / alpha_0)
    }else{
      nj <- n_vec[j_alpha]
      Sj <- sum(y[d == j_alpha])
      Sj_vec[j_alpha] <- Sj
      LnPj <- sum(log(y[d == j_alpha]))

      # Proposal is a Gamma PDF
      xm <- Gamma2ParamMode(alpha_init = 1, alpha_0, mu_0, nj, Sj, LnPj, mu_j = mu[j_alpha])
      xs1 <- xm / alpha_lambda
      xs2 <- xm * alpha_lambda
      hprime_s1 <- Gamma2Param_hprime(xs1, alpha_0, mu_0, nj, Sj, LnPj, mu[j_alpha])
      hprime_s2 <- Gamma2Param_hprime(xs2, alpha_0, mu_0, nj, Sj, LnPj, mu[j_alpha])
      q_shape <- (hprime_s1/(1/xs1 - 1/xm) + hprime_s2/(1/xs2 - 1/xm))/2 + 1
      q_scale <- xm/(q_shape - 1)

      # Random Number from Proposal
      alpha_prop <- rgamma(1, shape = q_shape, scale = q_scale)

      # Probability of Acceptance
      h_prop <- Gamma2Param_h(alpha_prop, alpha_0, mu_0, nj, Sj, LnPj, mu[j_alpha])
      h_curr <- Gamma2Param_h(alpha[j_alpha], alpha_0, mu_0, nj, Sj, LnPj, mu[j_alpha])
      LnKq_curr_to_prop <- log(dgamma(alpha_prop, shape = q_shape, scale = q_scale))
      LnKq_prop_to_curr <- log(dgamma(alpha[j_alpha], shape = q_shape, scale = q_scale))
      prob_acc_alpha <- min(1, exp(h_prop - h_curr + LnKq_prop_to_curr - LnKq_curr_to_prop))
      ALL_PROB_alpha[t,j_alpha] <- prob_acc_alpha
      if (runif(1) < prob_acc_alpha){
        alpha[j_alpha] <- alpha_prop
      }
    }
  }
  alpha <- alpha[1:N]
  MC[[t]]$alpha <- alpha
  
  h <- MEM_h(oab, x, mu, d)
  y <- x / h
  # Update Sj_vec after alpha's update
  Sj_vec <- matrix(0,N,1)
  for (j_alpha in 1:N){
    if (n_vec[j_alpha] > 0)
      Sj_vec[j_alpha] <- sum(y[d == j_alpha])
  }
  
  # 4) Sampling mu
  mu <- 1 / rgamma(N, shape = gamma + n_vec*alpha, scale = 1/(delta + alpha*Sj_vec))
  MC[[t]]$mu <- mu
  h <- MEM_h(oab, x, mu, d)
  y <- x / h
  
  # 5) Sampling d : u, v(w), alpha, mu
  p01 <- (matrix(rep(xi[1:N],n), nrow = N) > matrix(rep(u,N),nrow = N, byrow = TRUE)) *
    matrix(rep(w,n),nrow = N) / matrix(rep(xi[1:N],n),nrow = N)
  p02 <- dgamma(matlab::reshape(matrix(rep(y, N), nrow = N, byrow = TRUE), N*n,1), 
                shape = matlab::reshape(matrix(rep(alpha, n), nrow = N), N*n,1),
                scale = matlab::reshape(matrix(rep(mu, n), nrow = N), N*n,1) / 
                  matlab::reshape(matrix(rep(alpha, n), nrow = N), N*n,1))
  p0 <- p01 * matlab::reshape(p02, N, n)
  p <- p0 / matrix(rep(colSums(p0),N), nrow = N, byrow = TRUE)
  q <- apply(p, MARGIN = 2, FUN = cumsum)
  
  d <- 1 + colSums(rep(runif(n), ncol = N, byrow = TRUE) > q)
  h <- MEM_h(oab, x, mu, d)
  y <- x / h
  MC[[t]]$d <- d

  # 6) Sampling Dirichlet Process Precision Parameter
  k_Active_Comp <- length(unique(d))
  Eta_M <- rbeta(1, M + 1, n)
  pi_Eta_M <- 1 / (1 + n * (prior_M_rate - log(Eta_M)) / (prior_M_shape + k_Active_Comp - 1))
  u_Mixture_M <- runif(1)
  if (u_Mixture_M < pi_Eta_M){
    M <- rgamma(1, shape = prior_M_shape + k_Active_Comp, scale = 1/(prior_M_rate - log(Eta_M)))
  }else{
    M <- rgamma(1, shape = prior_M_shape + k_Active_Comp - 1, scale = 1/(prior_M_rate - log(Eta_M)));
  }
  MC[[t]]$M <- M
  xi <- (M / (kappa * (1 + M))) ^ (0:(1e3-1)) / M
  MC[[t]]$xi <- xi
  
  w_extended  <- matrix(0, 1e3, 1)
  mu_extended <- matrix(0, 1e3, 1)
  w_extended[1:length(w)] <- w
  mu_extended[1:length(mu)] <- mu
  i_wex <- length(w)
  while (i_wex < length(w_extended) & sum(w_extended) < 1-1e-12){
    i_wex <- i_wex + 1
    v_ex <- rbeta(1, 1, M)
    w_extended[i_wex] <- v_ex * (1 - sum(w_extended[1:(i_wex-1)]))
    mu_extended[i_wex] <- 1 / rgamma(1, shape = gamma, scale = 1 / delta)
  }
  w_extended <- w_extended[1:i_wex]
  mu_extended <- mu_extended[1:i_wex]

  # This alternative should be almost the same:
  # it does not introduce the limit on the size of the extended vector, but is more 
  # compliant to R standards
  # 
  # w_extended <- w
  # mu_extended <- mu
  # while(sum(w_extended) < 1-1e-12){
  #   v_ex <- rbeta(1, 1, M)
  #   w_extended <- c(w_extended, v_ex * (1 - sum(w_extended[1:(i_wex-1)])))
  #   mu_extended <- c(mu_extended, 1 / rgama(1, shape = gamma, scale = 1 / delta))
  # }
  # 
  omega <- t(w_extended) %*% mu_extended / sum(w_extended)
  MC[[t]]$omega <- omega
  
  # 7) Sampling oab
{ 
  # Adaptive MALA proposal
  if (t == (NBurnIn + NMCMC0)){
    Stm1 <- cov(oab_Mapped_MATRIX[(NBurnIn+1):(t-1),])
    mtm1 <- colMeans(oab_Mapped_MATRIX[(NBurnIn+1):(t-1),])
    mtm2 <- colMeans(oab_Mapped_MATRIX[(NBurnIn+1):(t-2),])
    st <- MALA_Scale
  }
  if (t <= NBurnIn + NMCMC0){
    MALA_LAMBDA <- MLE$VC_MLE1[1:3, 1:3]
  }else{
    Stm2 <- Stm1
    xtm1 <- oab_Mapped_MATRIX[t-1, ]
    mtm2 <- mtm1

    mtm1 <- (t - NBurnIn - 2)/(t - NBurnIn - 1)*mtm2 + 1/(t - NBurnIn - 1)*xtm1
    Stm1 <-   (t - NBurnIn - 3)/(t - NBurnIn - 2)*Stm2 +
      mtm2 %*% t(mtm2) -
      (t - NBurnIn - 1)/(t - NBurnIn - 2) * mtm1%*%t(mtm1) +
      1/(t - NBurnIn - 2) * xtm1 %*% t(xtm1)

    Stm1 <- (Stm1 + t(Stm1)) / 2
    if (min(eigen(Stm1, only.values = TRUE)$values) < 0){
      Stm1 <- Stm2
    }
    MALA_LAMBDA <- Stm1

    # Adapt the scale factor following:
    # Atchadè,Y.F.(2006) - An Adaptive Version for the Metropolis Adjusted
    #                      Langevin Algorithm with a Truncated Drift
    stm1 <- st
    st <- stm1 + 10/(t - NBurnIn - NMCMC0) * (ALL_PROB_oab[t-1] - tau)
    if (st < eps_Scale){
      st <- eps_Scale
    }else if(st > A_Scale){
      st <- A_Scale
    }
    MALA_Scale <- st
    MC[[t]]$MALA_Scale <- MALA_Scale
  }
  MALA_LAMBDA <- MALA_LAMBDA / (c(omega,omega,1) %*% t(c(omega,omega,1)))
  Proposal_Mean <- oab + t(MALA_Scale^2/2 * MALA_LAMBDA %*% GradientFullCond(oab, d, alpha, mu, x, VC_hyperparam_oab))
  Proposal_VC <- MALA_Scale ^ 2 * MALA_LAMBDA

  oab_prop <- rmvnorm(1, mean = Proposal_Mean, sigma = Proposal_VC)
  if (min(oab_prop) > 0){
    LnPostCurr <- MEMFullCond(oab, d, alpha, mu, x, VC_hyperparam_oab)
    h <- MEM_h(oab, x, mu, d)
    LnPostProp <- MEMFullCond(oab_prop, d, alpha, mu, x, VC_hyperparam_oab)
    h_prop <- MEM_h(oab_prop, x, mu, d)
    LnQPropCurr <- log(
      dmvnorm(oab,
              mean = oab_prop + t(MALA_Scale^2/2 * MALA_LAMBDA %*% GradientFullCond(oab_prop, d, alpha, mu, x, VC_hyperparam_oab)),
              sigma = Proposal_VC))
    LnQCurrProp <- log(dmvnorm(oab_prop, mean = Proposal_Mean, sigma = Proposal_VC))
    prob_acc <- min(1, exp(LnPostProp - LnPostCurr + LnQPropCurr - LnQCurrProp))
  }else{
    prob_acc <- 0
  }
}

{  
  # # Adapting the proposal Sigma
  # if (t == (NBurnIn + NMCMC0)){
  #   Stm1 <- cov(oab_Mapped_MATRIX[(NBurnIn+1):(t-1),])
  #   mtm1 <- colMeans(oab_Mapped_MATRIX[(NBurnIn+1):(t-1),])
  #   mtm2 <- colMeans(oab_Mapped_MATRIX[(NBurnIn+1):(t-2),])
  #   # st <- Scale
  # }
  # if (t <= NBurnIn + NMCMC0){
  #   Proposal_Sigma <- MLE$VC_MLE1[1:3, 1:3]
  # }else{
  #   Stm2 <- Stm1
  #   xtm1 <- oab_Mapped_MATRIX[t-1, ]
  #   mtm2 <- mtm1
  # 
  #   mtm1 <- (t - NBurnIn - 2)/(t - NBurnIn - 1)*mtm2 + 1/(t - NBurnIn - 1)*xtm1
  #   Stm1 <-   (t - NBurnIn - 3)/(t - NBurnIn - 2)*Stm2 +
  #     mtm2 %*% t(mtm2) -
  #     (t - NBurnIn - 1)/(t - NBurnIn - 2) * mtm1%*%t(mtm1) +
  #     1/(t - NBurnIn - 2) * xtm1 %*% t(xtm1)
  # 
  #   Stm1 <- (Stm1 + t(Stm1)) / 2
  #   if (min(eigen(Stm1, only.values = TRUE)$values) < 0){
  #     Stm1 <- Stm2
  #   }
  #   Proposal_Sigma <- Stm1
  #   # # Adapt the scale factor following:
  #   # # Atchadè,Y.F.(2006) - An Adaptive Version for the Metropolis Adjusted
  #   # #                      Langevin Algorithm with a Truncated Drift
  #   # stm1 <- st
  #   # st <- stm1 + 10/(t - NBurnIn - NMCMC0) * (ALL_PROB_oab[t-1] - tau)
  #   # if (st < eps_Scale){
  #   #   st <- eps_Scale
  #   # }else if(st > A_Scale){
  #   #   st <- A_Scale
  #   # }
  #   # Scale <- st
  #   # MC[[t]]$Scale <- Scale
  # }
}  
{  
  # MultiLogNormal Proposal
  # 
  # Proposal_mu <- log(oab)
  # Proposal_Sigma <- (Proposal_Sigma / (c(omega,omega,1) %*% t(c(omega,omega,1))) + eps2 * diag(length(oab))) * (Scale)^2 / length(oab)
  # oab_prop <- exp(rmvnorm(1, mean = Proposal_mu, sigma = Proposal_Sigma))
  # # if (min(oab_prop) >= 0){
  #   LnPostCurr <- MEMFullCond(oab, d, alpha, mu, x, VC_hyperparam_oab)
  #   # h <- MEM_h(oab, x, mu, d)
  #   LnPostProp <- MEMFullCond(oab_prop, d, alpha, mu, x, VC_hyperparam_oab)
  #   h_prop <- MEM_h(oab_prop, x, mu, d)
  #   LnQPropCurr <- log(dmvnorm(log(oab), mean = log(oab_prop), sigma = Proposal_Sigma) / prod(oab))
  #   LnQCurrProp <- log(dmvnorm(log(oab_prop), mean = Proposal_mu, sigma = Proposal_Sigma) / prod(oab_prop))
  #   prob_acc <- min(1, exp(LnPostProp - LnPostCurr + LnQPropCurr - LnQCurrProp))
  #   # 
  #   # prob_acc <- min(1, exp(LnPostProp - LnPostCurr))
  # # }else{
  # #   prob_acc <- 0
  # # }
} 
{
  # # MultiNormal proposal
  # Proposal_mu <- oab
  # Proposal_Sigma <- (Proposal_Sigma / (c(omega,omega,1) %*% t(c(omega,omega,1))) + eps2 * diag(length(oab))) * (Scale)^2 / length(oab)
  # oab_prop <- rmvnorm(1, mean = Proposal_mu, sigma = Proposal_Sigma)
  # if (min(oab_prop) >= 0){
  #   LnPostCurr <- MEMFullCond(oab, d, alpha, mu, x, VC_hyperparam_oab)
  #   h <- MEM_h(oab, x, mu, d)
  #   LnPostProp <- MEMFullCond(oab_prop, d, alpha, mu, x, VC_hyperparam_oab)
  #   h_prop <- MEM_h(oab_prop, x, mu, d)
  #   prob_acc <- min(1, exp(LnPostProp - LnPostCurr))
  # }else{
  #   prob_acc <- 0
  # }
}  
  ALL_PROB_oab = c(ALL_PROB_oab, prob_acc)
  if(u_MH_OAB[t] < prob_acc){
    oab <- oab_prop
    h <- h_prop
    LnPostCurr <- LnPostProp
  }
  MC[[t]]$oab <- oab
  oab_matrix[t,] <- oab
  
  y <- x / h
  MC[[t]]$y <- y
  MC[[t]]$h <- h
  MC[[t]]$mu_mapped <- MC[[t]]$mu / MC[[t]]$omega
  MC[[t]]$y_mapped <- MC[[t]]$y / MC[[t]]$omega
  
  oab_Mapped <- oab * c(omega,omega,1)
  oab_Mapped_MATRIX[t, ] <- oab_Mapped
  oab_MEAN <- (oab_Mapped + (t-1) * oab_MEAN) / t
  
  # PLOTS
  if (t %% NPlot == 0){
    tcltk::setTkProgressBar(pb,t,paste(t,"of",NBurnIn + NMCMC0 + NMCMC1))
    cat("\014")  # Clean the console
    # Time_Elapsed <- matlab::toc()
    # Time_Remained <- Time_Elapsed / t * (NBurnIn + NMCMC0 + NMCMC1 - t);
    # print('************************************************')
    # print(paste0('Simulation ends at: ' datestr(now + Time_Remained / 60 / 60 / 24)))
    # disp('************************************************')
    print(c(paste("Step:",t),
            paste("Execution Percentage:", t/(NBurnIn + NMCMC0 + NMCMC1)*100),
            paste("MLE:           ",MLE$o_MEM_MLE,MLE$a_MEM_MLE,MLE$b_MEM_MLE),
            paste("MCMC Estimates:",oab_MEAN[1],oab_MEAN[2],oab_MEAN[3]),
            ifelse(exists("TRUE_vals"), paste("True:",TRUE_vals$o_MEM_TRUE,TRUE_vals$a_MEM_TRUE,TRUE_vals$b_MEM_TRUE),
                   paste("")),
            paste("Omega:", omega),
            paste("Innovations mean:", mean(y)),
            paste("DPM's concentration parameter:", M),
            paste("Number of active components:", N), 
            paste("Average acceptance rate oab:",mean(ALL_PROB_oab)),
            paste("Average acceptance rate alpha:",
                  colMeans(ALL_PROB_alpha, na.rm = TRUE)[!is.nan(colMeans(ALL_PROB_alpha, na.rm = TRUE))]),
            paste("Length w:", length(w)),
            paste("Length w_ext:", length(w_extended)),
            paste("Sum w:", sum(w)),
            paste("Sum w_ext:", sum(w_extended)),
            paste("MALA_Scale:", MALA_Scale)
            )
          )

    # STDERR = [sqrt(diag(VC_prop)) sqrt(diag(MLE$VC_MLE1(1:3, 1:3)))]
    # CORR = VC_prop ./ (sqrt(diag(VC_prop)) * sqrt(diag(VC_prop))')
    par(mfrow = c(5,1))
    par(mar=c(1,4.1,1,2.1))
    
    plot((max(1, t - NPlotWindow + 1):t), oab_Mapped_MATRIX[max(1, t - NPlotWindow + 1):t, 1],
         xlim = c(max(1, t - NPlotWindow + 1), t),
         ylab = "o", type = "l")
    
    plot(max(1, t - NPlotWindow + 1):t, oab_Mapped_MATRIX[max(1, t - NPlotWindow + 1):t, 2],
         xlim = c(max(1, t - NPlotWindow + 1), t),
         ylab = "a", type = "l")
    
    plot(max(1, t - NPlotWindow + 1):t, oab_Mapped_MATRIX[max(1, t - NPlotWindow + 1):t, 3],
         xlim = c(max(1, t - NPlotWindow + 1), t),
         ylab = "b", type = "l")
    
    alpha1_vec <- c()
    omega_temp_vec <- c()
    for(j_temp in max(1, t - NPlotWindow + 1):t){
      alpha1_vec <- c(alpha1_vec, MC[[j_temp]]$alpha[which.max(MC[[t]]$w)])
      omega_temp_vec <- c(omega_temp_vec, MC[[j_temp]]$omega)
    }
    
    plot(max(1, t - NPlotWindow + 1):t, alpha1_vec,
         xlim = c(max(1, t - NPlotWindow + 1), t),
         ylab = paste0("alpha",which.max(MC[[t]]$w)), type = "l")
    
    plot(max(1, t - NPlotWindow + 1):t, omega_temp_vec,
         xlim = c(max(1, t - NPlotWindow + 1), t),
         ylab = "omega", type = "l")
  }
}
)
close(pb)
#### Convergence Diagnostics ####
chain <- mcmc(oab_Mapped_MATRIX, 
              start = NBurnIn + NMCMC0 + 1, end = NBurnIn + NMCMC0 + NMCMC1, thin = 1)
plot(chain, trace = TRUE, density = TRUE, smooth = TRUE, auto.layout = TRUE)

summary(chain, quantiles = c(0.025, 0.25, 0.5, 0.75, 0.975))

{# Simlations
# Iterations = 2001:12000
# Thinning interval = 1 
# Number of chains = 1 
# Sample size per chain = 10000 
# 
# 1. Empirical mean and standard deviation for each variable,
# plus standard error of the mean:
#   
#   Mean      SD  Naive SE Time-series SE
# [1,] 0.4235 0.04992 0.0004992      0.0011353
# [2,] 0.3038 0.01308 0.0001308      0.0002964
# [3,] 0.6456 0.01559 0.0001559      0.0003560
# 
# 2. Quantiles for each variable:
#   
#        2.5%    25%    50%    75%  97.5%
# var1 0.3268 0.3895 0.4225 0.4573 0.5224
# var2 0.2789 0.2949 0.3038 0.3123 0.3303
# var3 0.6137 0.6352 0.6457 0.6563 0.6752
}
{
  # Real Data 1
  # Iterations = 2001:12000
  # Thinning interval = 1 
  # Number of chains = 1 
  # Sample size per chain = 10000 
  # 
  # 1. Empirical mean and standard deviation for each variable,
  # plus standard error of the mean:
  #   
  #   Mean       SD  Naive SE Time-series SE
  # [1,] 0.01008 0.006835 6.835e-05      0.0002114
  # [2,] 0.95985 0.037414 3.741e-04      0.0018735
  # [3,] 0.03537 0.037531 3.753e-04      0.0018681
  # 
  # 2. Quantiles for each variable:
  #   
  #   2.5%      25%      50%     75%   97.5%
  # var1 0.0004464 0.004842 0.008944 0.01408 0.02616
  # var2 0.8851989 0.946569 0.968321 0.98305 0.99573
  # var3 0.0011157 0.011599 0.026543 0.04795 0.11019
  # 
  # It seems that the most relevant term in the conditional mean specification is x_(t-1)
}
{
  # Real Data 2 (Adaptation MALA_Scale)
  # Iterations = 2001:12000
  # Thinning interval = 1 
  # Number of chains = 1 
  # Sample size per chain = 10000 
  # 
  # 1. Empirical mean and standard deviation for each variable,
  # plus standard error of the mean:
  #   
  #         Mean       SD  Naive SE Time-series SE
  # [1,] 0.01023 0.006912 6.912e-05      0.0002141
  # [2,] 0.96005 0.040262 4.026e-04      0.0020833
  # [3,] 0.03505 0.040236 4.024e-04      0.0020800
  # 
  # 2. Quantiles for each variable:
  #   
  #           2.5%      25%      50%     75%   97.5%
  # var1 0.0005219 0.004609 0.009267 0.01451 0.02596
  # var2 0.8856526 0.945818 0.969451 0.98406 0.99657
  # var3 0.0011447 0.010952 0.025111 0.04969 0.10889
}

# Compute autocorrelation at different lags for all the chains:
autocorr(chain, lags = c(0, 1, 5, 10, 50), relative=TRUE)
{
  # Simulations:
  # The correlations with lagged observations of the same chain at lag 10 are always 
  # non-significant. And this olds also for the correlations with the lagged observations
  # of the other chains at lag 10. 
  # Thus there seem to be good mixing.
}
{
  # Real Data:
  # There doesn't seem to be good mixing since both the auto and the cross correlations
  # remain significant for more than 50 Lags for two out of three variables.
  # Probably 2,000 steps of Burn-In and 10,000 steps of simulations are not enough.
}
{
  # Real Data (Adaptation Scale)
  # , , 1
  # 
  #               [,1]          [,2]         [,3]
  # Lag 0   1.00000000 -0.0485819911 -0.040022523
  # Lag 1   0.80117764 -0.0496017326 -0.021707975
  # Lag 5   0.34332589 -0.0426019107  0.012448260
  # Lag 10  0.12056420 -0.0201073629  0.010187720
  # Lag 50 -0.05560896 -0.0003087262  0.004340036
  # 
  # , , 2
  # 
  #                [,1]        [,2]       [,3]
  # Lag 0  -0.048581991  1.00000000 -0.9951411
  # Lag 1  -0.048446591  0.89448076 -0.8928065
  # Lag 5  -0.042611465  0.62037211 -0.6183046
  # Lag 10 -0.016395624  0.44859980 -0.4483789
  # Lag 50 -0.001830344 -0.02225497  0.0231259
  # 
  # , , 3
  # 
  #                [,1]        [,2]        [,3]
  # Lag 0  -0.040022523 -0.99514115  1.00000000
  # Lag 1  -0.022673461 -0.89108619  0.89575395
  # Lag 5   0.012261687 -0.61767803  0.61826159
  # Lag 10  0.005297630 -0.44724483  0.44792531
  # Lag 50  0.007064301  0.02257989 -0.02383368
}

autocorr.plot(chain, lags = c(0, 1, 5, 10, 50), relative=TRUE)

# Compute the effective size of each sampled chain
effectiveSize(chain)
{
  # Simulations:
  # var1     var2     var3 
  # 1933.372 1946.713 1917.307 
  # The effective sample size is significant.
}
{
  # Real Data (2,000 + 10,000).
  #      var1      var2      var3 
  # 1044.9177  398.7864  403.6494 
  # The ESS for a and b are quite small, 
  # indicanting that there is high autocorrelations in the chains
}
{ 
  #      var1      var2      var3 
  # 1041.7878  373.4806  374.2120 
}

# Gelman and Rubin convergence diagnostic.
{
  # # This test is computed under the assumption that the stationary distribution of the chain
  # # is normal. Thus we first have to check the densities of the chains.
  # densplot(chain)
  # # The densities are indeed bell-shaped, so we might accept the normality assumption.
  # gelman.diag(chain, confidence = 0.95, transform = FALSE, autoburnin = TRUE,
  #             multivariate = TRUE)
  # This test is for multiple chains.
}
# Geweke convergence diagnostic.
{
  # It is based on a test for equality of the means of the first and last part of a 
  # Markov chain (by default the first 10% and the last 50%). 
  # If the samples are drawn from the stationary distribution of the chain, 
  # the two means are equal and Geweke’s statistic has an asymptotically standard normal 
  # distribution.
  # The test statistic is a standard Z-score: the difference between the two sample means
  # divided by its estimated standard error. 
  # The standard error is estimated from the spectral density at zero and so takes into 
  # account any autocorrelation.
  # 
  # The convergence is considered reached if the values obtained lay in [-1.96, +1.96]
}
geweke.diag(chain, frac1=0.1, frac2=0.5)
{
  # Simulations:
  # var1    var2    var3 
  # -0.7075 -1.1274  0.9554 
  # All the values are within the required interval
}
{
  # Real Data (2,000 - 10,000):
  #    var1    var2    var3 
  #  0.8031 -1.7485  1.7875
  #  It seems that all the chians have reached convergence.
}
{
  # Real Data (Scale adapt)
  # Fraction in 1st window = 0.1
  # Fraction in 2nd window = 0.5 
  # 
  # var1    var2    var3 
  # -0.4003 -1.2106  1.2358 
}
geweke.plot(chain, frac1 = 0.1, frac2 = 0.5, nbins = 20,
            pvalue = 0.05, auto.layout = TRUE)
{
  # Simluaitons:
  # It seems that changing the initial fraction things remain stable.
}
{
  # Real Data (2,000 - 10,000):
  # It seems that changing the initial fraction things remain stable.
}
{
  # Real Data (scale adapt):
  # It seems that changing the initial fraction things remain stable.
}
  
# Heidelberger and Welch’s convergence diagnostic
{
  # The convergence test uses the Cramer-von-Mises statistic to test the null hypothesis
  # that the sampled values come from a stationary distribution. 
  # The test is successively applied, firstly to the whole chain, 
  # then after discarding the first 10%, 20%, . . . of the chain until either the 
  # null hypothesis is accepted, or 50% of the chain has been discarded.
  # 
  # The half-width test calculates a 95% confidence interval for the mean, 
  # using the portion of the chain which passed the stationarity test. 
  # Half the width of this interval is compared with the estimate of the mean. 
  # If the ratio between the half-width and the mean is lower than eps, 
  # the halfwidth test is passed. 
  # Otherwise the length of the sample is deemed not long enough to estimate the mean 
  # with sufficient accuracy.
}
heidel.diag(chain, eps=0.1, pvalue=0.05)
{
  # Simulations:
  # Stationarity start     p-value
  # test         iteration        
  # var1 passed       1         0.183  
  # var2 passed       1         0.263  
  # var3 passed       1         0.216  
  # 
  # Halfwidth Mean  Halfwidth
  # test                     
  # var1 passed    0.424 0.002225 
  # var2 passed    0.304 0.000581 
  # var3 passed    0.646 0.000698  
  # 
  # All the variable seem to have reached convergence.
  # Also the Halfwidth test is passed for all the variables,
  # meaning that the part of the chain that is found to have converged is enough to 
  # estimate accurately the mean.
}
{
  # Real Data (2,000 - 10,000):
  # Stationarity start        p-value
  # test         iteration        
  # var1 passed          1      0.838  
  # var2 passed       3001      0.178  
  # var3 passed       3001      0.167  
  # 
  # Halfwidth      Mean   Halfwidth
  # test                      
  # var1 passed    0.0101 0.000414 
  # var2 passed    0.9635 0.002009 
  # var3 passed    0.0317 0.001966 
  # 
  # All the variable seem to have reached convergence.
  # Also the Halfwidth test is passed for all the variables,
  # meaning that the part of the chain that is found to have converged is enough to 
  # estimate accurately the mean.
}
{
  # Real Data (Scale Adapt)
  # Stationarity start     p-value
  # test         iteration        
  # var1 passed          1      0.7688 
  # var2 passed       1001      0.0636 
  # var3 passed       1001      0.0704 
  # 
  # Halfwidth Mean   Halfwidth
  # test                      
  # var1 passed    0.0102 0.00042  
  # var2 passed    0.9624 0.00197  
  # var3 passed    0.0327 0.00192  
}

# Raftery diagnostic test
{
  # An estimate I (the ‘dependence factor’) of the extent to which autocorrelation 
  # inflates the required sample size is also provided. 
  # Values of I larger than 5 indicate strong autocorrelation which may be due to 
  # a poor choice of starting value, high posterior correlations or 
  # ‘stickiness’ of the MCMC algorithm.
}
raftery.diag(chain, q=0.025, r=0.005, s=0.95, converge.eps=0.001)
{
  # Simulations:
  # Burn-in  Total Lower bound  Dependence
  # (M)      (N)   (Nmin)       factor (I)
  # 9        9593  3746         2.56      
  # 8        10732 3746         2.86      
  # 9        9482  3746         2.53      
  # 
  # From this test, it seems that the chains have indeed reached convergence.
}
{
  # Real Data (2,000 - 10,000)
  # Burn-in  Total Lower bound  Dependence
  # (M)      (N)   (Nmin)       factor (I)
  # 21       22740 3746         6.07      
  # 33       35412 3746         9.45      
  # 25       27230 3746         7.27
  # From this test, it seems that the chains have indeed reached convergence.
}
{
  # Real Data (Scale adapt)
  # Quantile (q) = 0.025
  # Accuracy (r) = +/- 0.005
  # Probability (s) = 0.95 
  # 
  # Burn-in  Total Lower bound  Dependence
  # (M)      (N)   (Nmin)       factor (I)
  # 21       22362 3746         5.97      
  # 30       32404 3746         8.65      
  # 24       25947 3746         6.93  
}

#### Evaluation of the estimates ####
# Compute the effective standard deviation throught the "batch method".
batchSE(chain, batchSize=100)
{
  # Simulations:
  # 0.0011112708 0.0003313302 0.0003978497
}
{
  # Real Data (2,000 - 10,000)
  # batchSE(chain, batchSize=100)
  # 0.0002015427 0.0019011983 0.0018877503
  # The standard Errors estimated with the batch method seem to be quite small, 
  # although probably a batch size of 100 is not optimal because of the high
  # autocorrelations in the chains.
}
{
  # Real Data (scale adapt)
  # 0.0001843301 0.0018622936 0.0018635782
  # The standard Errors estimated with the batch method seem to be quite small, 
  # although probably a batch size of 100 is not optimal because of the high
  # autocorrelations in the chains.
}

# Euristic evaluation
{
  colMeans(chain)
  # Simulations:
  # 0.3885234 0.2569308 0.6937757
  colMeans(chain) + 3*batchSE(chain, batchSize=100)
  colMeans(chain) - 3*batchSE(chain, batchSize=100)
  # 0.4268549 0.3047701 0.6468007
  # 0.4201872 0.3027821 0.6444136
  # o_MEM_TRUE a_MEM_TRUE b_MEM_TRUE
  # 0.4        0.3        0.65
  # The estimates does not seem so good, since the true value of the parameter does not
  # fall inside the interval estimate +- 3*SE. 
  # This rule of thumb is based on the assumption that the 95% of the distribution falls
  # inside the interval mean +- 3*SD. It might be false for these specific distributions.
  # Hence we are going to check further the plots of the posteriod distribution.
  
}

# A better estimate of the 95% posterior intervals is given by:
HPDinterval(chain, prob = 0.95)
{
  # Simulations:
  #          lower     upper
  # var1 0.3267381 0.5223867
  # var2 0.2781965 0.3292456
  # var3 0.6149347 0.6758883
  # 
  # All the true values lie inside the 95% HDP, so the estimates seem to be trustworthy.
}
{
  colMeans(chain)
  # 0.01008120 0.95984661 0.03537073
  # Real Data (2,000 - 10,000)
  #             lower      upper
  # var1 1.766609e-06 0.02319886
  # var2 9.002677e-01 0.99978146
  # var3 4.986519e-05 0.09409911
}
{ 
  # Real Data (scale adapt)
  # lower      upper
  # var1 3.244418e-05 0.02308063
  # var2 9.017074e-01 1.00076236
  # var3 6.544082e-05 0.09313589
}




#### Predictions ####

# Mapping mixture components means and estiamted innovations to have unit mean
for (t in 1:(NBurnIn + NMCMC0 + NMCMC1)){
  MC[[t]]$mu_mapped <- MC[[t]]$mu / MC[[t]]$omega
  MC[[t]]$y_mapped <- MC[[t]]$y / MC[[t]]$omega
}
par(mfrow = c(1,1))
par(mar = c(5.1,4.1,4.1,2.1))
plot(MC[[t]]$y_mapped, type = "l", main = "Estimated Innovations",
     ylim = c(max(c(max(MC[[t]]$y_mapped),max(MC[[t]]$y))),
              min(c(min(MC[[t]]$y_mapped),min(MC[[t]]$y)))))
lines(MC[[t]]$y, col = "red")
legend("topleft", legend = c("Mapped", "Not-mapped"), col =c("black","red"),
       lwd = 1, lty = 1)

# Matrices of Parameters
e_vec <- 0
N_vec <- c()
M_vec <- c()
omega_vec <- c()
for (t in 1:NMCMC1){
  N_vec <- c(N_vec,MC[[NBurnIn + NMCMC0 + t]]$N)
  omega_vec <- c(omega_vec, MC[[NBurnIn + NMCMC0 + t]]$omega)
  M_vec = c(M_vec, MC[[NBurnIn + NMCMC0 + t]]$M)
  e_vec <- e_vec + MC[[t]]$y_mapped
}
e_vec <- e_vec / NMCMC1
plot(e_vec, type = "l", main = "Estimated Innovations")


if(exists("TRUE_vals")){
  plot(TRUE_vals$e_TRUE[1:3000], type = "l", main = "Innovations")
  lines(MLE$e_MLE, col = "red")
  lines(e_vec, col = "blue")
  legend("topleft", legend = c("True", "ML Estimate", "DPM Estimate"), col =c("black","red", "blue"),
         lwd = 1, lty = 1)
  Metrics::rmse(TRUE_vals$e_TRUE[1:3000],MLE$e_MLE) # 0.008911248
  Metrics::rmse(TRUE_vals$e_TRUE[1:3000],e_vec) # 0.009411127
  # The innovations estimated with both methods fit very well the true ones.
  
  plot(density(TRUE_vals$e_TRUE[1:3000]), main = "Innovations' density")
  lines(density(MLE$e_MLE), col = "red")
  lines(density(e_vec), col = "blue")
  legend("topright", legend = c("True", "ML Estimate", "DPM Estimate"), col =c("black","red", "blue"),
         lwd = 1, lty = 1)
}else{
  plot(MLE$e_MLE, type = "l", main = "Innovations")
  lines(e_vec, col = "red")
  legend("topleft", legend = c("ML Estimates", "DPM Estimates"), col =c("black","red"),
         lwd = 1, lty = 1)
  
  plot(density(MLE$e_MLE), main = "Innovations' density",
       ylim = c(0, max(c(max(density(MLE$e_MLE)$y),max(density(e_vec)$y)))))
  lines(density(e_vec), col = "red")
  legend("topright", legend = c("ML Estimate", "DPM Estimate"), col =c("black","red"),
         lwd = 1, lty = 1)
}

plot(N_vec, type = "l", ylab = "Active components", xlab = "Step after Burn-in", main = "Number of active components")
plot(M_vec, type = "l", ylab = "DP concentration parameter", xlab = "Step after Burn-in", main = "DP concentration parameter")
plot(omega_vec, type = "l", ylab = "Normalization constant (omega)", xlab = "Step after Burn-in", main = "Mean-normalization constant")

w_matrix <- matrix(NaN, NMCMC1, max(N_vec))
alpha_matrix <- matrix(NaN, NMCMC1, max(N_vec))
mu_mapped_matrix <- matrix(NaN, NMCMC1, max(N_vec))
mu_matrix <- matrix(NaN, NMCMC1, max(N_vec))
for (t in 1:NMCMC1){
  w_matrix[t, 1:length(MC[[NBurnIn + NMCMC0 + t]]$w)] <- 
    MC[[NBurnIn + NMCMC0 + t]]$w
  alpha_matrix[t, 1:length(MC[[NBurnIn + NMCMC0 + t]]$alpha)] <- 
    MC[[NBurnIn + NMCMC0 + t]]$alpha
  mu_mapped_matrix[t, 1:length(MC[[NBurnIn + NMCMC0 + t]]$mu)] <- 
    MC[[NBurnIn + NMCMC0 + t]]$mu_mapped
  mu_matrix[t, 1:length(MC[[NBurnIn + NMCMC0 + t]]$mu)] <- 
    MC[[NBurnIn + NMCMC0 + t]]$mu
}

plot(w_matrix[,1], type = "l", 
     xlab = "Step after Burn-in", ylab = "Mixture weight",
     ylim = c(min(w_matrix, na.rm = TRUE), max(w_matrix, na.rm = TRUE)), 
     main = "Weigths of the active components")
lines(w_matrix[,2], type = "l", col = "red")
lines(w_matrix[,3], type = "l", col = "blue")
lines(w_matrix[,4], type = "l", col = "green")
lines(w_matrix[,5], type = "l", col = "orange")
legend("topleft", legend = c("1","2","3","4","5"), 
       col =c("black","red","blue","green","orange"),
       lwd = 1, lty = 1, cex = 0.8)

{ 
  # Real data (Adapt Scale)
  # There seem to be only one significant component
  # Let's see the values of its parameters
  plot(alpha_matrix[,2], type = "l", main = "Scale parameter of the second component")
  plot(alpha_matrix[,3], type = "l", main = "Scale parameter of the third component")
  plot(mu_matrix[,2], type = "l", main = "Scale parameter of the second component")
  plot(mu_matrix[,3], type = "l", main = "Scale parameter of the third component")
}

plot(rowSums(mu_mapped_matrix*w_matrix, na.rm = TRUE), type = "l")
# This plot confirms that the mean of the innovations, after the mapping, is effectively 1. 

oab_Mapped_MATRIX_trunc <- oab_Mapped_MATRIX[(NBurnIn + NMCMC0+1):nrow(oab_Mapped_MATRIX),]

# Interpolate the density of the innovations.
# For every point of the chosen grid f_hat_x, 
# we compute the innovations' density with the parameters computed during all the MCMC
# steps after burn in, and then we take a mean on those evaluations.
# This gives us a vector f_hat_y of density values for every point of the grid.
f_hat_x <- seq(0, 2*max(e_vec), length.out = 1e3+1)[-1]
f_hat_y <- c()
for (i_f_hat in 1:length(f_hat_x)){
  f_hat_y <- c(f_hat_y, 
               mean(rowSums(w_matrix * dgamma(f_hat_x[i_f_hat], 
                                              shape = alpha_matrix, 
                                              scale = mu_mapped_matrix / alpha_matrix),
                            na.rm = TRUE)))
}
plot(f_hat_x, f_hat_y, type = "l", main = "Smooth interpolated innovations' density")


# Log Predictive Score Computations: In the Sample
# ff  : DPM Model (estimated with MCMC)
# fff : One Component Gamma (Estimated with ML)
ff_vec <- c()
fff_vec <- dgamma(x, shape = MLE$phi_MEM_MLE, scale = MLE$h_MLE / MLE$phi_MEM_MLE)
for (i in 1:length(x)){
  ff_vec <- c(ff_vec, 
              mean(rowSums(w_matrix * 
                             dgamma(x[i], 
                                    shape = alpha_matrix, 
                                    scale = (x[i]/e_vec[i]) * 
                                      mu_mapped_matrix/alpha_matrix),
                           na.rm = TRUE)
                   )
              )
}
print(c(paste("LPS 1-Component Gamma:", -mean(log(fff_vec))),
        paste("LPS DPM (2Params):", -mean(log(ff_vec)))))
{
  # Simulations:
  # "LPS 1-Component Gamma: 2.35488573938988" 
  # "LPS DPM (2Params): 2.33438832635554"  
  # Thus the DPMG2-MEM has a higher predictive power that the Gamma1-MEM
}
{
  # Real Data (2,000 - 10,000):
  # "LPS 1-Component Gamma: -0.641056198976225"
  # "LPS DPM (2Params): -0.855448690525094
  # Thus the DPMG2-MEM seem to have a higher predictive power that the Gamma1-MEM"   
}
{
  # Real (scale adapt)
  # "LPS 1-Component Gamma: -0.641056198976225"
  # "LPS DPM (2Params): -0.850349942659247"
}
ITail <- x > quantile(x, 0.95)
print(c(paste("LPTS 5% 1-Component Gamma:", -mean(log(fff_vec[ITail]))),
        paste("LPTS 5% DPM (2Params):", -mean(log(ff_vec[ITail])))))
{
  # Real Data:
  # "LPTS 5% 1-Component Gamma: 0.0329331713079987"
  # "LPTS 5% DPM (2Params): -0.175297796157296" 
}
{
  # Real (scale adapt)
  # "LPTS 5% 1-Component Gamma: 0.0329331713079987"
  # "LPTS 5% DPM (2Params): -0.170552734640081"  
}
ITail = (x > quantile(x, 0.99));
print(c(paste("LPTS 1% 1-Component Gamma:", -mean(log(fff_vec[ITail]))),
        paste("LPTS 1% DPM (2Params):", -mean(log(ff_vec[ITail])))))
{
  # Real Data:
  # "LPTS 1% 1-Component Gamma: 0.347245697324888"
  # "LPTS 1% DPM (2Params): -0.0502124625203796"
}
{
  # Real (scale adaapt)
  # "LPTS 1% 1-Component Gamma: 0.347245697324888"
  # "LPTS 1% DPM (2Params): -0.045792614928078"
}
# We can see that the difference in predictive power between the two models increases 
# as we consider more extreme tail values.

# LPS: Out of Sample
omega_hat_GamMEM <- MLE$o_MEM_MLE
alpha_hat_GamMEM <- MLE$a_MEM_MLE
beta_hat_GamMEM <- MLE$b_MEM_MLE
phi_hat_GamMEM <- MLE$phi_MEM_MLE

omega_hat_DPMMEM <- mean(oab_Mapped_MATRIX_trunc[,1])
alpha_hat_DPMMEM <- mean(oab_Mapped_MATRIX_trunc[,2])
beta_hat_DPMMEM <- mean(oab_Mapped_MATRIX_trunc[,3])

h_hat_test_0_GamMEM <- Data$x_fit[length(Data$x_fit)] / MLE$e_MLE[length(MLE$e_MLE)]
h_hat_test_GamMEM <- NaN * Data$x_test

h_hat_test_0_DPMMEM <- Data$x_fit[length(Data$x_fit)] / e_vec[length(e_vec)]
h_hat_test_DPMMEM <- NaN * Data$x_test

for (i_OoS in 1:length(Data$x_test)){
  if (i_OoS == 1){
    h_hat_test_DPMMEM[i_OoS] <- 
      omega_hat_DPMMEM + alpha_hat_DPMMEM * Data$x_fit[length(Data$x_fit)] + 
      beta_hat_DPMMEM * h_hat_test_0_DPMMEM
    h_hat_test_GamMEM[i_OoS] <- 
      omega_hat_GamMEM + alpha_hat_GamMEM * Data$x_fit[length(Data$x_fit)] + 
      beta_hat_GamMEM * h_hat_test_0_GamMEM
  }else{
    h_hat_test_DPMMEM[i_OoS] <- 
      omega_hat_DPMMEM + alpha_hat_DPMMEM * Data$x_test[i_OoS - 1] + 
      beta_hat_DPMMEM * h_hat_test_DPMMEM[i_OoS - 1]
    h_hat_test_GamMEM[i_OoS] <- 
      omega_hat_GamMEM + alpha_hat_GamMEM * Data$x_test[i_OoS - 1] + 
      beta_hat_GamMEM * h_hat_test_GamMEM[i_OoS - 1]
  }
}
e_hat_test_DPMMEM <- Data$x_test / h_hat_test_DPMMEM
e_hat_test_GamMEM <- Data$x_test / h_hat_test_GamMEM

if(exists("TRUE_vals")){
  plot(TRUE_vals$e_TRUE[3001:4000], type = "l", main = "OoS Innovations")
  lines(e_hat_test_DPMMEM, col = "red")
  legend("topleft", legend = c("True", "Estimated"), col =c("black","red"),
         lwd = 1, lty = 1)
  Metrics::rmse(TRUE_vals$e_TRUE[3001:4000],e_hat_test_DPMMEM) # 0.008660624
  # The innovations estimated with the DPMG2-MEM model fit very well the true ones.
  
  plot(TRUE_vals$e_TRUE[3001:4000], type = "l", main = "OoS Innovations")
  lines(e_hat_test_GamMEM, col = "red")
  legend("topleft", legend = c("True", "Estimated"), col =c("black","red"),
         lwd = 1, lty = 1)
  Metrics::rmse(TRUE_vals$e_TRUE[3001:4000],e_hat_test_GamMEM) # 0.007513114
  # The innovations estimated with the G1-MEM model fit very well the true ones.
}else{
  plot(e_hat_test_DPMMEM, type = "l", main = "OoS Innovations")
  lines(e_hat_test_GamMEM, col = "red")
  legend("topleft", legend = c("DPMG2", "Gamma"), col =c("black","red"),
         lwd = 1, lty = 1)
}
LPS_OoS_GamMEM <- - mean(log(dgamma(e_hat_test_GamMEM, shape = phi_hat_GamMEM, 
                                   scale = 1 / phi_hat_GamMEM) / h_hat_test_GamMEM))
LPS_OoS_DPMMEM <- - mean(log(pracma::interp1(f_hat_x, f_hat_y, e_hat_test_DPMMEM, method = "linear") / h_hat_test_DPMMEM))

LPS_OoS_GamMEM_5Percent <- 
  - sum((Data$x_test > quantile(Data$x_test, 0.95)) * 
          log(dgamma(e_hat_test_GamMEM, scale = phi_hat_GamMEM, shape = 1/phi_hat_GamMEM) / h_hat_test_GamMEM)
  ) / (sum((Data$x_test > quantile(Data$x_test, 0.95))))
LPS_OoS_DPMMEM_5Percent <- 
  - sum((Data$x_test > quantile(Data$x_test, 0.95)) *
          log(pracma::interp1(f_hat_x, f_hat_y, e_hat_test_DPMMEM, method = "linear") / h_hat_test_DPMMEM)
  ) / (sum((Data$x_test > quantile(Data$x_test, 0.95))))

LPS_OoS_GamMEM_1Percent <- 
  - sum((Data$x_test > quantile(Data$x_test, 0.99)) * 
          log(dgamma(e_hat_test_GamMEM, scale = phi_hat_GamMEM, shape = 1/phi_hat_GamMEM) / h_hat_test_GamMEM)
  ) / (sum((Data$x_test > quantile(Data$x_test, 0.99))))
LPS_OoS_DPMMEM_1Percent <- 
  - sum((Data$x_test > quantile(Data$x_test, 0.99)) *
          log(pracma::interp1(f_hat_x, f_hat_y, e_hat_test_DPMMEM, method = "linear") / h_hat_test_DPMMEM)
  ) / (sum((Data$x_test > quantile(Data$x_test, 0.99))))

print(c(paste("LPS 1-Component Gamma:", LPS_OoS_GamMEM),
        paste("LPS DPM (2Params):", LPS_OoS_DPMMEM)))
{
  # Simulations:
  # "LPS 1-Component Gamma: 2.19928391698937" 
  # "LPS DPM (2Params): 2.18494244905579"
}
{
  # Real Data (2,000 - 10,000)
  # [1] "LPS 1-Component Gamma: -0.659579905516504"
  # [2] "LPS DPM (2Params): -0.86569605747502"   
}
{
  # Real data (adapt scale)
  # [1] "LPS 1-Component Gamma: -0.659579905516504"
  # [2] "LPS DPM (2Params): -0.860456623586668" 
}
print(c(paste("LPTS 5% 1-Component Gamma:", LPS_OoS_GamMEM_5Percent),
        paste("LPTS 5% DPM (2Params):", LPS_OoS_DPMMEM_5Percent)))
{
  # Simulations:
  # "LPTS 5% 1-Component Gamma: 5.30846675044928"
  # "LPTS 5% DPM (2Params): 3.78772113861969"
}
{
  # Real Data (2,000 - 10,000)
  # [1] "LPTS 5% 1-Component Gamma: 6.26621351397953"
  # [2] "LPTS 5% DPM (2Params): -0.395298814333303" 
}
{
  # Real data (adapt scale)
  # [1] "LPTS 5% 1-Component Gamma: 6.26621351397953"
  # [2] "LPTS 5% DPM (2Params): -0.389842050655205"
}
print(c(paste("LPTS 1% 1-Component Gamma:", LPS_OoS_GamMEM_1Percent),
        paste("LPTS 1% DPM (2Params):", LPS_OoS_DPMMEM_1Percent)))
{
  # Simulations:
  # "LPTS 1% 1-Component Gamma: 5.633829375406"
  # "LPTS 1% DPM (2Params): 4.92669070471974"  
} 
{
  # Real Data (2,000 - 10,000)
  # [1] "LPTS 1% 1-Component Gamma: 6.36251024457486"
  # [2] "LPTS 1% DPM (2Params): -0.308463574874006"  
}
{
  # Real data (adapt scale)
  # [1] "LPTS 1% 1-Component Gamma: 6.36251024457486"
  # [2] "LPTS 1% DPM (2Params): -0.302851635001576" 
}

# One Step Ahead predictions
library(parallel)
library(doParallel)

N_grid <- 10000
x_grid <- c()
for (i_grid in 1:N_grid)
  x_grid[i_grid] <- c(quantile(x, probs = (i_grid - 1) / N_grid))

registerDoParallel(makeCluster(detectCores()))

system.time(
  pdf_pred_x <- 
    foreach(i = 1:NMCMC1, .combine = "+", .inorder = FALSE, .final = function(x){x/NMCMC1}) %dopar%{
      N_C <- MC[[NBurnIn + NMCMC0 + i]]$N
      if("h" %in% names(MC[[NBurnIn + NMCMC0 + i]])){
        h <- MC[[NBurnIn + NMCMC0 + i]]$h
        h_OSA <- oab_Mapped_MATRIX_trunc[i,1] + 
          oab_Mapped_MATRIX_trunc[i,2]*x[length(x)] + 
          oab_Mapped_MATRIX_trunc[i,3]*h[length(h)]
      }else{
        h <- NaN*x
        h[1] <- mean(x)
        for (t in 2:(length(x)+1)){
          h[t] <- oab_Mapped_MATRIX_trunc[i,1] + 
            oab_Mapped_MATRIX_trunc[i,2]*x[t - 1] + 
            oab_Mapped_MATRIX_trunc[i,3]*h[t - 1]
        }
        h_OSA <- h[length(h)]
      }
      
      pdf_pred_x_par <- 0
      for (j in 1:N_C){
        pdf_pred_x_par <- 
          pdf_pred_x_par + w_matrix[i,j] * dgamma(x_grid, 
                                                  shape = alpha_matrix[i,j], 
                                                  scale = mu_mapped_matrix[i,j] * h_OSA / 
                                                    alpha_matrix[i,j])
      }
      pdf_pred_x_par
    }
)
# user  system elapsed 
# 16.256  13.222  87.179

{
# system.time(for (i in 1:NMCMC1){
#   N_C <- MC[[NBurnIn + NMCMC0 + i]]$N
#   if("h" %in% names(MC[[NBurnIn + NMCMC0 + i]])){
#     h <- MC[[NBurnIn + NMCMC0 + i]]$h
#     h_OSA <- oab_Mapped_MATRIX_trunc[i,1] + 
#       oab_Mapped_MATRIX_trunc[i,2]*x[length(x)] + 
#       oab_Mapped_MATRIX_trunc[i,3]*h[length(h)]
#   }else{
#     h <- NaN*x
#     h[1] <- mean(x)
#     for (t in 2:(length(x)+1)){
#       h[t] <- oab_Mapped_MATRIX_trunc[i,1] + 
#         oab_Mapped_MATRIX_trunc[i,2]*x[t - 1] + 
#         oab_Mapped_MATRIX_trunc[i,3]*h[t - 1]
#     }
#     h_OSA <- h[length(h)]
#   }
#   
#   for (j in 1:N_C){
#     pdf_pred_x <- 
#       pdf_pred_x + w_matrix[i,j] * dgamma(x_grid, 
#                                           shape = alpha_matrix[i,j], 
#                                           scale = mu_mapped_matrix[i,j] * h_OSA / 
#                                             alpha_matrix[i,j])
#   }
# })
# pdf_pred_x <- pdf_pred_x / NMCMC1
}

# Now compute the area under the predictive density (just to verify correctness) and
# the cumulative distribution function of the predictive distribution.

source("R/AucTrap.R"))
AucTrap(x = x_grid, y = pdf_pred_x, dens = 2)
cdf_pred_x <- c()
for(x_lim in 2:length(x_grid)){
  cdf_pred_x <- c(cdf_pred_x,
                  AucTrap(x = x_grid[1:x_lim], y = pdf_pred_x[1:x_lim], dens = 2))
}
# Estimate of the predictive mean
x_grid[max(which(cdf_pred_x <= 0.5))]
# 2.678882

# Predictive 95% intervals
c(x_grid[max(which(cdf_pred_x <= 0.025))],
  x_grid[min(which(cdf_pred_x >= 0.975))])
# 2.559449 2.804790



pdf_pred_df <- data.frame(x_grid, pdf_pred_x)
ggplot(pdf_pred_df, aes(x_grid)) +
  geom_histogram(data = as.data.frame(x), mapping = aes(x = x, y = ..density..)) +
  geom_line(aes(y = pdf_pred_df$pdf_pred_x), colour = "red") +
  geom_vline(aes(xintercept = x_grid[max(which(cdf_pred_x <= 0.5))]), colour = "green") +
  geom_vline(aes(xintercept = x_grid[max(which(cdf_pred_x <= 0.025))]), colour = "orange") +
  geom_vline(aes(xintercept = x_grid[min(which(cdf_pred_x >= 0.975))]), colour = "orange")



### More steps
N_SA <- 10
N_sim <- 1e3

system.time(
list_pred <- 
  foreach(i = 1:NMCMC1, .inorder = FALSE) %dopar%{
    N_C <- MC[[NBurnIn + NMCMC0 + i]]$N
    if("h" %in% names(MC[[NBurnIn + NMCMC0 + i]])){
      h <- MC[[NBurnIn + NMCMC0 + i]]$h
      h_OSA <- oab_Mapped_MATRIX_trunc[i,1] + 
        oab_Mapped_MATRIX_trunc[i,2]*x[length(x)] + 
        oab_Mapped_MATRIX_trunc[i,3]*h[length(h)]
    }else{
      h <- NaN*x
      h[1] <- mean(x)
      for (t in 2:(length(x)+1)){
        h[t] <- oab_Mapped_MATRIX_trunc[i,1] + 
          oab_Mapped_MATRIX_trunc[i,2]*x[t - 1] + 
          oab_Mapped_MATRIX_trunc[i,3]*h[t - 1]
      }
      h_OSA <- h[length(h)]
    }
    pdf_pred_x_par <- 0
    for (j in 1:N_C){
      pdf_pred_x_par <- 
        pdf_pred_x_par + 
        w_matrix[i,j] * dgamma(x_grid, 
                               shape = alpha_matrix[i,j], 
                               scale = mu_mapped_matrix[i,j] * 
                                 h_OSA / alpha_matrix[i,j])
    }
    list(pdf_pred_x_par = pdf_pred_x_par, h_OSA = h_OSA)
  }
)
# user  system elapsed 
# 15.233  12.460  86.041 
pdf_pred_x <- 0
h_OSA_avg <- 0
for(j_pred in 1:length(list_pred)){
  pdf_pred_x <- pdf_pred_x + list_pred[[j_pred]]$pdf_pred_x_par
  h_OSA_avg <- h_OSA_avg + list_pred[[j_pred]]$h_OSA
}
pdf_pred_x <- pdf_pred_x / NMCMC1
h_OSA_avg <- h_OSA_avg / NMCMC1
h <- c(MC[[NBurnIn + NMCMC0 + i]]$h, h_OSA_avg)
cdf_pred_x <- c()
for(x_lim in 2:length(x_grid)){
  cdf_pred_x <- c(cdf_pred_x,
                  AucTrap(x = x_grid[1:x_lim], y = pdf_pred_x[1:x_lim], dens = 2))
}
samp <- x_grid[sapply(runif(N_sim), FUN = function(x){max(which(cdf_pred_x <= x))})]

for(n_sa in 2:N_SA){
  list_pred <- 
    foreach(i = 1:NMCMC1, .inorder = FALSE) %dopar%{
      N_C <- MC[[NBurnIn + NMCMC0 + i]]$N
      h_OSA_temp <- c()
      for (i_h_osa in 1:length(samp)){
        h_OSA_temp <- c(h_OSA_temp, oab_Mapped_MATRIX_trunc[i,1] + 
                          oab_Mapped_MATRIX_trunc[i,2]*samp[i_h_osa] + 
                          oab_Mapped_MATRIX_trunc[i,3]*h[length(h)])
      }
      h_OSA <- mean(h_OSA_temp)
      pdf_pred_x_par <- 0
      for (j in 1:N_C){
        pdf_pred_x_par <- 
          pdf_pred_x_par + 
          w_matrix[i,j] * dgamma(x_grid, shape = alpha_matrix[i,j], 
                                 scale = mu_mapped_matrix[i,j] * 
                                   h_OSA / alpha_matrix[i,j])
      }
      list(pdf_pred_x_par = pdf_pred_x_par, h_OSA = h_OSA)
    }
  pdf_pred_x_temp <- 0
  h_OSA_avg_temp <- 0
  for(j_pred in 1:length(list_pred)){
    pdf_pred_x_temp <- pdf_pred_x_temp + list_pred[[j_pred]]$pdf_pred_x_par
    h_OSA_avg_temp <- h_OSA_avg + list_pred[[j_pred]]$h_OSA
  }
  pdf_pred_x <- cbind(pdf_pred_x, pdf_pred_x_temp / NMCMC1)
  h_OSA_avg <- cbind(h_OSA_avg, h_OSA_avg_temp / NMCMC1)
  h <- c(h, h_OSA_avg[n_sa])
  cdf_pred_x_temp <- c()
  for(x_lim in 2:length(x_grid)){
    cdf_pred_x_temp <- c(cdf_pred_x_temp,
                         AucTrap(x = x_grid[1:x_lim], 
                                 y = pdf_pred_x[1:x_lim, n_sa], dens = 2))
  }
  cdf_pred_x <- cbind(cdf_pred_x, cdf_pred_x_temp)
  samp <- x_grid[sapply(runif(N_sim), FUN = function(x){max(which(cdf_pred_x[,n_sa] <= x))})]
}

output <-
  cbind(apply(cdf_pred_x, MARGIN = 2, FUN = function(x) {x_grid[max(which(x <= 0.025))]}),
        apply(cdf_pred_x, MARGIN = 2, FUN = function(x) {x_grid[max(which(x <= 0.5))]}),
        Data$x_test[1:10],
        apply(cdf_pred_x, MARGIN = 2, FUN = function(x) {x_grid[min(which(x >= 0.975))]}))

plot(output[,2], type = "l", ylab = "", xlab = "Steps Ahead", main = "Predictions",
     ylim = c(min(output), max(output)))
lines(output[,1], col = "red")
lines(output[,4], col = "red")
lines(output[,3], col = "green")
legend("bottomleft", legend = c("Pred","0.025","0.975","True"), 
       col =c("black","red","red","green"),
       lwd = 1, lty = 1, cex = 0.8)
