## The rankhospital function returns the rank of the hospital for a given state 
## based on the rate of the given outcome.

## If multiple hospitals have the same 30-day mortality rate for a given cause
## of death, then the ranking will be alphabetical by hospital name. 

rankospital <- function(state, outcome, num = "best") {
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
        for (i in 1:nrow(data)) {
                state_data <- data[i, "State"]
                if (state_data == state) {
                        break
                } else if (i != nrow(data)) {
                        next
                } else {
                        stop("invalid state")       
                }
        }
        ## Return hospital name in that state with the given rank
        ordered <- data[order(data[, "State"], data[, column], data[, "Hospital.Name"]), ]
        by_state <- split(ordered, ordered[, "State"])
        given_state <- by_state[[state]]
        hospital_names <- given_state$Hospital.Name
        if (num == "best") {
                rank <- hospital_names[1]
        } else if (num == "worst") {
                rank <- hospital_names[length(hospital_names)]
        } else {
                rank <- hospital_names[num]
        }
        print(rank)
}