
load("dane/close.price.USD.weekly.RData")
load("dane/close.price.weekly.RData")
load("dane/currencies.daily.RData")
load("dane/currencies.weekly.RData")

load("dane/indices.daily.list.RData")
load("dane/indices.daily.RData")
load("dane/rfr.daily.RData")
load("dane/rfr.weekly.RData")


library(xts)
str(close.price.weekly)
head(close.price.weekly)
