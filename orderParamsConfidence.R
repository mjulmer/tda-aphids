params <- c("ang", "abs", "polar")

oldw <- getOption("warn")
options(warn = -1)
expNumber <- 1:9

for (index in 1:length(params)){
  whichParam <- params[index]
  
  meanNaive <- numeric(9)
  meanModel <- numeric(9)
  radiusNaive <- numeric(9)
  radiusModel <- numeric(9)
  
  library(readr)
  
   for (expnum in 1:9){
    
    #dataForTtest <- read_csv(paste("~/MATLAB/exp", toString(expnum), "forTtest.csv", sep = ""))
    confidenceData <- read_csv(paste("~/MATLAB/", whichParam, "Exp", toString(expnum), "forConfidence.csv", sep = ""))
    colnames(confidenceData) <- c("naive", "model")
    #View(dataForTtest)
    
    
    #print(paste(whichParam, "exp", toString(expnum)))
    #var <- t.test(difference~type, data=dataForTtest)
    #print(var)
    
    print(paste("exp", toString(expnum)))
    print(paste("order param", whichParam))
    
    meanNaive[expnum] <- mean(confidenceData$naive)
    #10 = sqrt(100), we have 100 samples for each
    #1.96 is the z value for 95% confidence
    sd1 <- sd(confidenceData$naive)
    radiusNaive[expnum] <- 1.96*sd1/10
    print("naive")
    print(paste("mean", toString(meanNaive[expnum])))
    #print(paste("standard deviation", toString(sd1)))
    print(paste("confidence radius", toString(radiusNaive[expnum])))
    
    
    meanModel[expnum] <- mean(confidenceData$model)
    sd2 <- sd(confidenceData$model)
    radiusModel[expnum] <- 1.96*sd2/10
    print("model")
    print(paste("mean", toString(meanModel[expnum])))
    #print(paste("standard deviation", toString(sd2)))
    print(paste("confidence radius", toString(radiusModel[expnum])))
    
    
   }
  
  
  confidence.data <- data.frame(expNumber, meanNaive, radiusNaive, meanModel, radiusModel)
  write.csv(confidence.data,  file = paste("~/MATLAB/", whichParam, "MeansRadii.csv", sep = ""),row.names=FALSE)

}


options(warn = oldw)