load("dane/close.price.USD.weekly.RData")

#install.packages("quadprog")

#install.packages("PortfolioAnalytics")

source("src/a-02-portfolio.R")
library(xts)
library(timeSeries)
library(fPortfolio)
library(PortfolioAnalytics)
library(quadprog)

# assets <- (as.data.frame(close.price.USD.weekly[1:12,]))
assets <- close.price.USD.weekly[1:12,]
assets <- diff.xts(log(assets))
assets <- assets[-1, ]
str(assets)
length(assets)
clean.assets <- assets[ , colSums(is.na(assets)) == 0] #usuwanie wierszy z NA#
clean.assets <- clean.assets[ , c(1:9)]
length(clean.assets)
er <- colMeans(clean.assets)
length(er)
covmat <- var(clean.assets,na.rm=FALSE)
cormat <- cor(clean.assets)
tmp  <- which(cormat > 0.98, arr.ind = T)
gmin.port <- globalMin.portfolio(er, covmat)

cov.mat <- covmat
chol(cov.mat)
?chol

attributes(gmin.port)
plot(gmin.port)
ef <- efficient.frontier(er, covmat, alpha.min=-2,
                         + alpha.max=1.5, nport=20)
attributes(ef)
plot(ef)

##### to samo dla kolejnych 12 obserwacji
assets <- (as.data.frame(close.price.USD.weekly[13:24,]))
clean.assets <- assets[, colSums(is.na(assets)) == 0]#usuwanie wierszy z NA#
er <- colMeans(clean.assets)
covmat <- var(clean.assets,na.rm=FALSE)

gmin.port <- globalMin.portfolio(er, covmat)

attributes(gmin.port)
plot(gmin.port)
ef <- efficient.frontier(er, covmat, alpha.min=-2,
                         + alpha.max=1.5, nport=20)
attributes(ef)
plot(ef)

##### to samo dla kolejnych 12 obserwacji
assets <- (as.data.frame(close.price.USD.weekly[25:36,]))
clean.assets <- assets[, colSums(is.na(assets)) == 0]#usuwanie wierszy z NA#
er <- colMeans(clean.assets)
covmat <- var(clean.assets,na.rm=FALSE)

gmin.port <- globalMin.portfolio(er, covmat)

attributes(gmin.port)
plot(gmin.port)
ef <- efficient.frontier(er, covmat, alpha.min=-2,
                         + alpha.max=1.5, nport=20)
attributes(ef)
plot(ef)

#Ta funkcja liczy nie MVP, ale też nie działa dla 13 indeksów

#minvariance <- function(assets, mu = 0.005) {
# return <- log(tail(assets, -1) / head(assets, -1))
#  Q <- rbind(cov(return), rep(1, ncol(assets)),
#             colMeans(return))
#  Q <- cbind(Q, rbind(t(tail(Q, 2)), matrix(0, 2, 2)))
#  b <- c(rep(0, ncol(assets)), 1, mu)
#  solve(Q, b)
#}