readData <- function(directory, i) {
    
    path <- paste(directory, "/", sprintf("%03d", i), ".csv", sep="")
    read.csv(path)
        
}