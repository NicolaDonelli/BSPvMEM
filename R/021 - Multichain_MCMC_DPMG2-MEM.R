library(chron)
library(zoo)
library(dplyr)
library(mvtnorm)
library(coda)
library(pracma)
library(ggplot2)
library(parallel)
library(doParallel)

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
load("~/Documents/BSP vMEM Research Proposal/Programs/R/HHSqrtPrices_v2.RData")
# Heny-Hub daily log prices
# load("~/Documents/BSP vMEM Research Proposal/Programs/R/HHLogPrices_v1.RData")

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

NBurnIn <- 1e3
NMCMC0  <- 1e3
NMCMC1  <- 1e4

registerDoParallel(makeCluster(detectCores()))
chains <- 
  foreach(i = 1:4, .inorder =  FALSE,
          .packages = c("matlab","mvtnorm"), 
          .export = c("Gamma2ParamMode","Gamma2Param_hprime","Gamma2Param_h",
                      "MEMFullCond","MEM_h","GradientFullCond")) %dopar% 
  {
    MC <- NULL
    NBurnIn <- 1e3
    NMCMC0  <- 1e3
    NMCMC1  <- 1e4
    NPlot <- 1e2
    NPlotWindow <- 4e3
    NAdapt <- 1e2
    
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
    oab <- c(MLE$o_MEM_MLE, MLE$a_MEM_MLE, MLE$b_MEM_MLE) * (1 + 0.2 * (2 * runif(3) - 1))
    # oab <- c(0.1, 0.8, 0.1)
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
    n_vec <- colSums(matrix(rep(d,N), nrow = n) == matrix(rep(1:N, n), nrow = n, byrow = T))
    n_vec2 <- colSums(matrix(rep(d,N), nrow = n) > matrix(rep(1:N, n), nrow = n, byrow = T))
    
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
    p01 <- (matrix(rep(xi[1:N],n), nrow = N) > matrix(rep(u,N),nrow = N, byrow = T)) *
      matrix(rep(w,n),nrow = N)/matrix(rep(xi[1:N],n),nrow = N)
    p02 <- dgamma(matlab::reshape(matrix(rep(y, N), nrow = N, byrow = T), N*n,1), 
                  shape = matlab::reshape(matrix(rep(alpha, n), nrow = N), N*n,1),
                  scale = matlab::reshape(matrix(rep(mu, n), nrow = N), N*n,1) / 
                    matlab::reshape(matrix(rep(alpha, n), nrow = N), N*n,1))
    p0 <- p01 * matlab::reshape(p02, N, n)
    p <- p0 / matrix(rep(colSums(p0),N), nrow = N, byrow = T)
    q <- apply(p, MARGIN = 2, FUN = cumsum)
    
    d <- 1 + colSums(rep(runif(n), ncol = N, byrow = T) > q)
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
    
    for (t in 2:(NBurnIn + NMCMC0 + NMCMC1)){
      # 1) Sampling u
      u <- xi[d] * runif(n)
      # MC[[t]]$u <- u
      N <- floor(log(min(u * M)) / log((M / (kappa * (1 + M)))))
      # N <- floor(log(min(u * M0)) / log((M0 / (kappa * (1 + M0)))))
      MC <- append(MC, list(list(N = N)))
      # vector of nj values
      n_vec <- colSums(matrix(rep(d,N), ncol = N) == matrix(rep(1:N, n), ncol = N, byrow = T))
      n_vec2 <- colSums(matrix(rep(d,N), ncol = N) > matrix(rep(1:N, n), ncol = N, byrow = T))
      
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
      p01 <- (matrix(rep(xi[1:N],n), nrow = N) > matrix(rep(u,N),nrow = N, byrow = T)) *
        matrix(rep(w,n),nrow = N) / matrix(rep(xi[1:N],n),nrow = N)
      p02 <- dgamma(matlab::reshape(matrix(rep(y, N), nrow = N, byrow = T), N*n,1),
                    shape = matlab::reshape(matrix(rep(alpha, n), nrow = N), N*n,1),
                    scale = matlab::reshape(matrix(rep(mu, n), nrow = N), N*n,1) /
                      matlab::reshape(matrix(rep(alpha, n), nrow = N), N*n,1))
      p0 <- p01 * matlab::reshape(p02, N, n)
      p <- p0 / matrix(rep(colSums(p0),N), nrow = N, byrow = T)
      q <- apply(p, MARGIN = 2, FUN = cumsum)
      
      d <- 1 + colSums(rep(runif(n), ncol = N, byrow = T) > q)
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
          if (min(eigen(Stm1, only.values = T)$values) < 0){
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
        #   if (min(eigen(Stm1, only.values = T)$values) < 0){
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
    }
    list(MC = MC, oab_Mapped_MATRIX = oab_Mapped_MATRIX, oab_Est = oab_MEAN)
  }

#### Convergence Diagnostics ####
oab_Mapped_list <- list() 
oab_Mapped_chains <- list()
for (i in 1:length(chains)){
  oab_Mapped_list[[i]] <- chains[[i]]$oab_Mapped_MATRIX
  oab_Mapped_chains[[i]] <- mcmc(chains[[i]]$oab_Mapped_MATRIX, 
                                 start = NBurnIn + NMCMC0 + 1, end = NBurnIn + NMCMC0 + NMCMC1, thin = 1)
}
chain_list <- mcmc.list(oab_Mapped_chains)
plot(chain_list, trace = TRUE, density = TRUE, smooth = TRUE, auto.layout = TRUE)

summary(chain_list, quantiles = c(0.025, 0.25, 0.5, 0.75, 0.975))
autocorr(chain_list, lags = c(0, 1, 5, 10, 50), relative=TRUE)
autocorr.plot(chain_list, lags = c(0, 1, 5, 10, 50), relative=TRUE)

effectiveSize(chain_list)
# var1      var2      var3 
# 2595.6184  357.5051  335.3150 
