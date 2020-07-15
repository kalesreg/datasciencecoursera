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
        for (i in 1:nrow(data)) {
                state_data <- data[i, "State"]
                outcome_data <- data[i, column]
                if (state_data == state) {
                        if (outcome_data != "Not Available") {
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
        col <- c("Hospital.Name", column)
        rel_data <- data[, col]
        rel_hospitals <- data.frame()
        for (i in 1:nrow(data)) {
                
        }
        ##hospital_name <- data[min(data[, column], na.rm = TRUE), "Hospital.Name"]
        ##print(hospital_name)
}
