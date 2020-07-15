## The rankhospital function returns the rank of the hospital for a given state 
## based on the rate of the given outcome.

## If multiple hospitals have the same 30-day mortality rate for a given cause
## of death, then the ranking will be alphabetical by hospital name. 

rankhospital <- function(state, outcome, num = "best") {
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
        ## Return hospital name in that state with the given rank 
}

## Note: The num argument can take values “best”, “worst”, or an integer 
## indicating the ranking (smaller numbers are better). If the number given by 
## num is larger than the number of hospitals in that state, then the function 
## should return NA.