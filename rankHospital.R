## The rankhospital function returns the rank of the hospital for a given state 
## based on the rate of the given outcome.

## If multiple hospitals have the same 30-day mortality rate for a given cause
## of death, then the ranking will be alphabetical by hospital name. 

rankhospital <- function(state, outcome, num = "best") {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv")
        ## Check that state and outcome are valid
        if (tolower(outcome) == "heart attack") {
                column <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
        } else if (tolower(outcome) == "heart failure") {
                column <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
        } else if (tolower(outcome) == "pneumonia") {
                column <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
        } else {
                stop("invalid outcome")
        }
        rel_hospitals <- data.frame()
        data_added <- FALSE
        for (i in 1:nrow(data)) {
                state_data <- data[i, "State"]
                outcome_data <- data[i, column]
                if (state_data == state) {
                        if (outcome_data != "Not Available") {
                                hospital <- data[i, "Hospital.Name"]
                                rel_col <- c(hospital, outcome_data)
                                rel_hospitals <- rbind(rel_hospitals, rel_col)
                                data_added <- TRUE
                        } else if (i != nrow(data)) {
                                next
                        } else if (data_added == TRUE) {
                                break
                        } else {
                                stop("invalid outcome")
                        }
                } else if (i != nrow(data)) {
                        next
                } else if (data_added == TRUE) {
                        break
                } else {
                        stop("invalid state")       
                }
        }
        ## Return hospital name in that state with the given rank
        colnames(rel_hospitals) <- c("Hospital.Name", outcome)
        ranked <- rel_hospitals[order(as.numeric(rel_hospitals[, outcome]), 
                                rel_hospitals[, "Hospital.Name"]), ]
        last <- nrow(ranked)
        if (num == "best" || num == 1) {
                print(ranked[1, "Hospital.Name"])
        } else if (num == "worst") {
                print(ranked[last, "Hospital.Name"])
        } else if (num > last) {
                print(NA)
        } else {
                print(ranked[num, "Hospital.Name"])
        }
}