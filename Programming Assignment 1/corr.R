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

corr <- function(directory, threshold = 0) {
        file_comp <- complete(directory)
        file_thresh <- file_comp[file_comp[, 2] > threshold, ]
        files <- list.files(directory, full.names = TRUE)
        data <- all_data(directory)
        ids <- na.omit(data[data[, "ID"] %in% file_thresh[, "id"], ])
        correlation <- vector()
        for (i in file_thresh[, "id"]) {
                this_id <- ids[ids[, "ID"] == i, ]
                correlation <- append(correlation, cor(this_id$sulfate, this_id$nitrate))
        }
        return(correlation)
}