x <- c("ang", "abs", "polar")

oldw <- getOption("warn")
options(warn = -1)

for (expnum in 5:9) {
#expnum <- 1
#index <- 1
  library(readr)
  for (index in 1:length(x)){
    name <- x[index]
    #dataForTtest <- read_csv(paste("~/MATLAB/exp", toString(expnum), "forTtest.csv", sep = ""))
    dataForTtest <- read_csv(paste("~/MATLAB/", name, "Exp", toString(expnum), "forTtest.csv", sep = ""))
    colnames(dataForTtest) <- c("difference", "type")
    #View(dataForTtest)
    print(paste(name, "exp", toString(expnum)))
    var <- t.test(difference~type, data=dataForTtest)
    print(var)
  }
}

options(warn = oldw)