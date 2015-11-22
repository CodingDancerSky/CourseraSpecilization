corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations
        
        source("readData.R")
        source("complete.R")
        
        complete <- complete(directory)
        data <- complete[complete$nobs > threshold, ]
        
        correlation <- numeric(0)
        
        for(i in data$id){
                csv <- readData(directory, i)
        	        	    
                row <- !is.na(csv$sulfate) & !is.na(csv$nitrate)
        	        	    
                subset <- csv[row, ]
        	        	    
        	        	    
                correlation <- c(correlation, cor(subset $sulfate, subset $nitrate))
        }
        
        correlation
}