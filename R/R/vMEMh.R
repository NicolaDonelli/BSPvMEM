vMEMh <- function(x, eta, h_1, model){
  
  #' Conditional mean of vMEM
  #'
  #' Computes the time series of the conditional mean for vector Multiplicati Error Model
  #' 
  #' @param x d * T vector of data
  #' @param eta is a vector that contains in this order (if present)
  #'                - omega (d*1 vector)
  #'                - B (d*d matrix or d*1 vector)
  #'                - A (d*d matrix or d*1 vector)
  #'                - Aneg (d*d matrix or d*1 vector)
  #'                - F (d*d matrix or d*1 vector)
  #'                - K (d*l matrix)
  #'                - G (d*d*l array or d*l matrix)
  #'                - Gneg (d*d*l array or d*l matrix)
  #'                  WHERE MATRICES AND ARRAYS ARE VECTORIZED BY COLUMN
  #' @param h_1 d*1 vector of initial values of h
  #' @param model list describing the conditional mean model. It must contain:
  #'      \item isdiagB whether or not B is diagonal 
  #'      \item isdiagA whether or not A is diagonal 
  #'      \item isdiagAneg whether or not Aneg is diagonal 
  #'      \item isdiagF whether or not F is diagonal 
  #'      \item isdiagG whether or not G matrices are diagonal 
  #'      \item isdiagGneg whether or not Gneg matrices are diagonal 
  #'      \item x_neg vector of asymmetric returns (min(0, x))
  #'      \item x_lag vector of lagged returns
  #'      \item TimeSteps time steps of period changes
  #' 
  #' @return d*TT matrix of conditional means
  #' @export
  
  source("R/Utils.R")
  
  if (!is.matrix(x)){
    stop('The first argument, x, must be a numerical matrix.')
  }else if (dim(x)[2] > dim(x)[1]){
    stop('There must be more observations than variables.')
  }
  
  TT <- dim(x)[1]
  d <- dim(x)[2]
  
  if (!is.vector(eta))
    stop('The second argument, eta, must be a numerical vector.')

  if (!is.vector(h_1)){
    stop('The third argument, h_1, must be a numerical vector.')
  }else if (length(h_1) != d){
    stop('Dimensions of h_1 do not match dimensions of x.')
  }
  
  # Check model
  model <- .checkModel(model)
    
  TimeSteps <- c(0, model$TimeSteps, TT)
  x_neg <- model$x_neg
  x_lag <- model$x_lag
  isdiagB <- model$isdiagB
  isdiagA <- model$isdiagA
  isdiagAneg <- model$isdiagAneg
  isdiagF <- model$isdiagF
  isdiagG <- model$isdiagG
  isdiagGneg <- model$isdiagGneg
  l <- length(TimeSteps)

  h <- NaN * x
  h[1,] <- h_1
  
  mat_list <- .eta2matrices(model, eta, d, TT)
  
  if (is.null(x_neg)){
    x_neg <- 0 * x
  }
  if (is.null(x_lag)){
    x_lag <- 0 * x
  }
  
  for (j in 1:(l-1)){
    if (j==1){
      for (t in 2:TimeSteps[2])
        h[t,] <- mat_list$omega +
          mat_list$B %*% h[t - 1,] +
          mat_list$A %*% x[t - 1,] +
          mat_list$Aneg %*% x_neg[t - 1,] +
          mat_list$F %*% x_lag[t - 1,]
    }else{
      for (t in (TimeSteps[j]+1):TimeSteps[j+1])
        h[t,] <- mat_list$omega +
          mat_list$B %*% h[t - 1,] +
          mat_list$A %*% x[t - 1,] +
          mat_list$Aneg %*% x_neg[t - 1,] +
          mat_list$F %*% x_lag[t - 1,] +
          mat_list$K[,j - 1] +
          mat_list$G[,,j - 1] %*% x[t - 1,] +
          mat_list$Gneg[,,j - 1] %*% x_neg[t - 1,]
    }
  }
  
  return(h)
}
