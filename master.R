#### Global Portfolio Optimization
#### master file
#### 2016-03-24

rm(list = ls())

## a - first approach
# source("src/a-01.R") #load data
# source("src/a-02-portfolio.R") #load data
# source("src/a-03-min_variance.R") #load data


## b - Systematic Investor approach
source("src/b-fun-utils-file.R")
source("src/b-fun-utils-ggplot.R")
source("src/b-01-markowitz.R")
KnitIt("src/b-02-markowitz.Rmd")

## c - other
## source("src/c-zivot-examples.R")

