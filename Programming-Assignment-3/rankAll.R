## The rankall function returns a data frame containing the hospital in each 
## state that has the ranking specified in num. 

## The rankall function handles ties in the 30-day mortality rates by listing
## the ties alphabetically in the rankings. 

rankall <- function(outcome, num = "best") {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", 
                         na.strings = 'Not Available', 
                         stringsAsFactors = FALSE)
        ## Check that state and outcome are valid
        outcomes <- c('heart attack' = 11, 'heart failure' = 17, 'pneumonia' = 23) 
        if (tolower(outcome) == "heart attack") {
                column <- outcomes['heart attack']
        } else if (tolower(outcome) == "heart failure") {
                column <- outcomes['heart failure']
        } else if (tolower(outcome) == "pneumonia") {
                column <- outcomes['pneumonia']
        } else {
                stop("invalid outcome")
        }
        ## Return hospital name in that state with the given rank
        ordered <- data[order(data[, "State"], data[, column], data[, "Hospital.Name"]), ]
        by_state <- split(ordered, ordered[, "State"])
        
        states <- unique(ordered$State)
        num_states <- c(1:length(states))
        hospital_data <- sapply(num_states, function(x) by_state[[x]]["Hospital.Name"])
        ranking <- function(x, num) {
                if (num == "best") {
                        hospital_name <- hospital_data[[x]][1]
                } else if (num == "worst") {
                        num_hosp <- length(hospital_data[[x]])
                        hospital_name <- hospital_data[[x]][num_hosp]
                } else {
                        hospital_name <- hospital_data[[x]][num]
                }
                return(hospital_name)
        }
        hospital_names <- sapply(num_states, function(x) ranking(x, num))
        ranks <- data.frame(hospital_names, states)
        colnames(ranks) <- c("hospital", "state")
        return(ranks)
}