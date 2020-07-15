## The best function reads the outcome-of-care-measures.csv file and returns a 
## character vector with the name of the hospital that has the best 
## (i.e. lowest) 30-day mortality for the specified outcome in that state.

best <- function(state, outcome) {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv")
        if (tolower(outcome) == "heart attack") {
                column <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
        }
        if (tolower(outcome) == "heart failure") {
                column <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
        }
        if (tolower(outcome) == "pneumonia") {
                column <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
        }
        ## Check that state and outcome are valid
        for (i in 1:nrow(data)) {
                state_data <- data[i, "State"]
                outcome_data <- data[i, column]
                if (state_data == state) {
                        if (!is.null(column) && outcome_data != "Not Available") {
                                break
                        } else if (i != nrow(data)) {
                                next
                        } else {
                                stop("invalid outcome")
                        }
                        break
                } else if (i != nrow(data)) {
                        next
                } else {
                        stop("invalid state")       
                }
        }
        ## Return hospital name in that state with lowest 30-day death rate
        ##rel_data <- 
        ##hospital_name <- data[min(data[, column], na.rm = TRUE), "Hospital.Name"]
        ##print(hospital_name)
}
