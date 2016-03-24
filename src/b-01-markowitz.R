library(SIT)

load.packages('quantmod,quadprog,corpcor,lpSolve')
load.packages('tawny')


GetFactorsToEnv <- function(factors, factors.names, env) {
  cum.factors <- factors[, factors.names]
  names(cum.factors) <- gsub(".cum", "", names(cum.factors))
  lapply(names(cum.factors), function(x) assign(x, cum.factors[, x], envir = env))
  for(i in ls(env)) {
    env[[i]] <- xts(env[[i]] %*% c(1, 1, 1, 1, 0, 1), order.by = index(env[[i]]))

    names(env[[i]]) <- c(paste0(i, ".Open"),
                         paste0(i, ".High"),
                         paste0(i, ".Low"),
                         paste0(i, ".Close"),
                         paste0(i, ".Volume"),
                         paste0(i, ".Adjusted"))
  }
  bt.prep(env, align='remove.na', dates='2000::')
  #save(data,file="data/factors_only.RData")
}

