
oldw <- getOption("warn")
options(warn = -1)

for (expnum in 1:9) {
  library(readr)
  crockerDifferences <- read_csv(paste("~/MATLAB/FrobeniusExp", toString(expnum), "forConfidence.csv", sep = ""))
  colnames(crockerDifferences) <- c("naive", "model")
  print(paste("exp", toString(expnum)))
  mean1 <- mean(crockerDifferences$naive)
  #10 = sqrt(100), we have 100 samples for each
  #1.96 is the z value for 95% confidence
  sd1 <- sd(crockerDifferences$naive)
  radius1 <- 1.96*sd1/10
  print("naive")
  print(paste("mean", toString(mean1)))
  #print(paste("standard deviation", toString(sd1)))
  print(paste("confidence radius", toString(radius1)))

  
  mean2 <- mean(crockerDifferences$model)
  sd2 <- sd(crockerDifferences$model)
  radius2 <- 1.96*sd2/10
  print("model")
  print(paste("mean", toString(mean2)))
  #print(paste("standard deviation", toString(sd2)))
  print(paste("confidence radius", toString(radius2)))
  
}

options(warn = oldw)