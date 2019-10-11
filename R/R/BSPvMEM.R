BSPvMEM <- function(x, init_list, eta_TRUE=NULL, Scale1 = 0.5, Scale2 = sqrt(10), p_mixture = 0.9, 
                    eps2 = 1e-6, NTot = 200e3, NBurnIn = 4e3, NMCMC0 = 1e3, NSTEPS = 5e3, 
                    VC_prior_eta_multi = 20, NW_a_add = 10, NW_Winv_multi = 1, NW_n0 = 1, eps_mbar = 1e-6, 
                    kappa = 1.5, alpha = 1, N0_Components = 3, PositiveValues = FALSE, random_seed=NULL){
  #' Fit BSP vMEM
  #'
  #' Fit Bayesian Semiparametric vector Multiplicative Error Model on given data using Monte Carlo Markov Chain
  #' 
  #' @param x input data
  #' @param init_list initialization list. It must have this form:
  #' \item model: list describing the conditional mean model
  #'      \item isdiagB whether or not B is diagonal 
  #'      \item isdiagA whether or not A is diagonal 
  #'      \item isdiagAneg whether or not Aneg is diagonal 
  #'      \item isdiagF whether or not F is diagonal 
  #'      \item isdiagG whether or not G matrices are diagonal 
  #'      \item isdiagGneg whether or not Gneg matrices are diagonal 
  #'      \item x_neg vector of asymmetric returns (min(0, x))
  #'      \item x_lag vector of lagged returns
  #'      \item TimeSteps time steps of period changes
  #' \item params: list of initial values for the parameters. It must be of the form
  #'      \item o: parameter vector of the constant mean term
  #'      \item A: parameter matrix of the 1-lagged observation component
  #'      \item B: parameter matrix of the 1-lagged mean component
  #'      \item Aneg: parameter matrix of the 1-lagged asymmetric observation component
  #'      \item F: parameter matrix of the 2-lagged observation component
  #'      \item G: list of parameter matrices 
  #' \item paramsVC: initial variance-covariance matrix of the parameter vector
  #' \item innovations: vector 
  #' @param Scale
  #' @param eps2
  #' @param NTot total number of MCMC steps
  #' @param NBurnIn size of the burn-in
  #' @param NMCMC0 size of the non adaptive part of the MCMC
  #' @param NSTEPS save outputs every NSTEPS and print intermediate results
  #' @param VC_prior_eta_multi multiplier to be appled to the prior VC init_list$paramsVC
  #' @param NW_a_add additive factor to be added to the initialization of the "a" parameter of the Normal-Wishart
  #' @param NW_Winv_multi multiplier to be applied to the inverse of the W parameter of the Normal-Wishart
  #' @param NW_n0 the "n0" parameter of the Normal-Wishart
  #' @param eps_mbar truncation level to be applied in the compoutation of \bar{m}
  #' @param kappa base used for the xi power series of the slice sampler as defined by Kalli et al. (2011)
  #' @param alpha Dirichlet Process concentration parameter
  #' @param N0_Components initial number of mixture components
  #' @param PositiveValues whether or not restrict contitional mean parameter vector to positve orthant
  #' @param random_seed random seed used for replicability purposes. Saved in first component of MC output
  #' 
  #' @details 
  #' The considered model is a Mulitplicative Error Model with innovations that are 
  #' Dirichlet Process Mixtures of Gammas with two free parameters (DPMG2 MEM)
  #' 
  #' Considering a strictly positive time series x,
  #' 
  #' x_t = h_t * e_t
  #' e_t ~ DPM( DP concetration = M, 
  #'            mixture components = LogNormal()) 
  #' h(t) = o + b * h(t-1) + a * x(t-1)
  #' 
  
  source("R/Utils.R")
  source("R/vMEMh.R")
  source("R/vMEMFullCond.R")
  source("R/SampleSteps.R")
  
  TT <- dim(x)[1]
  pb <- tcltk::tkProgressBar(max = NTot)
  
  eta_INIT <- .checkParams(init_list$params)
  h_MLE <- vMEMh(x=x, eta=eta_INIT, h_1=colMeans(x), model=init_list$model);
  
  set.seed(random_seed)
  
  y <- x/h_MLE
  dim_y <- dim(y)[2]
  y_log <- log(y)
  
  VC_BurnIn <- init_list$paramsVC
  LAMBDA <- VC_BurnIn
  
  NMCMC1 <- NTot - NBurnIn - NMCMC0
  
  if ((NBurnIn + NMCMC0) %% (NSTEPS) != 0)
    stop('NBurnIn + NMCMC0 must be a multiple of NSTEPS')
  
  # VC of the Truncated Normal prior on the vector of parameters, eta:
  VC_prior_eta <- VC_prior_eta_multi * diag(diag(init_list$paramsVC))
  Mean_prior_eta <- rep(0, length(eta_INIT))
  
  # Hyperparameters N-W Disribution
  NW_a <- dim_y + NW_a_add
  NW_Winv <- NW_Winv_multi * diag(apply(y_log, MARGIN=2, FUN=var))
  NW_W <- solve(NW_Winv)
  NW_mu <- colMeans(y_log)
  
  # Hyperparameters:
  xi <- (alpha / (kappa * (1 + alpha))) ^ (1:1e3) * 1/alpha
  
  # Initialization of d
  d <- floor(N0_Components * runif(TT)) + 1
  
  # Initialization of eta
  eta <- eta_INIT
  len_eta <- length(eta)
  
  # Pre-allocation of storage matrices
  ALL_PROB_eta <- rep(0, NBurnIn + NMCMC0 + NMCMC1)
  
  # Saving every NSTEPS
  MC <- list()
  eta_matrix <- matrix(NaN, NSTEPS, len_eta)
  eta_Mapped_MATRIX <- matrix(NaN, NSTEPS, len_eta)
  
  # 1) Sampling u:[required d]
  futile.logger::flog.info("Sampling u")
  u_list <- .sample_u(xi, d, alpha)
  
  # 2) Sampling v : [required: d through n_vec and n_vec2]
  futile.logger::flog.info("Sampling w")
  w <- .sample_w(u_list, alpha)
  
  # 3) Sampling [mu, Tau]
  futile.logger::flog.info("Sampling mu and Tau")
  muSigma <- .sample_muTauSigma(u_list$n_vec, y_log, d, NW_a, NW_W, NW_Winv, NW_mu, NW_n0)
  
  # calculating m_bar, necessary for the post-processing transformation
  futile.logger::flog.debug("Calculating mbar")
  mbar <- .update_mbar(w, muSigma, eps_mbar, NW_a, NW_W, NW_mu, NW_n0, alpha)
  
  diagSigma <- diagarray(muSigma$Sigma[,,1:length(w)])
  h_1 <- colMeans(x) / rowMeans(exp(muSigma$mu[,d] + 0.5*diagSigma[,d]))
  h <- vMEMh(x = x, eta = eta, h_1 = h_1, model = model)
  y <- x / h
  y_log <- log(y)
  
  # 4) Sampling d [required: u, w, xi, muSigma]
  futile.logger::flog.info("Sampling d")
  d <- .sample_d(y, u_list$u, w, xi, muSigma)

  h_1 <- colMeans(x) / rowMeans(exp(muSigma$mu[,d] + 0.5*diagSigma[,d]))
  PostProc <- .postProcessing(mbar, len_eta, model$isdiagB)
  
  # 5) Sampling eta = vec(o, B, A) 
  futile.logger::flog.info("Sampling eta")
  eta_prop <- as.vector(mvtnorm::rmvnorm(1, eta, VC_BurnIn))
                                        
  if (min(eta_prop) >= 0){
    curr <- vMEMFullCond(eta, d, muSigma, x, Mean_prior_eta, VC_prior_eta, h_1, PositiveValues, model)
    prop <- vMEMFullCond(eta_prop, d, muSigma, x, Mean_prior_eta, VC_prior_eta, h_1, PositiveValues, model)
    prob_acc <- min(1, exp(prop$LogPost - curr$LogPost))
  }else{
    prob_acc <- 0
  }
  ALL_PROB_eta[1] <- prob_acc
  if (runif(1) < prob_acc){
    eta <- eta_prop
    h <- prop$h
  }
  
  eta_matrix[1,] <- eta
  eta_Mapped <- eta * PostProc
  eta_Mapped_MATRIX[1,] <- eta_Mapped 
  eta_MEAN <- eta_Mapped
  
  y <- x / h
  y_log <- log(y)
  
  futile.logger::flog.info("Saving results for step 1")
  MC[[1]] <- list()
  MC[[1]]$N <- u_list$N
  MC[[1]]$w <- w
  MC[[1]]$mu <- muSigma$mu
  MC[[1]]$Sigma <- muSigma$Sigma
  MC[[1]]$mbar <- mbar
  MC[[1]]$d <- d
  MC[[1]]$eta_prop <- eta_prop
  MC[[1]]$h_1 <- h_1
  MC[[1]]$seed <- random_seed
  
  u_MH_ETA <- runif(NBurnIn + NMCMC0 + NMCMC1)
  
  for (t in 2:(NBurnIn + NMCMC0 + NMCMC1)){
    futile.logger::flog.debug("Step: %s", as.character(t))
    
    if (exists(".Random.seed", .GlobalEnv)){
      random_seed <- .GlobalEnv$.Random.seed
    }else{
      random_seed <- NULL
    }
    # 1) Sampling u:[required d]
    futile.logger::flog.info("Sampling u")
    u_list <- .sample_u(xi, d, alpha)

    # 2) Sampling w
    futile.logger::flog.info("Sampling w")
    w <- .sample_w(u_list, alpha)
    
    # 3) Sampling mu, Tau
    futile.logger::flog.info("Sampling mu and Tau")
    muSigma <- .sample_muTauSigma(u_list$n_vec, y_log, d, NW_a, NW_W, NW_Winv, NW_mu, NW_n0)
    
    # Updating m_bar, necessary for the post-processing transformation
    futile.logger::flog.debug("Updating mbar")
    mbar <- .update_mbar(w, muSigma, eps_mbar, NW_a, NW_W, NW_mu, NW_n0, alpha)

    # Updating conditional mean and innovation vectors
    diagSigma <- diagarray(muSigma$Sigma[,,1:length(w)])
    h_1 <- colMeans(x) / rowMeans(exp(muSigma$mu[,d] + 0.5*diagSigma[,d]))
    h <- vMEMh(x = x, eta = eta, h_1 = h_1, model = model)
    y <- x / h
    y_log <- log(y)

    # 4) Sampling d [required: u, w, xi, muSigma]
    futile.logger::flog.info("Sampling d")
    d <- .sample_d(y, u_list$u, w, xi, muSigma)

    h_1 <- colMeans(x) / rowMeans(exp(muSigma$mu[,d] + 0.5*diagSigma[,d]))
    PostProc <- .postProcessing(mbar, len_eta, model$isdiagB)
                                      
    # 5) Sampling eta (RW-MH)
    futile.logger::flog.info("Sampling eta using RW-MH")
    # In the first NBurnIn + NMCMC0 iterations we use a Normal proposal with
    # VC_BurnIn = VC_MLE1(parametri)
    # In the further NMCMC1 iteratioms we use an adaptive Normal poposal with
    # VC = EmpVC of all the past mapped (identifiable) params .* inverse-mapping transf.

    if (t == (NBurnIn + NMCMC0)){
      futile.logger::flog.debug("t == %i", (NBurnIn + NMCMC0))
      if((NBurnIn + NMCMC0) > NSTEPS){
        eta_Mapped_MATRIX_TEMP <- matrix(NaN, NBurnIn + NMCMC0 - 1, len_eta)
        for (j in 1:((NBurnIn + NMCMC0)/NSTEPS - 1)){
          futile.logger::flog.debug('Retrieving %s-th temp file', as.character(j))
          filenameLoad <- paste0('data/Temp/Output_', j*NSTEPS, '.RData')
          load(filenameLoad)
          eta_Mapped_MATRIX_TEMP[((j-1)*NSTEPS + 1):(j*NSTEPS),] <- TEMP$eta_Mapped_MATRIX
        }
        eta_Mapped_MATRIX_TEMP[(j*NSTEPS+1):nrow(eta_Mapped_MATRIX_TEMP),] <- eta_Mapped_MATRIX[1:(nrow(eta_Mapped_MATRIX)-1),]
      }else{
        eta_Mapped_MATRIX_TEMP <- eta_Mapped_MATRIX
      }
      Stm1 <- cov(eta_Mapped_MATRIX_TEMP[(NBurnIn+1):(t-1),])
      mtm1 <- colMeans(eta_Mapped_MATRIX_TEMP[(NBurnIn+1):(t-1),])
      mtm2 <- colMeans(eta_Mapped_MATRIX_TEMP[(NBurnIn+1):(t-2),])
      rm(TEMP, eta_Mapped_MATRIX_TEMP)
    }
    if (t <= NBurnIn + NMCMC0){
      futile.logger::flog.debug("t <= %i", (NBurnIn + NMCMC0))
      LAMBDA <- VC_BurnIn
    }else{
      futile.logger::flog.debug("t > %i", (NBurnIn + NMCMC0))
      Stm2 <- Stm1
      xtm1 <- eta_Mapped
      mtm2 <- mtm1
      mtm1 <- (t - NBurnIn - 2) / (t - NBurnIn - 1) * mtm2 + 1 / (t - NBurnIn - 1) * xtm1
      Stm1 <- (t - NBurnIn - 3) / (t - NBurnIn - 2) * Stm2 + 
        t(t(mtm2)) %*% t(mtm2) - 
        (t - NBurnIn - 1) / (t - NBurnIn - 2) * (t(t(mtm1)) %*% t(mtm1)) + 
        1 / (t - NBurnIn - 2) * (t(t(xtm1)) %*% t(xtm1))
      Stm1 <- (Stm1 + t(Stm1)) / 2
      if (min(eig(Stm1)) < 0){Stm1 <- Stm2}
      LAMBDA <- Stm1 / (t(t(PostProc)) %*% t(PostProc)) + eps2 * diag(len_eta)
    }

    ## Mixture Proposal ##

    if (runif(1) < p_mixture){
      eta_prop <- as.vector(mvtnorm::rmvnorm(1, eta, LAMBDA * (Scale1)^2 / len_eta))
    }else{
      eta_prop <- as.vector(mvtnorm::rmvnorm(1, eta, LAMBDA * (Scale2)^2 / len_eta))
    }
                                      
    ## Standard Propposal ##
    # eta_prop = mvnrnd(eta, LAMBDA * (Scale)^2 / len_eta)';
    
    curr <- vMEMFullCond(eta=eta, d=d, muSigma=muSigma, x=x, Mean_prior=Mean_prior_eta, 
                         VC_prior=VC_prior_eta, h_1=h_1, Pos=PositiveValues, model=model)
    prop <- vMEMFullCond(eta=eta_prop, d=d, muSigma=muSigma, x=x, Mean_prior=Mean_prior_eta, 
                         VC_prior=VC_prior_eta, h_1=h_1, Pos=PositiveValues, model=model)
    prob_acc <- min(1, exp(prop$LogPost - curr$LogPost))
    
    ALL_PROB_eta[t] <- prob_acc
    if (u_MH_ETA[t] < prob_acc){
      eta <- eta_prop
      h <- prop$h
    }
    
    # if (t < NBurnIn + NMCMC0)
    #     eta_Mapped_MATRIX[t, ] = eta_Mapped'
    
    save_step <- (t-1) %% NSTEPS + 1
    
    futile.logger::flog.info("Saving results for step %s", as.character(t))
    
    eta_matrix[save_step,] <- eta
    eta_Mapped <- eta * PostProc
    eta_Mapped_MATRIX[save_step,] <- eta_Mapped 
    eta_MEAN <- (eta_Mapped + (t-1) * eta_MEAN) / t
    
    y <- x / h
    y_log <- log(y)
    
    MC[[save_step]] <- list()
    MC[[save_step]]$N <- u_list$N
    MC[[save_step]]$w <- w
    MC[[save_step]]$mu <- muSigma$mu
    MC[[save_step]]$Sigma <- muSigma$Sigma
    MC[[save_step]]$mbar <- mbar
    MC[[save_step]]$d <- d
    MC[[save_step]]$eta_prop <- eta_prop
    MC[[save_step]]$h_1 <- h_1
    MC[[save_step]]$seed <- random_seed
  
    # Save and plot
    if ((t %% NSTEPS) == 0){
      
      # save temporary result
      if (!dir.exists('data/Temp'))
        dir.create('data/Temp', recursive = TRUE)
      
      filename <- paste0('data/Temp/Output_',t,'.RData')
      TEMP <- list(eta_Mapped_MATRIX=eta_Mapped_MATRIX, MC=MC, eta_matrix=eta_matrix)
      save(TEMP, file=filename)
      
      tcltk::setTkProgressBar(pb,t,paste(t,"of",NTot))
      cat("\014")  # Clean the console
      
      # Time_Elapsed = toc(t_start);
      # Time_Remained = Time_Elapsed / t * (NBurnIn + NMCMC0 + NMCMC1 - t);
      # disp('************************************************')
      # disp(['Simulation ends at: ' datestr(now + Time_Remained / 60 / 60 / 24)])
      # disp('************************************************')
      
      ###
      if(!is.null(eta_TRUE)){
      futile.logger::flog.info('INIT: %s \nMCMC:%s \nTRUE:%s', 
                               as.character(eta_INIT), as.character(eta_MEAN), as.character(eta_TRUE))
      }else{
        futile.logger::flog.info('INIT: %s \nMCMC:%s', 
                                 as.character(eta_INIT), as.character(eta_MEAN))
      }
      
      ###
      if (t > (NBurnIn+NMCMC0)){
        futile.logger::flog.info('mbar: %s \nTotal A.R.: %s \nAdaptive A.R.', 
                                 as.character(mbar), 
                                 as.character(mean(ALL_PROB_eta[1:t])), 
                                 as.character((mean(ALL_PROB_eta[(NBurnIn+NMCMC0):t]))))
      }else{
        futile.logger::flog.info('mbar: %s \nTotal A.R.: %s', 
                                 as.character(mbar), 
                                 as.character(mean(ALL_PROB_eta[1:t])))
      }
      
      # We need a plot for every parameter to see how it varies through
      # the iterations:
      dim_x <- dim(x)[2]
      
      par(mfrow=c(dim_x, 1))
      for (i in (1:dim_x)){
        plot((max(1, t - NSTEPS + 1)):t, eta_Mapped_MATRIX[,i])
        # plot.window(xlim=c(max(1, t - NSTEPS + 1),t), 
        #             ylim=c(min(eta_Mapped_MATRIX[,i]), max(eta_Mapped_MATRIX[,i])))
      }
      
      par(mfrow=c(dim_x^2, 1))
      for (i in 1:(dim_x^2)){
        plot((max(1, t - NSTEPS + 1)):t, eta_Mapped_MATRIX[, dim_x + i]);
        # plot.window(xlim=c(max(1, t - NSTEPS + 1),t), 
        #             ylim=c(min(eta_Mapped_MATRIX[, dim_x + i]),
        #                    max(eta_Mapped_MATRIX[, dim_x + i])))
      }
      
      par(mfrow=c(dim_x^2, 1))
      for (i in 1:(dim_x^2)){
        plot((max(1, t - NSTEPS + 1)):t, eta_Mapped_MATRIX[, size(x,1) + size(x,1)^2 + i])
        # plot.window(xlim=c(max(1, t - NSTEPS + 1),t),
        #             ylim=c(min(eta_Mapped_MATRIX[, size(x,1) + size(x,1)^2 + i]),
        #                    max(eta_Mapped_MATRIX[, size(x,1) + size(x,1)^2 + i])))
      }
      
      #figure(4)
      #for i = 1:size(x,1)^2
      #    subplot(size(x,1)^2,1,i)
      #    plot((max(1, t - NSTEPS + 1)):t, eta_Mapped_MATRIX(:, size(x,1) + 2*size(x,1)^2 + i));
      #    xlim([(max(1, t - NSTEPS + 1)) t])
      #end
      
    }
  }
  
  return(list(MC=MC, eta_mapped_mat=eta_Mapped_MATRIX, eta_matrix=eta_matrix))
}
  
  ###########################################
  ### The simulation is finished:         ###
  ### execute Graphs.m to get the graphs  ###
  ###########################################