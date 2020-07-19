all_files <- function(directory) {
        files <- list.files(directory, full.names = TRUE)
}

all_data <- function(directory) {
        files <- all_files(directory)
        data <- data.frame()
        for (i in 1:332) {
                data <- rbind(data, read.csv(files[i]))  
        }
        return(data)
}

pollutantmean <- function(directory, pollutant, id = 1:332){
        data <- all_data(directory)
        subset <- data[which(data[, "ID"] %in% id), ]
        mean(subset[, pollutant], na.rm = TRUE)
}