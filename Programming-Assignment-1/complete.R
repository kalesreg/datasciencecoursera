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

complete <- function(directory, id = 1:332) {
        data <- all_data(directory)
        complete_data <- data[complete.cases(data),]
        df <- data.frame()
        for (i in id) {
                complete_ids <- complete_data[which(complete_data[, "ID"] %in% i), ]
                nobs <- nrow(complete_ids)
                df <- rbind(df, c(i, nobs))
        }
        colnames(df) <- c("id", "nobs")
        return(df)
}