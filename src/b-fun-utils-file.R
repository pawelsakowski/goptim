KnitIt <- function(filename) {
  # Searches for file, assuming working dir in 'src/',
  # and places output in 'out/html/'
  #
  # Args:
  #   filename - name of an .Rmd file to be transformed into .html

  # if directories exist, nothing happens
  dir.create('out', showWarnings = F)
  dir.create('out/html', showWarnings = F)

  fname <- strsplit(basename(filename), '.', fixed = T)[[1]][1]
  html <- paste0('out/html/', fname, format(Sys.time(), '-%Y-%m-%d'), '.html')
  knitr::knit2html(filename, html, force_v1 = TRUE
                   )

  # cleaning compilation remainings
  unlink(paste0('src/',fname, '.md'))
  file.remove(paste0(fname, '.md'))
  unlink('figure', recursive = T)
}

# this is because sometimes problems with Java
# may cause this library to load incorrectly
if (require(xlsx)) {
  # addtional function to save multiple objects into one workbook
  save.xlsx <- function (file, ...) {
      require(xlsx, quietly = TRUE)
      objects <- list(...)
      fargs <- as.list(match.call(expand.dots = TRUE))
      objnames <- as.character(fargs)[-c(1, 2)]
      nobjects <- length(objects)
      for (i in 1:nobjects) {
          if (i == 1)
              write.xlsx(objects[[i]], file, sheetName = objnames[i])
          else write.xlsx(objects[[i]], file, sheetName = objnames[i],
                          append = TRUE)
      }
      print(paste("Workbook", file, "has", nobjects, "worksheets."))
  }
}