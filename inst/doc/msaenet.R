## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  dpi = 300,
  fig.retina = 2,
  fig.width = 6,
  fig.height = 6,
  fig.align = "center",
  out.width = "65%"
)

## -----------------------------------------------------------------------------
library("msaenet")

## -----------------------------------------------------------------------------
dat <- msaenet.sim.gaussian(
  n = 150, p = 500, rho = 0.5,
  coef = rep(1, 10), snr = 5, p.train = 0.7,
  seed = 1001
)

## -----------------------------------------------------------------------------
msaenet.fit <- msaenet(
  dat$x.tr, dat$y.tr,
  alphas = seq(0.1, 0.9, 0.1),
  nsteps = 10L, tune.nsteps = "ebic",
  seed = 1005
)

## ----eval=FALSE---------------------------------------------------------------
#  library("doParallel")
#  registerDoParallel(detectCores())

## -----------------------------------------------------------------------------
msaenet.fit$best.step
msaenet.nzv(msaenet.fit)
msaenet.nzv.all(msaenet.fit)
msaenet.fp(msaenet.fit, 1:10)
msaenet.tp(msaenet.fit, 1:10)

## -----------------------------------------------------------------------------
msaenet.pred <- predict(msaenet.fit, dat$x.te)
msaenet.rmse(dat$y.te, msaenet.pred)
msaenet.mae(dat$y.te, msaenet.pred)

## -----------------------------------------------------------------------------
plot(msaenet.fit, label = TRUE, label.cex = 0.5)

## -----------------------------------------------------------------------------
plot(msaenet.fit, type = "criterion")

## -----------------------------------------------------------------------------
plot(msaenet.fit, type = "dotplot", label = TRUE, label.cex = 1)

