library(chron)
library(ggplot2)
library(zoo)
library(dplyr)

source("R/MLogLikMEM1.R")
source("R/LogLikMEM1.R")
source("R/LogLikMEM1_vec.R")
source("R/IJMatrices.R")


#### RealData ####
BaseDati <- read.table(file.path("data","csv","Henry_Hub_Natural_Gas_Spot_Price.csv"), header = TRUE, sep = ",",
                       quote = "\"", dec = ".", skip = 4, stringsAsFactors = FALSE)
nameTS <- gsub("\\."," ",colnames(BaseDati)[2])
colnames(BaseDati) <- c("Date", "Price")
BaseDati$Date <- as.character(
  chron::chron(BaseDati$Date, format = c(dates = "m/d/y"),
        out.format = c(dates = "d/m/y")))
BaseDati <- arrange(BaseDati, -row_number())

Prices <- zoo(BaseDati$Price,
              order.by = as.Date(strptime(as.character(BaseDati$Date), "%d/%m/%y")))
autoplot(Prices)
min(Prices)
max(Prices)
var(Prices)
# It seems that Prices have quite a significance absolute variance, hence it is probably
# better to use a square root or log transformation to stabilize the prices.
autoplot(log(Prices))
var(log(Prices))
autoplot(sqrt(Prices))
var(sqrt(Prices))

# The estimates obtained with square root transformation look better, hence
# we choose to use them:
# x <- as.vector(sqrt(Prices))
x <- as.vector(log(Prices))


# OUT OF SAMPLE TEST
nx <- floor(length(x)/2)
Data <- list()
Data$PricesTS <- Prices
Data$x_fit  <- x[1:(length(x)-nx)]
Data$x_test <- x[(length(x)-nx+1):length(x)]
x <- Data$x_fit

# ML Estimation
NParams <- 4

o_MEM_0 <- 0.1
a_MEM_0 <- 0.4
b_MEM_0 <- 0.03
phi_MEM_0 <- 10

# o_MEM_0 <- 0.1
# a_MEM_0 <- 0.3
# b_MEM_0 <- 0.3
# phi_MEM_0 <- 5

# o_MEM_0 <- 0.1
# a_MEM_0 <- 0.1
# b_MEM_0 <- 0.7
# phi_MEM_0 <- 5


set.seed(42)
Params_Initial <- 
  rbind(o_MEM_0,a_MEM_0,b_MEM_0,phi_MEM_0) * (1 + 0.2 * (2 * runif(NParams) - 1))

epsilon = 1e-6
A_ineq = diag(NParams)
b_ineq = c(epsilon, epsilon, epsilon, epsilon)

outList <-  constrOptim(Params_Initial, f = MLogLikMEM1,
                        ui = diag(NParams), ci = c(epsilon, epsilon, epsilon, epsilon),
                        grad = NULL,  method = "Nelder-Mead",
                        outer.iterations = 100,
                        control = list(fnscale = 1, ndeps = 1e-6, maxit = 10000,
                                       abstol = 1e-6, parscale = c(1,1,1,3),
                                       alpha = 1.0, beta = 0.5, gamma = 2.0),
                        x = x)
outList$par
{
  # o_MEM_0 <- 0.1
  # a_MEM_0 <- 0.1
  # b_MEM_0 <- 0.7
  # phi_MEM_0 <- 5
  
  # o_MEM_0   5.937313e-03
  # a_MEM_0   3.075833e-01
  # b_MEM_0   7.047531e-01
  # phi_MEM_0 1.565715e+02
}
{
  # o_MEM_0 <- 0.1
  # a_MEM_0 <- 0.3
  # b_MEM_0 <- 0.3
  # phi_MEM_0 <- 5
  
  # o_MEM_0     0.1658577
  # a_MEM_0     0.8244040
  # b_MEM_0     0.0488394
  # phi_MEM_0 309.3852947
}

{
  # o_MEM_0 <- 0.1
  # a_MEM_0 <- 0.4
  # b_MEM_0 <- 0.03
  # phi_MEM_0 <- 10
  # 
  # o_MEM_0     0.2097307
  # a_MEM_0     0.5011512
  # b_MEM_0     0.3957778
  # phi_MEM_0 365.1938087
}

MLE <- list()

MLE$o_MEM_MLE <- outList$par[1]
MLE$a_MEM_MLE <- outList$par[2]
MLE$b_MEM_MLE <- outList$par[3]
MLE$phi_MEM_MLE <- outList$par[4]
MLE$h_MLE <- NaN * x
MLE$h_MLE[1] <- mean(x)
for (t in 2:length(x))
  MLE$h_MLE[t] <- MLE$o_MEM_MLE + MLE$b_MEM_MLE * MLE$h_MLE[t - 1] + MLE$a_MEM_MLE * x[t - 1]

MLE$e_MLE <- x / MLE$h_MLE

plot(x, type = "l")
lines(MLE$h_MLE, col = "red")
Metrics::rmse(x,MLE$h_MLE)

plot(MLE$e_MLE, type = "l")
Box.test(x = MLE$e_MLE, type = "Ljung-Box")


IJMat = IJMatrices(f = LogLikMEM1_vec, theta = outList$par, x)
MLE$VC_MLE1 =  solve(IJMat$I) / length(x)
MLE$VC_MLE2 =  solve(IJMat$J) %*% IJMat$I %*% solve(IJMat$J) / length(x)



save(list = c("x","Data","MLE"), file="HHLogPrices_v1.RData")

#### Predictions ####
N_sa <- 10
h <- MLE$h_MLE
x_ext <- x
for(n_sa in 1:N_sa){
  h <- c(h, MLE$o_MEM_MLE + MLE$a_MEM_MLE * x_ext[length(x_ext)] + MLE$b_MEM_MLE * h[length(h)])
  x_ext <- c(x_ext, h[length(h)])
}

output <- cbind(qgamma(0.025, shape = MLE$phi_MEM_MLE, scale = h[(length(h)-9):length(h)]/MLE$phi_MEM_MLE),
x_ext[(length(x_ext)-9):length(x_ext)],
Data$x_test[1:10],
qgamma(0.975, shape = MLE$phi_MEM_MLE, scale = h[(length(h)-9):length(h)]/MLE$phi_MEM_MLE))

plot(output[,2], type = "l", ylab = "", xlab = "Steps Ahead", main = "Predictions",
     ylim = c(min(output), max(output)))
lines(output[,1], col = "red")
lines(output[,4], col = "red")
lines(output[,3], col = "green")
legend("bottomleft", legend = c("Pred","0.025","0.975","True"), 
       col =c("black","red","red","green"),
       lwd = 1, lty = 1, cex = 0.8)
