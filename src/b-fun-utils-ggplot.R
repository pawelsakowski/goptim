library(ggplot2)
library(reshape2)


QplotXts <- function(data.xts, plot.name = NULL) {
  # Quickly plots an xts object with multiple columns

  data.df <- data.frame(data.xts, Date = index(data.xts))
  data.melted <- melt(data.df, id = 'Date')
  p <- ggplot(data.melted, aes(x = Date, y = value, colour = variable)) +
      geom_line() +
      xlab("Date") +
      ylab("Prices")

  if (!is.null(plot.name)) {
    p <- p + ggtitle(plot.name)
  }

  #print(p)
  return(p)
}

QplotXtsBW <- function(data.xts, plot.name = NULL) {
  # Quickly plots an xts object with multiple columns

  data.df <- data.frame(data.xts, Date = index(data.xts))
  data.melted <- melt(data.df, id = 'Date')
  p <- ggplot(data.melted, aes(x = Date, y = value,
                               colour = variable,
                               linetype = variable)) +
    geom_line() +
    xlab("Date") +
    ylab("Prices")

  if (!is.null(plot.name)) {
    p <- p + ggtitle(plot.name)
  }

  #print(p)
  return(p)
}


QplotXtsSingle <- function(ts.xts, plot.name = NULL) {
  # Quickly plots single time series, most usually returns

  if (ncol(ts.xts) > 1) {
    stop("Series has more than 1 column!")
  }

  #if (sum(!is.na(ts) == 0)){
  #  stop("All observations are missing!")
  #}

  ts.df <- data.frame(Series = ts.xts, Date = index(ts.xts))
  names(ts.df) <- c("Series", "Date")
  p <- ggplot(ts.df, aes(x = Date, y = Series)) +
      geom_line() +
      xlab("Date") +
      ylab("Values")

  if (!is.null(plot.name)) {
    p <- p + ggtitle(plot.name)
  }
  #print(p)
  return(p)
}


PlotOfVariable <- function(data,
                           variable,
                           start.date = "2000-01-01"){
  ## function for desc stats of variable
  data <- data[paste0(start.date, "/"), variable]
  #title <- paste0(variable, collapse = ", " )
  show(QplotXtsSingle(data[, variable], plot.name = variable))
}

PlotOfVariableZeroMarked <- function(data,
                                     variable,
                                     start.date = "2000-01-01"){
  ## function for desc stats of variable
  data <- data[paste0(start.date, "/"), variable]
  #title <- paste0(variable, collapse = ", " )
  p <- QplotXtsSingle(data[, variable], plot.name = variable)
  p <- p + geom_hline(yintercept = 0)
  show(p)
}


