AucTrap <- function (x, y, dens = 2) 
{
  #' Area under the curve
  #' 
  #' Compute crea under the curve defined by x and y using trapezius method
  #' 
  #' @param x sequence of values on the x axis
  #' @param y sequence of corresponding values of the target function
  #' @param dens number of additional points between adjacent data points.
  #       These additional data points are calculated by linear interpolation along x and y.
  #'      The actual number of additional data points is (dens - 2).
  
  if(dens < 2)
    stop("dens must be greater or equal than 2")
  
  x <- x[!is.na(x)]
  y <- y[!is.na(x)]
  x <- x[!is.na(y)]
  y <- y[!is.na(y)]
  
  ord <- order(x)
  x <- x[ord]
  y <- y[ord]

  idx <- 2:length(x)
  if(dens != 2){
    x <- as.vector(apply(cbind(x[idx-1], x[idx]), MARGIN = 1, 
                         function(x) {seq(x[1], x[2], length.out = dens)}))
    y <- as.vector(apply(cbind(y[idx-1], y[idx]), MARGIN = 1, 
                         function(x) {seq(x[1], x[2], length.out = dens)}))
    idx <- 2:length(x)
  }
  
  integral <- as.double((x[idx] - x[idx - 1]) %*% (y[idx] + y[idx - 1]))/2
  integral
}