## ------------------------------------------------------------------------
library("msaenet")

## ------------------------------------------------------------------------
dat = msaenet.sim.gaussian(n = 150, p = 500, rho = 0.6,
                           coef = rep(1, 5), snr = 2, p.train = 0.7,
                           seed = 1001)

## ------------------------------------------------------------------------
msaenet.fit = msaenet(dat$x.tr, dat$y.tr,
                      alphas = seq(0.1, 0.9, 0.1),
                      nsteps = 4L, seed = 1003)

## ---- eval=FALSE---------------------------------------------------------
#  library(doParallel)
#  registerDoParallel(detectCores())

## ------------------------------------------------------------------------
msaenet.nzv(msaenet.fit)
msaenet.fp(msaenet.fit, 1:5)
msaenet.tp(msaenet.fit, 1:5)

## ------------------------------------------------------------------------
msaenet.pred = predict(msaenet.fit, dat$x.te)
msaenet.rmse(dat$y.te, msaenet.pred)
msaenet.mae(dat$y.te, msaenet.pred)

## ---- fig.width = 8, fig.height = 8, out.width = 600, out.height = 600----
plot(msaenet.fit)

