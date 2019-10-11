################################################################################
##
## File:     vMEM-Peluso.R
##
## Purpose:  vMEM in action.
##
## Created: 2019.10.11
##
## Version: 2019.10.11
##
## Author:
##  Fabrizio Cipollini <fabrizio.cipollini@unifi.it>
##
################################################################################

#### Clean
rm(list = ls())


################################################################################
## Libraries
################################################################################

library(vMEM)
library(openxlsx)


################################################################################
## Read data
################################################################################

#### Read data
folder  <- "data/xlsx"

#### Read
file <- file.path(folder, "FinalDataWorking.xlsx")
data <- readWorkbook(xlsxFile = file, sheet = "VFTSE Index", na.strings = "")
#### Append absolute returns
data <- data.frame(data, accvol = abs(data$ccret), check.names = FALSE)  
#### Remove NA
ind <- !apply(FUN = anyNA, X = data, MARGIN = 1)
data <- data[ind, , drop = FALSE]
  
#### Model
##  model is a list with components
##   $type: (data.frame) model formulation. Each row must have 5 elements in 
##    the following order:
##     type[i,1]: (character) parameter name: one among "betaE", "alphaE", 
##      "gammaE", "betaX", "alphaX", "gammaX".
##     type[i,2]: (character): "f" for 'full', "d" for 'diagonal'. Ignored for
##      "*E" parameters.
##     type[i,3]: (character) equations. Accepted forms are of the following 
##      type:
##      "3":   only equation 3 is included;
##      "1:3": all equations between 1 and 3 are included;
##      "1,3": only equations 1 and 3 are included.
##     type[i,4]: (character) from. Accepted forms are identical to type[i,3].
##     type[i,5]: (numeric) lag. Accepted forms are identical to type[i,3].
##   $add: (character) parameters added to the formulation in the form
##    'parm[eqn, from, lag]'.
##   $remove: (character) parameters to be removed from the formulation in the 
##    same form as 'add'.
model <- list(
  type = rbind( 
    c("alphaX", "f", "1:2", "1:2", 1), 
    c("gammaX", "d", "1:2", "1:2", 1), 
    c("betaX",  "d", "1:2", "1:2", 1) ), 
  remove = "alphaX[2,1,1]")

#### Estimation control settings
## 'algr' (a list) includes the names of the optimization algorithms used to
##  estimate parameters. 
control <- list(
  method = "inference",  ## Do not change
  nobs0 = 1,             ## Number of observations to start the filter
	algr = list(           ## Algorithm                            
   # newuoa = c(
   #  MFV = 1000,        ## Maximum function evaluations
   #  IPRNT = 200,       ## Trace each IPRNT iterations
   #  RHOBEG = 0.01),    ## Do not change
    dogleg = c(
      MIT = 500,         ## Maximum iterations 
      IPRNT = 100,       ## Trace each IPRNT iterations
      TOLG = 1e-8,       ## Gradient convergence tolerance
      DELTA = 0.1, RHO1 = 0.1, ML1 = 0.8, RHO2 = 1.0, ML2 = 1.5), ## Do not change
    newton = c(
      MIT = 500,         ## Maximum iterations
      IPRNT = 100,       ## Trace each IPRNT iterations
      TOLG = 1e-10)))    ## Gradient convergence tolerance


#### Estimate
fit <- MEM(xDep = data[, c("rkvol", "accvol")], xRet = data$ccret, xPred = NULL, 
	model = model, control = control)


#### Nicola configuration with real data  ####
library(dplyr)
library(vMEM)

load("/Users/nicoladonelli/Documents/Personale/BSPvMEM/BSPvMEM/data/rdata/SandSData.RData")
data <- SandSData %>% 
  dplyr::select("Dates","FTSE_r","FTSE_rv","FTSE_rk", "DJI_r", "DJI_rv", "DJI_rk", "SPX_r", "SPX_rv", "SPX_rk") %>% 
  dplyr::mutate(Dates=lubridate::as_date(Dates),
                FTSE_ar=abs(FTSE_r),
                DJI_ar=abs(DJI_r),
                SPX_ar=abs(SPX_r)) %>% 
  dplyr::mutate_if(.predicate = function(x){!lubridate::is.Date(x)}, .funs = function(x) {x*sqrt(252)*100})

data_FTSE <- data %>% 
  dplyr::select(Dates, FTSE_rk, FTSE_ar) %>% 
  dplyr::filter(!is.na(FTSE_rk) & !is.na(FTSE_ar))

data_DJI <- data %>% 
  dplyr::select(Dates, DJI_rk, DJI_ar) %>% 
  dplyr::filter(!is.na(DJI_rk) & !is.na(DJI_ar))

data_SPX <- data %>% 
  dplyr::select(Dates, SPX_rk, SPX_ar) %>% 
  dplyr::filter(!is.na(SPX_rk) & !is.na(SPX_ar))


model <- list(
  type = rbind( 
    c("alphaX", "f", "1:2", "1:2", 1), 
    c("betaX",  "d", "1:2", "1:2", 1) ))

control <- list(
  method = "inference",  ## Do not change
  nobs0 = 1,             ## Number of observations to start the filter
  algr = list(           ## Algorithm                            
    dogleg = c(
      MIT = 500,         ## Maximum iterations 
      IPRNT = 100,       ## Trace each IPRNT iterations
      TOLG = 1e-8,       ## Gradient convergence tolerance
      DELTA = 0.1, RHO1 = 0.1, ML1 = 0.8, RHO2 = 1.0, ML2 = 1.5), ## Do not change
    newton = c(
      MIT = 500,         ## Maximum iterations
      IPRNT = 100,       ## Trace each IPRNT iterations
      TOLG = 1e-10)))    ## Gradient convergence tolerance


# Vengono stimati 11 parametri perchè sono 8 parametri della equazione per mu e 3 della matrice di Var
# Per qualche motivo .print.MEM non ha printato correttamente i nomi dei parametri ma, 
# in base a fit$inference$parmName, dovrebbero essere, nell'ordine:
# mu[1], mu[2], betaX[1,1,1], alphaX[1,1,1], alphaX[1,2,1], betaX[2,2,1],alphaX[2,1,1],alphaX[2,2,1], 
# sigma[1,1], sigma[1,2], sigma[2,2]
# 
# Come detto prima da Fabrizio, il terzo indice dei coefficienti della equazione è il lag

fit_FTSE <- MEM(xDep = data_FTSE[, c("FTSE_rk", "FTSE_ar")], xRet = NULL, xPred = NULL, 
                model = model, control = control)

{
  # -------------------------------------------------------------------------------- 
  #   Coefficient Estimates: 
  #   parameter                  estimate           s.e.         t-stat         pvalue       gradient
  # 7                        0.15352774     0.00722847      21.239309     0.00000000             NA
  # 8                       14.46302171     0.32106362      45.047214     0.00000000             NA
  # 5                        0.76657547     0.01621923      47.263379     0.00000000 1.18157564e+03
  # 1                        0.06226152     0.01630652       3.818197     0.00013443 1.29341158e+03
  # 2                        0.00321094     0.00017447      18.404416     0.00000000 2.11357300e+01
  # 6                        0.83309388     0.05344719      15.587234     0.00000000 1.16335038e+02
  # 3                        0.69610457     0.58800927       1.183833     0.23647931 9.57235444e+00
  # 4                        0.03221580     0.01244368       2.588929     0.00962750 1.20723369e+03
  # 9                        0.56181336             NA             NA             NA             NA
  # 10                       0.26067109             NA             NA             NA             NA
  # 11                       0.77910600             NA             NA             NA             NA
  # Variance-Covariance matrix estimated via sandwich estimator 
  # ================================================================================ 
}

fit_DJI <- MEM(xDep = data_DJI[, c("DJI_rk", "DJI_ar")], xRet = NULL, xPred = NULL, 
               model = model, control = control)
{
  # -------------------------------------------------------------------------------- 
  #   Coefficient Estimates: 
  #   parameter                  estimate           s.e.         t-stat         pvalue       gradient
  # 7                        0.14306221     0.00722722      19.794907     0.00000000             NA
  # 8                       13.35145590     0.29179397      45.756449     0.00000000             NA
  # 5                        0.80726276     0.01444160      55.898433     0.00000000 1.59892647e+03
  # 1                        0.08110912     0.01447440       5.603626     0.00000002 2.09094781e+03
  # 2                        0.00268294     0.00014114      19.009325     0.00000000 1.04589325e+01
  # 6                        0.84748126     0.04362376      19.427055     0.00000000 6.52350444e+01
  # 3                        0.93779187     0.52358623       1.791093     0.07327830 1.42454837e+00
  # 4                        0.03293115     0.01133046       2.906427     0.00365582 7.63798494e+02
  # 9                        0.44666935             NA             NA             NA             NA
  # 10                       0.19500055             NA             NA             NA             NA
  # 11                       0.79472308             NA             NA             NA             NA
  # Variance-Covariance matrix estimated via sandwich estimator 
  # ================================================================================  
}

fit_SPX <- MEM(xDep = data_SPX[, c("SPX_rk", "SPX_ar")], xRet = NULL, xPred = NULL, 
               model = model, control = control)
{
  # -------------------------------------------------------------------------------- 
  #   Coefficient Estimates: 
  #   parameter                  estimate           s.e.         t-stat         pvalue       gradient
  # 7                        0.15918204     0.00683664      23.283674     0.00000000             NA
  # 8                       14.16376763     0.27219004      52.036319     0.00000000             NA
  # 5                        0.71224234     0.01838582      38.738680     0.00000000 7.23068692e+02
  # 1                        0.01186323     0.01201015       0.987767     0.32326662 2.50297471e+03
  # 2                        0.00359130     0.00020040      17.920791     0.00000000 9.92151970e+01
  # 6                        0.70727797     0.55261892       1.279866     0.20059239 3.07405166e+01
  # 3                        0.15830867     0.57204698       0.276741     0.78197923 2.25393542e+01
  # 4                        0.00675520     0.01526039       0.442663     0.65800973 1.79662103e+03
  # 9                        0.61608287             NA             NA             NA             NA
  # 10                       0.33111700             NA             NA             NA             NA
  # 11                       1.06765037             NA             NA             NA             NA
  # Variance-Covariance matrix estimated via sandwich estimator 
  # ================================================================================ 
}

#### Nicola configuration with simulated data  ####

# o.GMEM.TRUE <- c(0.40, 0.25)
# B.GMEM.TRUE <- matrix(data=c(0.35, 0.10, 0.07, 0.30), nrow=2, ncol=2, byrow=T)
# A.GMEM.TRUE <- matrix(data=c(0.27, 0.19, 0.18, 0.31), nrow=2, ncol=2, byrow=T)
# \varepsilon_t ~ 0.7 * logN(c(-0.1, -0.05), matrix(data=c(0.2, 0.09, 0.09, 0.1), nrow=2, ncol=2, byrow=T)) + 
#                 0.3 * logN(c(-0.15, -0.1), matrix(data=c(0.3, 0.1, 0.1, 0.2), nrow=2, ncol=2, byrow=T))

data_sim <- t(R.matlab::readMat("data/mat/Simulations/Simulation_Bivariate_MLEstimates_3000_1.mat", 
                              maxLength=NULL, fixNames=TRUE, drop=c("singletonLists"),
                              sparseMatrixClass=c("Matrix", "SparseM", "matrix"), verbose=FALSE)$x)

model <- list(
  type = rbind( 
    c("alphaX", "f", "1:2", "1:2", 1), 
    c("betaX",  "f", "1:2", "1:2", 1) ))

control <- list(
  method = "inference",  ## Do not change
  nobs0 = 1,             ## Number of observations to start the filter
  algr = list(           ## Algorithm                            
    dogleg = c(
      MIT = 500,         ## Maximum iterations 
      IPRNT = 100,       ## Trace each IPRNT iterations
      TOLG = 1e-8,       ## Gradient convergence tolerance
      DELTA = 0.1, RHO1 = 0.1, ML1 = 0.8, RHO2 = 1.0, ML2 = 1.5), ## Do not change
    newton = c(
      MIT = 500,         ## Maximum iterations
      IPRNT = 100,       ## Trace each IPRNT iterations
      TOLG = 1e-10)))    ## Gradient convergence tolerance

fit_sim <- vMEM::MEM(xDep = data_sim, xRet = NULL, xPred = NULL, model = model, control = control)

{
  # o.GMEM.TRUE <- c(0.40, 0.25)
  # B.GMEM.TRUE <- matrix(data=c(0.35, 0.10, 0.07, 0.30), nrow = 2, ncol = 2, byrow = T)
  # A.GMEM.TRUE <- matrix(data=c(0.27, 0.19, 0.18, 0.31), nrow = 2, ncol = 2, byrow = T)
  # 
  # Coefficient Estimates: 
  #   parameter                   estimate            s.e.          t-stat          pvalue        gradient
  # omega[1]                      3.13978963      0.18780479       16.718368      0.00000000              NA
  # omega[2]                      2.64207504      0.16184709       16.324513      0.00000000              NA
  # beta[1,1]                     0.69856276      0.11625749        6.008755      0.00000000  2.59815753e-07
  # beta[2,1]                     0.24168762      0.09667024        2.500124      0.01241497  1.19256510e-06
  # beta[1,2]                     0.21060038      0.12680420        1.660831      0.09674734  4.07090880e-07
  # beta[2,2]                     0.61185953      0.10552261        5.798373      0.00000001  9.07481914e-07
  # alpha[1,1]                    0.27057749      0.02508672       10.785688      0.00000000  3.85696965e-07
  # alpha[2,1]                    0.16325777      0.01941726        8.407869      0.00000000 -1.34013200e-06
  # alpha[1,2]                    0.16806818      0.03127120        5.374535      0.00000008  1.75399144e-07
  # alpha[2,2]                    0.32187374      0.02662396       12.089629      0.00000000 -6.94194438e-07
  # Sigma[1,1]                    0.47859449              NA              NA              NA              NA
  # Sigma[1,2]                    0.20145438              NA              NA              NA              NA
  # Sigma[2,2]                    0.42180193              NA              NA              NA              NA
  # Variance-Covariance matrix estimated via sandwich estimator 
  # 
  # Coefficient Estimates DPMLN2-vMEM: 
  # 
  # omega[1] 0.499751    (0.3703; 0.6725)
  # omega[2] 0.247714    (0.1378; 0.3405)
  # beta[1,1] 0.137292   (-0.2711; 0.4915)
  # beta[2,1] 0.103098   (-0.1511; 0.4219)
  # beta[1,2] 0.333920   (-0.0555; 0.7963)
  # beta[2,2] 0.252589   (-0.0678; 0.5170)
  # alpha[1,1] 0.253322  (0.2132; 0.2962)
  # alpha[2,1] 0.200371  (0.1758; 0.2262)
  # alpha[1,2] 0.167585  (0.1005; 0.2336)
  # alpha[2,2] 0.292701  (0.2526; 0.3317)
  # ================================================================================ 
}