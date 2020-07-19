## The best function returns the name of the hospital that has the best (i.e. 
## lowest) 30-day mortality for the specified outcome in that given state.

## If there is a tie for the best hospital for a given outcome, then the 
## hospital names will be sorted in alphabetical order and the first hospital 
## in that set will be chosen.

best <- function(state, outcome) {
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
        ## Return hospital name in that state with lowest 30-day death rate
        colnames(rel_hospitals) <- c("Hospital.Name", outcome)
        lowest <- min(as.numeric(rel_hospitals[, outcome]))
        low_hospitals <- vector()
        for (i in 1:nrow(rel_hospitals)) {
                if (as.numeric(rel_hospitals[i, outcome]) == lowest) {
                        hospital_name <- rel_hospitals[i, "Hospital.Name"]
                        low_hospitals <- c(low_hospitals, hospital_name)
                }
        }
        if (length(low_hospitals) == 1) {
                print(low_hospitals)
        } else {
                sort_hospitals <- sort(low_hospitals)
                print(sort_hospitals[1])
        }
}