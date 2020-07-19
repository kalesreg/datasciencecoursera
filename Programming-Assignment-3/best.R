## The best function returns the name of the hospital that has the best (i.e. 
## lowest) 30-day mortality for the specified outcome in that given state.

## If there is a tie for the best hospital for a given outcome, then the 
## hospital names will be sorted in alphabetical order and the first hospital 
## in that set will be chosen.

best <- function(state, outcome) {
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
        ## Return hospital name in that state with lowest 30-day death rate
        ordered <- data[order(data[, column], data[, "Hospital.Name"]), ]
        by_state <- split(ordered, ordered[, "State"])
        given_state <- by_state[[state]]
        hospital_names <- given_state$Hospital.Name
        best <- hospital_names[1]
        print(best)
}