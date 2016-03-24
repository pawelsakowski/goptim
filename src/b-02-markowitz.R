source('src/b-01-markowitz.R')
source('src/b-fun-utils-ggplot.R')
source('src/b-fun-utils-file.R')

load("data/close.price.USD.weekly.RData")
factors <- close.price.USD.weekly
# factors$RmRf.cum <- 100 * cumprod(1 + factors$RmRf)

lookback <- 52
env <- new.env()
factors.names <- names(factors)

GetFactorsToEnv(factors, factors.names = factors.names, env = env)

obj <-
  portfolio.allocation.helper(env$prices,
                              periodicity = 'quarters',
                              lookback.len = lookback,
                              min.risk.fns = list(
                                EW = equal.weight.portfolio,
                                MV = min.var.portfolio,
                                MS = max.sharpe.portfolio(),
                                TRET.12 = target.return.portfolio(12/100),
                                TRISK.8 = target.risk.portfolio(8/100)
                              )
  )


models <- create.strategies(obj, env)$models
models <- rev(models)
equity.lines <- lapply(models, function(x) x$equity)
equity.lines <- do.call("cbind", equity.lines)
names(equity.lines) <- names(models)

# Assumptions:
#
# * Equally Wighted, Max Sharpe, Min Variance, Target Return 15% and Target Risk 5%
# * long only
# * lookback `r lookback/52` years
# * quarterly rebalanced

QplotXtsBW(env$prices, "Inputs to Markowitz Optimization - Investable indices based on risk factors")

## All
desc.stats <- plotbt.strategy.sidebyside(models, return.table=T)[-c(1, 4, 7, 10), ]
save.xlsx('out/xlsx/markowitz-stats.xlsx',  desc.stats)

# Equity lines
QplotXtsBW(equity.lines, "Performance of Markowitz Optimization algorithms")
plotbt.custom.report.part1(models)

## Equally Weighted (EW)
plotbt.custom.report.part1(models$EW, trade.summary = T)
plotbt.custom.report.part2(models$EW, trade.summary = T)

## Min Variance (MV)
plotbt.custom.report.part1(models$MV, trade.summary = T)
plotbt.custom.report.part2(models$MV, trade.summary = T)

## Max Sharpe (MS)
plotbt.custom.report.part1(models$MS, trade.summary = T)
plotbt.custom.report.part2(models$MS, trade.summary = T)

## Target Return (TRET.12)
plotbt.custom.report.part1(models$TRET.12, trade.summary = T)
plotbt.custom.report.part2(models$TRET.12, trade.summary = T)

## Target Risk (TRISK.8)
plotbt.custom.report.part1(models$TRISK.8, trade.summary = T)
plotbt.custom.report.part2(models$TRISK.8, trade.summary = T)
