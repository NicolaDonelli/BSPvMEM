.checkParams <- function(param_list){
  #' Check input list
  #' 
  #' Check parameter list and return vector of parameters in the correct order
  
  if (!all(hasName(param_list, c("o", "A", "B"))))
    stop("o, A and B must be in params_list")
  
  dim_y <- length(param_list$o)
  
  # we need max(...,0) because dim(param_list$A)[1] would return a NULL if param_list$A is a vector 
  # or it does not exist and thus we would get a logical(0) instead of a 0
  
  if (!(length(param_list$A) == dim_y | max(dim(param_list$A)[1], 0) == dim_y)) 
    stop("A must be either a square matrix of size length(o) or a vector of the same length as o")
  
  if (!(length(param_list$B) == dim_y | max(dim(param_list$B)[1], 0) == dim_y))
    stop("B must be either a square matrix of size length(o) or a vector of the same length as o")
  
  if (hasName(param_list, "Aneg") & !(length(param_list$Aneg) == dim_y | max(dim(param_list$Aneg)[1],0) == dim_y))
    stop("If present, Aneg must be either a square matrix of size length(o) or a vector of the same length as o")
  
  if (hasName(param_list, "F") & !(length(param_list$F) == dim_y | max(dim(param_list$F)[1], 0) == dim_y))
    stop("If present, F must be either a square matrix of size length(o) or a vector of the same length as o")
  
  if (hasName(param_list, "K") & !(length(param_list$K) == dim_y | max(dim(param_list$K)[1], 0) == dim_y))
    stop("If present, F must be either a matrix with the first dimension length(o) or a vector of the same length as o")
  
  if (hasName(param_list, "G") & 
      !(length(dim(param_list$G)) == 2 & max(dim(param_list$G)[1],0) == dim_y) & 
      !(length(dim(param_list$G)) == 3 & all((dim(param_list$G) == dim_y)[1:2])))
    stop("If present, G must be either a matrix with the first dimension length(o) or an array with the first two dimensions the same as length(o)")
  
  if (hasName(param_list, "Gneg") & 
      !(length(dim(param_list$Gneg)) == 2 & max(dim(param_list$Gneg)[1], 0) == dim_y) & 
      !(length(dim(param_list$Gneg)) == 3 & all((dim(param_list$Gneg) == dim_y)[1:2])))
    stop("If present, Gneg must be either a matrix with the first dimension length(o) or an array with the first two dimensions the same as length(o)")
  
  return(c(as.vector(param_list$o), as.vector(param_list$B), as.vector(param_list$A), as.vector(param_list$Aneg), as.vector(param_list$F), as.vector(param_list$K), as.vector(param_list$G), as.vector(param_list$Gneg)))
}

.checkModel <- function(model, d , TT){
  #' Check model list
  #' 
  #' Model list must have the subsequent form:
  #' 
  #' @param model: list that contains the specification of the conditional mean
  #'      \item isdiagB whether or not B is diagonal 
  #'      \item isdiagA whether or not A is diagonal 
  #'      \item isdiagAneg whether or not Aneg is diagonal 
  #'      \item isdiagF whether or not F is diagonal 
  #'      \item isdiagG whether or not G matrices are diagonal 
  #'      \item isdiagGneg whether or not Gneg matrices are diagonal 
  #'      \item x_neg vector of asymmetric returns (min(0, x))
  #'      \item x_lag vector of lagged returns
  #'      \item TimeSteps time steps of period changes
  #' @param d data vector dimension
  #' @param TT time series length

  if (!is.list(model)){
    stop('model must be a list')
  }else if (!all(hasName(model, c('isdiagB', 'isdiagA', 'isdiagAneg', 'isdiagF', 'isdiagG', 'isdiagGneg', 
                                  'x_lag', 'x_neg', 'TimeSteps')))) {
    stop('model misses some required field.')
  }else{
    if (is.null(model$TimeSteps)){
      model$isdiagG <- FALSE
      model$isdiagGneg <- FALSE
    }else{ 
      if (!(is.vector(model$TimeSteps) || length(model$TimeSteps) > TT || 
            max(model$TimeSteps) >= TT || min(model$TimeSteps) <= 0))
        stop('TimeSteps is misspecified.')
      
      model$TimeSteps <- sort(model$TimeSteps, decreasing = FALSE)
    }
    
    if (!is.logical(model$isdiagB) || !is.logical(model$isdiagA) || 
        !is.logical(model$isdiagAneg) || !is.logical(model$isdiagF) || 
        !is.logical(model$isdiagG) || !is.logical(model$isdiagGneg)){
      stop('isdiagB, isdiagA, isdiagAneg, isdiagF, isdiagG, isdiagGneg must be logical')
    }
    
    if (!is.null(model$x_lag)){
      if (is.matrix(model$x_lag)){
        stop('x_lag must be a numerical matrix.')
      }else if (any(dim(model$x_lag) != dim(x))){
        stop('x_lag must have the same shape as x.')
      }else if (any(model$x_lag[1,] != rep(0, dim(x)[2]))){
        stop('x_lag[1,] must contain only zeros.')
      }
    }
    
    if(!is.null(model$x_neg)){
      if (is.matrix(model$x_neg)){
        stop('x_neg must be a numerical matrix.')
      }else if (any(dim(model$x_neg) != dim(x))){
        stop('x_neg must have the same shape as x.')
      }
    }
  }
  return(model)
}

.checkSizes <- function(model, eta, dim_x, addenda=0, prefix=NULL){
  
  if (!model$isdiagB & !model$isdiagA) {# both complete
    if (length(eta) != dim_x + 2*dim_x^2 + addenda)
      stop(prefix,'1 - Eta is too long/short.')
  }else if (model$isdiagB & !model$isdiagA) {# B diagonal A complete
    if (length(eta) != 2*dim_x + dim_x^2 + addenda)
      stop(prefix,'2 - Eta is too long/short.')
  }else if (!model$isdiagB & model$isdiagA) {# B complete A diagonal
    if (length(eta) != 2*dim_x + dim_x^2 + addenda)
      stop(prefix,'3 - Eta is too long/short.')
  }else {# both diagonal
    if (length(eta) != 3*dim_x + addenda)
      stop(prefix,'4 - Eta is too long/short.')
  }
}

.eta2matrices <- function(model, eta, dim_x, TT){
  #' Calculate parameter matrices from parameter vector
  #' 
  #' @param model list specifying the conditional mean formulation
  #' @param eta conditional mean parameter vector
  #' @param dim_x dimension of the observations
  #' @param TT length of the observations vector
  #' 
  #' @return list of conditional mean parameters in matrix form
  #'        list(omega=omega, B=B, A=A, Aneg=Aneg, F=F, K=get0("K"), G=get0("G"), Gneg=get0("Gneg"))
  
  TimeSteps <- model$TimeSteps
  x_neg <- model$x_neg
  x_lag <- model$x_lag
  isdiagB <- model$isdiagB
  isdiagA <- model$isdiagA
  isdiagAneg <- model$isdiagAneg
  isdiagF <- model$isdiagF
  isdiagG <- model$isdiagG
  isdiagGneg <- model$isdiagGneg
  l <- length(TimeSteps)
  
  omega <- eta[1:dim_x]
  len_eta <- length(eta)
  
  if (!isdiagB & !isdiagA){ # both complete
    B <- matrix(eta[(dim_x + 1) : (dim_x + dim_x^2)],dim_x,dim_x)
    A <- matrix(eta[(dim_x + dim_x^2 + 1) : (dim_x + 2*dim_x^2)],dim_x,dim_x)
  }
  else if (isdiagB & !isdiagA){ # B diagonal A complete
    B <- diag(eta[(dim_x + 1) : (2*dim_x)])
    A <- matrix(eta[(2*dim_x + 1) : (2*dim_x + dim_x^2)],dim_x,dim_x)
  }
  else if (!isdiagB & isdiagA){ # B complete A diagonal
    B <- matrix(eta[(dim_x + 1) : (dim_x + dim_x^2)],dim_x,dim_x)
    A <- diag(eta[(dim_x + dim_x^2 + 1) : (2*dim_x + dim_x^2)])
  }
  else{ # both diagonal
    B <- diag(eta[(dim_x + 1) : (2*dim_x)])
    A <- diag(eta[(2*dim_x + 1) : (3*dim_x)])
  }
  
  if (is.null(x_lag) & is.null(x_neg) & is.null(TimeSteps)){
    .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = 0, prefix = "1.")
    # for (t in 2:TT){
    #   h[t,] <- omega + B %*% h[t - 1,] + A %*% x[t - 1,]
    # }
  }else if (is.null(x_neg) & is.null(x_lag) & !is.null(TimeSteps)){
    if (!isdiagG){
      .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = (l)*dim_x + (l)*dim_x^2, prefix = "2.")
      G <- array(eta[(len_eta - (l)*dim_x^2 + 1) : (len_eta)], dim=c(dim_x,dim_x,l))
      K <- matrix(eta(len_eta - (l)*dim_x^2 - (l)*dim_x + 1 : len_eta  - (l)*dim_x^2), dim_x, l)
    }else{
      .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = (l)*dim_x + (l)*dim_x, prefix = "3.")
      G <- array(apply(matrix(eta[(len_eta - (l)*dim_x + 1) : len_eta], dim_x,l), MARGIN = 2, FUN=diag),
                 dim=c(dim_x,dim_x,l))
      K <- matrix(eta[(len_eta - (l)*dim_x - (l)*dim_x + 1) : (len_eta  - (l)*dim_x)], dim_x,l)
    }
    # for (j in 1:l){
    #   if (j==1){
    #     for (t in 2:TimeSteps[2])
    #       h[t,] <- omega + B %*% h[t - 1,] + A %*% x[t - 1,]
    #   }else{
    #     for (t in (TimeSteps[j]+1):TimeSteps[j+1])
    #       h[t,] <- omega + B %*% h[t - 1,] + A %*% x[t - 1,] + K[,j - 1] + G[,,j - 1] %*% x[t - 1,]
    #   }
    # }
  }else if (is.null(x_neg) & is.null(TimeSteps) & !is.null(x_lag)){
    if (isdiagF){
      .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x, prefix = "4.")
      F <- diag(eta[(len_eta - dim_x + 1) : len_eta])
    }else{
      .checkSizes(model = model, eta = eta, dim_x = dim_x^2, addenda = dim_x, prefix = "5.")
      F <- matrix(eta[(len_eta - dim_x^2 + 1) : len_eta], dim_x, dim_x)
    }
    # for (t in 2:TT)
    #   h[t,] <- omega + B %*% h[t - 1,] + A %*% x[t - 1,] + F %*% x_lag[t - 1,]
  }else if (is.null(x_lag) & is.null(TimeSteps) & !is.null(x_neg)){
    if (!isdiagAneg){
      .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x^2, prefix = "6.")
      
      Aneg <- matrix(eta[(len_eta - dim_x^2 + 1):len_eta],dim_x,dim_x)
    }else{
      .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x, prefix = "7.")
      
      Aneg <- diag(eta[(len_eta  - dim_x + 1) : len_eta])
    }
    # for (t in 2:TT)
    #   h[t,] <- omega + B %*% h[t - 1,] + A %*% x[t - 1,] + Aneg %*% x_neg[t - 1,]
  }else if (is.null(TimeSteps) & !is.null(x_lag) & !is.null(x_neg)){
    if (!isdiagF){  # F complete
      F = matrix(eta[(len_eta  - dim_x^2 + 1) : len_eta],dim_x,dim_x);
      if (!isdiagAneg){ # Aneg complete F complete
        .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = 2*dim_x^2, prefix = "8.")
        Aneg <- matrix(eta[(len_eta  - dim_x^2 - dim_x^2 + 1) : (len_eta  - dim_x^2)],dim_x,dim_x)
      }else{ # Aneg diagonal F complete
        .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x + dim_x^2, prefix = "9.")
        Aneg <- diag(eta[(len_eta - dim_x - dim_x^2 + 1) : (len_eta - dim_x^2)])
      }
    }else{ # F diagonal
      F <- diag(eta[(len_eta  - dim_x + 1) : len_eta])
      if (!isdiagAneg) {# Aneg complete F diagonal
        .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x + dim_x^2, prefix = "10.")
        Aneg <- matrix(eta[(len_eta  - dim_x - dim_x^2 + 1) : (len_eta  - dim_x)],dim_x,dim_x)
      }else {# Aneg diagonal F diagonal
        .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = 2*dim_x, prefix = "11.")
        Aneg <- diag(eta[(len_eta - dim_x - dim_x + 1) : (len_eta - dim_x)])
      }
    }
    # for (t in 2:TT)
    #   h[t,] <- omega + 
    #     B %*% h[t - 1,] + 
    #     A %*% x[t - 1,] + 
    #     Aneg %*% x_neg[t - 1,] +
    #     F %*% x_lag[t - 1,]
  }else if (is.null(x_lag) & !is.null(x_neg) & !is.null(TimeSteps)){
    if (!isdiagG & !isdiagGneg){
      Gneg <- array(eta[(len_eta  - (l)*dim_x^2 + 1) : len_eta], dim=c(dim_x,dim_x,l))
      G = array(eta[(len_eta  - 2*l*dim_x^2 + 1) : (len_eta  - (l)*dim_x^2)], dim=c(dim_x,dim_x,l))
      K = matrix(eta[(len_eta  - 2*l*dim_x^2 - (l)*dim_x + 1) : (len_eta  - 2*l*dim_x^2)], dim_x,l)
      if (!isdiagAneg) {# Aneg complete, G complete, Gneg complete
        .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x^2 + (l)*dim_x + 2*l*dim_x^2, prefix = "12.")
        Aneg <- matrix(eta[(len_eta  - 2*l*dim_x^2 - (l)*dim_x - dim_x^2 + 1) : (len_eta  - 2*l*dim_x^2 - (l)*dim_x)], dim_x,dim_x)
      }else{# Aneg diag, G complete, Gneg complete
        .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x + (l)*dim_x + 2*l*dim_x^2, prefix = "12.")
        Aneg <- diag(eta[(len_eta  - 2*l*dim_x^2 - (l)*dim_x - dim_x + 1) : (len_eta  - 2*l*dim_x^2 - (l)*dim_x)])
      }
    }else if (!isdiagG & isdiagGneg){
      Gneg <- array(apply(matrix(eta[(len_eta  - (l)*dim_x + 1) : len_eta], dim_x,l), MARGIN = 2, FUN=diag),
                    dim=c(dim_x,dim_x,l))
      G <- array(eta[(len_eta  - (l)*dim_x - (l)*dim_x^2 + 1) : (len_eta  - (l)*dim_x)], dim=c(dim_x,dim_x,l))
      K <- matrix(eta[(len_eta  - (l)*dim_x^2 - 2*l*dim_x + 1) : (len_eta  - (l)*dim_x - (l)*dim_x^2)], dim_x,l)
      if (!isdiagAneg) {# Aneg complete, G complete, Gneg diag
        .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x^2 + 2*l*dim_x + (l)*dim_x^2, prefix = "13.")
        Aneg <- matrix(eta[(len_eta  - (l)*dim_x^2 - 2*l*dim_x - dim_x^2 + 1) : (len_eta  - (l)*dim_x^2 - 2*l*dim_x)], dim_x,dim_x)
      }else {# Aneg diagonal, G complete, Gneg diagonal
        .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x + 2*l*dim_x + (l)*dim_x^2, prefix = "14.")
        Aneg <- diag(eta[(len_eta  - (l)*dim_x^2 - 2*l*dim_x - dim_x + 1) : (len_eta  - (l)*dim_x^2 - 2*l*dim_x)])
      }
    }else if (isdiagG & !isdiagGneg){
      Gneg <- array(eta[(len_eta  - (l)*dim_x^2 + 1) : len_eta], dim=c(dim_x,dim_x,l))
      G <- array(apply(matrix(eta[(len_eta - (l)*dim_x^2 - (l)*dim_x  + 1) : (len_eta  - (l)*dim_x^2)], dim_x,l), 
                       MARGIN = 2, FUN=diag), dim=c(dim_x,dim_x,l))
      K <- matrix(eta[(len_eta  - (l)*dim_x^2 - 2*l*dim_x + 1) : (len_eta  - (l)*dim_x - (l)*dim_x^2)], dim_x,l)
      if (!isdiagAneg) {# Aneg complete, G diagonal, Gneg complete
        .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x^2 + 2*l*dim_x + (l)*dim_x^2, prefix = "15.")
        Aneg <- matrix(eta[(len_eta  - (l)*dim_x^2 - 2*l*dim_x - dim_x^2 + 1) : (len_eta - (l)*dim_x^2 - 2*l*dim_x)], dim_x,dim_x)
      }else {# Aneg complete, G diagonal, Gneg complete
        .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x + 2*l*dim_x + (l)*dim_x^2, prefix = "16.")
        Aneg <- diag(eta[(len_eta  - (l)*dim_x^2 - 2*l*dim_x - dim_x + 1) : (len_eta - (l)*dim_x^2 - 2*l*dim_x)])
      }
    }else{
      Gneg <- array(apply(matrix(eta[(len_eta  - (l)*dim_x + 1) : len_eta], dim_x,l),
                          MARGIN = 2, FUN=diag), dim=c(dim_x,dim_x,l))
      G <- array(apply(matrix(eta[(len_eta  - 2*l*dim_x  + 1) : (len_eta - (l)*dim_x)], dim_x,l),
                       MARGIN = 2, FUN=diag), dim=c(dim_x,dim_x,l))
      K <- matrix(eta[(len_eta  - 3*l*dim_x + 1) : (len_eta - 2*l*dim_x)], dim_x,l)
      if (!isdiagAneg) {# Aneg complete, G diagonal, Gneg diagonal
        .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x^2 + 3*l*dim_x, prefix = "17.")
        Aneg <- matrix(eta[(len_eta  - 3*l*dim_x - dim_x^2 + 1) : (len_eta  - 3*l*dim_x)], dim_x,dim_x)
      }else{ # Aneg complete, G diagonal, Gneg diagonal
        .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x + 3*l*dim_x, prefix = "18.")
        Aneg <- diag(eta[(len_eta  - (l)*dim_x - 2*l*dim_x - dim_x + 1) : (len_eta  - (l)*dim_x - 2*l*dim_x)])
      }
    }
    # for (j in 1:l){
    #   if (j==1){
    #     for (t in 2:TimeSteps[2])
    #       h[t,] <- omega + B %*% h[t - 1,] + A %*% x[t - 1,]
    #   }else{
    #     for (t in (TimeSteps[j]+1):TimeSteps[j+1])
    #       h[t,] <- omega + 
    #         B %*% h[t - 1,] + 
    #         A %*% x[t - 1,] + 
    #         Aneg %*% x[t - 1,] + 
    #         K[,j - 1] + 
    #         G[,,j - 1] %*% x[t - 1,] + 
    #         Gneg[,,j - 1] %*% x_neg[t - 1,]
    #   }
    # }
  }else if (is.null(x_neg) & !is.null(x_lag) & !is.null(TimeSteps)){
    if (!isdiagG){
      G <- array(eta[(len_eta - (l)*dim_x^2 + 1) : len_eta], dim=c(dim_x,dim_x,l))
      K <- matrix(eta[(len_eta - (l)*dim_x^2 - (l)*dim_x + 1) : (len_eta - (l)*dim_x^2)], dim_x,l)
      if (!isdiagF) {# F complete, G complete
        .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x^2 + (l)*dim_x + (l)*dim_x^2, prefix = "19.")
        F <- matrix(eta[(len_eta - (l)*dim_x^2 - (l)*dim_x - dim_x^2 + 1) : (len_eta - (l)*dim_x^2 - (l)*dim_x)] , dim_x, dim_x)
      }else{ # F diagonal, G complete
        .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x + (l)*dim_x + (l)*dim_x^2, prefix = "20.")
        F <- diag(eta[(len_eta - (l)*dim_x^2 - (l)*dim_x - dim_x + 1) : (len_eta - (l)*dim_x^2 - (l)*dim_x)])
      }
    }else{
      G <- array(apply(matrix(eta[(len_eta  - (l)*dim_x + 1) : len_eta], dim_x,l), 
                       MARGIN = 2, FUN=diag), dim=c(dim_x,dim_x,l))
      K <- matrix(eta[(len_eta  - 2*l*dim_x + 1) : (len_eta  - (l)*dim_x)], dim_x,l)
      if (!isdiagF) {# F complete, G diagonal
        .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x^2 + 2*l*dim_x, prefix = "21.")
        F <- matrix(eta[(len_eta  - 2*l*dim_x - dim_x^2 + 1) : (len_eta  - 2*l*dim_x)], dim_x, dim_x)
      }else{# F diagonal, G diagonal
        .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x + 2*l*dim_x, prefix = "22.")
        F <- diag(eta[(len_eta  - 2*l*dim_x - dim_x + 1) : (len_eta  - 2*l*dim_x)])
      }
    }
    # for (j in 1:l){
    #   if (j==1){
    #     for (t in 2:TimeSteps[2])
    #       h[t,] <- omega + B %*% h[t - 1,] + A %*% x[t - 1,]
    #   }else{
    #     for (t in (TimeSteps[j]+1):TimeSteps[j+1])
    #       h[t,] <- omega + 
    #         B %*% h[t - 1,] + 
    #         A %*% x[t - 1,] + 
    #         F %*% x_lag[t - 1,] + 
    #         K[,j - 1] + 
    #         G[,,j - 1] %*% x[t - 1,]
    #   }
    # }  
  }else if (!is.null(TimeSteps) & !is.null(x_lag) & !is.null(x_neg)){
    if (!isdiagG & !isdiagGneg){
      Gneg <- array(eta[(len_eta  - (l)*dim_x^2 + 1) : len_eta], dim=c(dim_x,dim_x,l))
      G <- array(eta[(len_eta  - 2*l*dim_x^2 + 1) : (len_eta  - (l)*dim_x^2)], dim=c(dim_x,dim_x,l))
      K <- matrix(et[a(len_eta  - 2*l*dim_x^2 - (l)*dim_x + 1) : (len_eta  - 2*l*dim_x^2)], dim_x,l)
      if (!isdiagAneg){
        if (!isdiagF) {# Aneg complete, F complete, G complete, Gneg complete
          .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = 2*dim_x^2 + (l)*dim_x + 2*l*dim_x^2, prefix = "23.")
          F <- matrix(eta[(len_eta  - 2*l*dim_x^2 - (l)*dim_x - dim_x^2 + 1) : (len_eta  - 2*l*dim_x^2 - (l)*dim_x)], dim_x, dim_x)
          Aneg  <- matrix(eta[(len_eta  - 2*l*dim_x^2 - (l)*dim_x - dim_x^2 - dim_x^2 + 1) : (len_eta  - 2*l*dim_x^2 - (l)*dim_x - dim_x^2)], dim_x,dim_x)
        }else {# Aneg complete, F diag, G complete, Gneg complete
          .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x + dim_x^2 + (l)*dim_x + 2*l*dim_x^2, prefix = "24.")
          F <- diag(eta[(len_eta - 2*l*dim_x^2 - (l)*dim_x - dim_x + 1) : (len_eta - 2*l*dim_x^2 - (l)*dim_x)])
          Aneg <- matrix(eta[(len_eta - 2*l*dim_x^2 - (l)*dim_x - dim_x^2 - dim_x + 1) : (len_eta - 2*l*dim_x^2 - (l)*dim_x - dim_x)], dim_x,dim_x)
        }
      }else{
        if (!isdiagF) {# Aneg diag, F complete, G complete, Gneg complete
          .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x + dim_x^2 + (l)*dim_x + 2*l*dim_x^2, prefix = "25.")
          F <- matrix(eta[(len_eta  - 2*l*dim_x^2 - (l)*dim_x - dim_x^2 + 1) : (len_eta  - 2*l*dim_x^2 - (l)*dim_x)], dim_x, dim_x)
          Aneg <- diag(eta[(len_eta  - 2*l*dim_x^2 - (l)*dim_x - dim_x - dim_x^2 + 1) : (len_eta  - 2*l*dim_x^2 - (l)*dim_x - dim_x^2)])
        }else {# Aneg diag, F diag, G complete, Gneg complete
          .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = 2*dim_x + (l)*dim_x + 2*l*dim_x^2, prefix = "26.")
          F <- diag(eta[(len_eta - 2*l*dim_x^2 - (l)*dim_x - dim_x + 1) : (len_eta - 2*l*dim_x^2 - (l)*dim_x)])
          Aneg  <- diag(eta[(len_eta - 2*l*dim_x^2 - (l)*dim_x - dim_x - dim_x + 1) : (len_eta - 2*l*dim_x^2 - (l)*dim_x - dim_x)])
        }
      }
    }else if (!isdiagG & isdiagGneg){
      Gneg <- array(apply(matrix(eta[(len_eta  - (l)*dim_x + 1) : len_eta], dim_x,l),
                          MARGIN = 2, FUN=diag), dim=c(dim_x,dim_x,l))
      G <- array(eta[(len_eta - (l)*dim_x - (l)*dim_x^2 + 1) : (len_eta - (l)*dim_x)], dim=c(dim_x,dim_x,l))
      K <- matrix(eta[(len_eta - (l)*dim_x^2 - 2*l*dim_x + 1) : (len_eta - (l)*dim_x - (l)*dim_x^2)], dim_x,l)
      if (!isdiagAneg){
        if (!isdiagF) {# Aneg complete, F complete, G complete, Gneg diag
          .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = 2*dim_x^2 + 2*l*dim_x + (l)*dim_x^2, prefix = "27.")
          F <- matrix(eta[(len_eta  - (l)*dim_x^2 - 2*l*dim_x - dim_x^2 + 1) : (len_eta  - (l)*dim_x^2 - 2*l*dim_x)], dim_x, dim_x)
          Aneg <- matrix(eta[(len_eta  - (l)*dim_x^2 - 2*l*dim_x - dim_x^2 - dim_x^2 + 1) : (len_eta  - (l)*dim_x^2 - 2*l*dim_x - dim_x^2)], dim_x,dim_x)
        }else {# Aneg complete, F diag, G complete, Gneg diag
          .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x + dim_x^2 + 2*l*dim_x + (l)*dim_x^2, prefix = "28.")
          F <- diag(eta[(len_eta  - (l)*dim_x^2 - 2*l*dim_x - dim_x + 1) : (len_eta  - (l)*dim_x^2 - 2*l*dim_x)])
          Aneg <- matrix(eta[(len_eta  - (l)*dim_x^2 - 2*l*dim_x - dim_x^2 - dim_x + 1) : (len_eta  - (l)*dim_x^2 - 2*l*dim_x - dim_x)], dim_x,dim_x)
        }
      }else{
        if (!isdiagF) {# Aneg diag, F complete, G complete, Gneg diag
          .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x + dim_x^2 + 2*l*dim_x + (l)*dim_x^2, prefix = "29.")
          F <- matrix(eta[(len_eta - (l)*dim_x^2 - 2*l*dim_x - dim_x^2 + 1) : (len_eta - (l)*dim_x^2 - 2*l*dim_x)], dim_x, dim_x)
          Aneg  <- diag(eta(len_eta - (l)*dim_x^2 - 2*l*dim_x - dim_x - dim_x^2 + 1) : (len_eta - (l)*dim_x^2 - 2*l*dim_x - dim_x^2))
        }else {# Aneg diag, F diag, G complete, Gneg diag
          .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = 2*dim_x + 2*l*dim_x + (l)*dim_x^2, prefix = "30.")
          F <- diag(eta[(len_eta - (l)*dim_x^2 - 2*l*dim_x - dim_x + 1) : (len_eta - (l)*dim_x^2 - 2*l*dim_x)])
          Aneg <- diag(eta[(len_eta - (l)*dim_x^2 - 2*l*dim_x - dim_x - dim_x + 1) : (len_eta - (l)*dim_x^2 - 2*l*dim_x - dim_x)])
        }
      }
    }else if (isdiagG & !isdiagGneg){
      Gneg <- array(eta[(len_eta  - (l)*dim_x^2 + 1) : len_eta], dim=c(dim_x,dim_x,l))
      G <- array(apply(matrix(eta[(len_eta - (l)*dim_x^2 - (l)*dim_x  + 1) : (len_eta - (l)*dim_x^2)], dim_x,l),
                       MARGIN = 2, FUN=diag), dim=c(dim_x,dim_x,l))
      K <- matrix(eta[(len_eta - (l)*dim_x^2 - 2*l*dim_x + 1) : (len_eta  - (l)*dim_x - (l)*dim_x^2)], dim_x,l)
      if (!isdiagAneg){
        if (!isdiagF) {# Aneg complete, F complete, G diag, Gneg complete
          .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = 2*dim_x^2 + 2*l*dim_x + (l)*dim_x^2, prefix = "31.")
          F <- matrix(eta[(len_eta - (l)*dim_x^2 - 2*l*dim_x - dim_x^2 + 1) : (len_eta - (l)*dim_x^2 - 2*l*dim_x)], dim_x, dim_x)
          Aneg  <- matrix(eta[(len_eta - (l)*dim_x^2 - 2*l*dim_x - dim_x^2 - dim_x^2 + 1) : (len_eta - (l)*dim_x^2 - 2*l*dim_x - dim_x^2)], dim_x,dim_x)
        }else {# Aneg complete, F diag, G diag, Gneg complete
          .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x^2 + dim_x + 2*l*dim_x + (l)*dim_x^2, prefix = "32.")
          F <- diag(eta[(len_eta - (l)*dim_x^2 - 2*l*dim_x - dim_x + 1) : (len_eta - (l)*dim_x^2 - 2*l*dim_x)])
          Aneg <- matrix(eta[(len_eta - (l)*dim_x^2 - 2*l*dim_x - dim_x^2 - dim_x + 1) : (len_eta - (l)*dim_x^2 - 2*l*dim_x - dim_x)], dim_x,dim_x)
        }
      }else{
        if (!isdiagF) {# Aneg diag, F complete, G diag, Gneg complete
          .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x^2 + dim_x + 2*l*dim_x + (l)*dim_x^2, prefix = "33.")
          F <- matrix(eta[(len_eta  - (l)*dim_x^2 - 2*l*dim_x - dim_x^2 + 1) : (len_eta  - (l)*dim_x^2 - 2*l*dim_x)], dim_x, dim_x)
          Aneg <- diag(eta[(len_eta  - (l)*dim_x^2 - 2*l*dim_x - dim_x - dim_x^2 + 1) : (len_eta  - (l)*dim_x^2 - 2*l*dim_x - dim_x^2)])
        }else {# Aneg diag, F diag, G diag, Gneg complete
          .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = 2*dim_x + 2*l*dim_x + (l)*dim_x^2, prefix = "34.")
          F <- diag(eta[(len_eta  - (l)*dim_x^2 - 2*l*dim_x - dim_x + 1) : (len_eta  - (l)*dim_x^2 - 2*l*dim_x)])
          Aneg <- diag(eta[(len_eta  - (l)*dim_x^2 - 2*l*dim_x - dim_x - dim_x + 1) : (len_eta  - (l)*dim_x^2 - 2*l*dim_x - dim_x)])
        }
      }
    }else{
      Gneg <- array(apply(matrix(eta[(len_eta - (l)*dim_x + 1) : len_eta], dim_x,l),
                          MARGIN = 2, FUN=diag), dim=c(dim_x,dim_x,l))
      G <- array(apply(matrix(eta[(len_eta  - 2*l*dim_x  + 1) : (len_eta - (l)*dim_x)], dim_x,l),
                       MARGIN = 2, FUN=diag), dim=c(dim_x,dim_x,l))
      K < matrix(eta[(len_eta - 3*l*dim_x + 1) : (len_eta - 2*l*dim_x)], dim_x,l)
      if (!isdiagAneg){
        if (!isdiagF) {# Aneg complete, F complete, G diag, Gneg diag
          .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = 2*dim_x^2 + 3*l*dim_x, prefix = "35.")
          F <- matrix(eta[(len_eta - 3*l*dim_x - dim_x^2 + 1) : (len_eta - 3*l*dim_x)], dim_x, dim_x)
          Aneg <- matrix(eta[(len_eta - 3*l*dim_x - dim_x^2 - dim_x^2 + 1) : (len_eta - 3*l*dim_x - dim_x^2)], dim_x,dim_x)
        }else{ # Aneg complete, F diag, G diag, Gneg diag
          .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x + dim_x^2 + 3*l*dim_x, prefix = "36.")
          F <- diag(eta[(len_eta - 3*l*dim_x - dim_x + 1) : (len_eta - 3*l*dim_x)])
          Aneg <- matrix(eta[(len_eta - 3*l*dim_x - dim_x^2 - dim_x + 1) : (len_eta - 3*l*dim_x - dim_x)], dim_x,dim_x) 
        }
      }else{
        if (!isdiagF) {# Aneg diag, F complete, G diag, Gneg diag
          .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = dim_x + dim_x^2 + 3*l*dim_x, prefix = "37.")
          F <- matrix(eta[(len_eta - 3*l*dim_x - dim_x^2 + 1) : (len_eta - 3*l*dim_x)], dim_x, dim_x)
          Aneg  = diag(eta[(len_eta - 3*l*dim_x - dim_x - dim_x^2 + 1) : (len_eta  - 3*l*dim_x - dim_x^2)])
        }else {# Aneg diag, F diag, G diag, Gneg diag
          .checkSizes(model = model, eta = eta, dim_x = dim_x, addenda = 2*dim_x + 3*l*dim_x, prefix = "38.")
          F <- matrix(eta[(len_eta  - 3*l*dim_x - dim_x + 1) : (len_eta  - 3*l*dim_x)])
          Aneg <- matrix(eta[(len_eta  - 3*l*dim_x - dim_x - dim_x + 1) : (len_eta  - 3*l*dim_x - dim_x)])
        }
      }
    }
    # for (j in 1:l){
    #   if (j==1){
    #     for (t in 2:TimeSteps[2])
    #       h[t,] <- omega + 
    #         B %*% h[t - 1,] + 
    #         A %*% x[t - 1,] + 
    #         Aneg %*% x_neg[t - 1,] +
    #         F %*% x_lag[t - 1,]
    #   }else{
    #     for (t in (TimeSteps[j]+1):TimeSteps[j+1])
    #       h[t,] <- omega +
    #         B %*% h[t - 1,] +
    #         A %*% x[t - 1,] +
    #         Aneg %*% x_neg[t - 1,] +
    #         F %*% x_lag[t - 1,] +
    #         K[,j - 1] +
    #         G[,,j - 1] %*% x[t - 1,] +
    #         Gneg[,,j - 1] %*% x_neg[t - 1,]
    #   }
    # }
  }
  
  if (!exists("Aneg"))
    Aneg <- matrix(0,dim_x,dim_x)
  
  if (is.logical(F))
    F <- matrix(0,dim_x,dim_x)
  
  return(list(omega=omega, B=B, A=A, Aneg=Aneg, F=F, K=get0("K"), G=get0("G"), Gneg=get0("Gneg")))
}

.postProcessing <- function (mbar, n, isdiagB){
  
  #' Post-Processing transformation
  #'
  #' @param mbar:     estimate of the mean of the DPM
  #' @param n:        length of the vector of parameters
  #' @param isdiagB:  Flag that indicates if B is diagonal or not
  #' 
  #' @return Post-Processeing transformation vector
  
  
  if (!is.vector(mbar))
    stop('The first argument, mbar, must be a numerical vector.')
  
  if (!is.logical(isdiagB))
    stop ('The third argument must be logical')
  
  dim_x <- length(mbar)
  
  if (!isdiagB){
    return(c(mbar, rep(1, dim_x^2), rep(mbar, (n - dim_x - dim_x^2) / dim_x)))
  }else{
    return(c(mbar, rep(1, dim_x), rep(mbar, (n - dim_x - dim_x) / dim_x)))
  }
}
