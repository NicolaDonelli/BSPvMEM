diagarray <- function(S, i=1, out=c()){
  #' Compute matrix of diagonals
  #' 
  #' Creates a matrix of diagonals from an array of square matrices
  #' 
  #' @param S tri-dimensional array with pages formed by square matrices
  #' 
  #' @return matrix whose columns are the main diagonals of the pages of S
  #' @export
  if (i <= dim(S)[3])
    out <- diagarray(S, i+1 , out=cbind(out, diag(S[,,i])))
  return(out)
}
