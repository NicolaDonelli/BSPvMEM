source("R/MLogLikMEM1.R")
source("R/LogLikMEM1.R")
source("R/Gamma2ParamMode.R")
source("R/Gamma2Param_hprime.R")
source("R/Gamma2Param_h.R")
source("R/LogLikMEM1_vec.R")
source("R/IJMatrices.R")

#### Simulation ####

TRUE_vals <- list()

TRUE_vals$o_MEM_TRUE <- 0.4
TRUE_vals$a_MEM_TRUE <- 0.3
TRUE_vals$b_MEM_TRUE <- 0.65

n <- 4e3
n_fit <- 3e3

p_Mixture <- 0.7
s_LN <- 0.45
m_LN <- - 0.5 * s_LN ^ 2
N_e00 <- 1e6
phi_Gamma <- 15
set.seed(42)
e1 <- rgamma(N_e00, shape = phi_Gamma, scale = 1/phi_Gamma)
e2 <- rlnorm(N_e00, m_LN, s_LN)
probs <- rbinom(N_e00, size = 1, prob = p_Mixture)
e <- probs*e1 + (1-probs)*e2
rm(e1, e2, probs)

e = e / mean(e)

TRUE_vals$e_TRUE <- e[1:n]
TRUE_vals$e_TRUE <- TRUE_vals$e_TRUE / mean(TRUE_vals$e_TRUE)
remove(e)

TRUE_vals$h_TRUE <- NaN * TRUE_vals$e_TRUE
x_TRUE <- NaN * TRUE_vals$e_TRUE
TRUE_vals$h_TRUE[1] <- 10
x_TRUE[1] <- TRUE_vals$h_TRUE[1] * TRUE_vals$e_TRUE[1]
for (t in 2:length(x_TRUE)){
  TRUE_vals$h_TRUE[t] <- TRUE_vals$o_MEM_TRUE + TRUE_vals$a_MEM_TRUE * x_TRUE[t - 1] + TRUE_vals$b_MEM_TRUE * TRUE_vals$h_TRUE[t - 1]
  x_TRUE[t] <- TRUE_vals$h_TRUE[t] * TRUE_vals$e_TRUE[t]
}
Data <- list()
Data$x_fit <- x_TRUE[1:n_fit]
Data$x_test <- x_TRUE[(n_fit+1):n]
x <- Data$x_fit
remove(x_TRUE)


#### MLE Estimation of MEM Model ####

LogLikMEM1 <- function(theta, x){
  # Base Symmetric MEM
  # input x is Realized Volatility (sqrt of realized variance)
  # theta = (omega, a, b, phi)
  # x_t = h_t * e_t
  # e_t: shape = phi,
  #      scale = 1 / phi
  # h(t) = o + b * h(t-1) + a * x(t-1)
  
  L <- length(x)
  
  o   <- theta[1]
  a   <- theta[2]
  b   <- theta[3]
  phi <- theta[4]
  
  h    <- NaN * 1:L
  h[1] <- mean(x)
  for (t in 2:L){
    h[t] <- o + b * h[t - 1] + a * x[t - 1]
  }
  
  shape_x <- phi
  scale_x <- h/phi
  
  sum(-shape_x*log(scale_x) - log(gamma(shape_x)) + (shape_x - 1)*log(x) - x/scale_x, na.rm = TRUE)
}

NParams <- 4
o_MEM_0   <- 0.1
a_MEM_0   <- 0.1
b_MEM_0   <- 0.7
phi_MEM_0 <- 10

set.seed(42)
Params_Initial <- rbind(o_MEM_0,a_MEM_0,b_MEM_0,phi_MEM_0) * (1 + 0.2 * (2 * runif(NParams) - 1))

epsilon <- 1e-6
outList <-  constrOptim(Params_Initial, f = MLogLikMEM1, 
                        ui = diag(NParams), ci = c(epsilon, epsilon, epsilon, epsilon),
                        grad = NULL,  method = "Nelder-Mead",
                        outer.iterations = 100, 
                        control = list(fnscale = 1, ndeps = 1e-6, maxit = 10000,
                                       abstol = 1e-6, parscale = c(1,1,1,1),
                                       alpha = 1.0, beta = 0.5, gamma = 2.0),
                        x = x)
outList$par
# o_MEM_0   0.4144755
# a_MEM_0   0.2983804
# b_MEM_0   0.6517465
# phi_MEM_0 8.8626360

MLE <- list()
MLE$o_MEM_MLE <- outList$par[1]
MLE$a_MEM_MLE <- outList$par[2]
MLE$b_MEM_MLE <- outList$par[3]    
MLE$phi_MEM_MLE <- outList$par[4]
MLE$h_MLE <- NaN * x
MLE$h_MLE[1] <- mean(x)
for (t in 2:length(x))
  MLE$h_MLE[t] = MLE$o_MEM_MLE + MLE$b_MEM_MLE * MLE$h_MLE[t - 1] + MLE$a_MEM_MLE * x[t - 1]

MLE$e_MLE <- x / MLE$h_MLE

IJMat = IJMatrices(f = LogLikMEM1_vec, theta = outList$par, x)
MLE$VC_MLE1 =  solve(IJMat$I) / length(x)
MLE$VC_MLE2 =  solve(IJMat$J) %*% IJMat$I %*% solve(IJMat$J) / length(x)

par(mfrow = c(1,1))
y <- rgamma(200,MLE$phi_MEM_MLE, 1/MLE$phi_MEM_MLE)
qqplot(x = MLE$e_MLE, y = y)
qqline(y = y, 
       distribution = function(p) qgamma(p, shape = MLE$phi_MEM_MLE, scale = 1/MLE$phi_MEM_MLE),
       probs = c(0.1,0.9), col = "red")

# remove(y, phi_MEM_0, o_MEM_0, a_MEM_0, b_MEM_0, outList, t, s_LN, N_e00, m_LN,
#        IJMat, epsilon)

save(list = c("x","Data","MLE","TRUE_vals"), file = "SimulatedSampleAndMLE.RData")


