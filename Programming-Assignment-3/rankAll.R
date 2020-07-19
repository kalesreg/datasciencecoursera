## The rankall function returns a data frame containing the hospital in each 
## state that has the ranking specified in num. 

## The rankall function handles ties in the 30-day mortality rates by listing
## the ties alphabetically in the rankings. 

rankall <- function(outcome, num = "best") {
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
        rel_data <- data.frame()
        data_added <- FALSE
        for (i in 1:nrow(data)) {
                state_data <- data[i, "State"]
                outcome_data <- data[i, column]
                if (outcome_data != "Not Available") {
                        hospital <- data[i, "Hospital.Name"]
                        rel_col <- c(hospital, state_data, outcome_data)
                        rel_data <- rbind(rel_data, rel_col)
                        data_added <- TRUE
                } else if (i != nrow(data)) {
                        next
                } else if (data_added == TRUE) {
                        break
                } else {
                        no_data <- c("NA", state_data, 1)
                        rel_data <- rbind(rel_data, no_data)
                }
        }
        ## For each state, find the hospital of the given rank
        colnames(rel_data) <- c("hospital", "state", outcome)
        ranked <- rel_data[order(rel_data[, "state"],
                                 as.numeric(rel_data[, outcome]), 
                                 rel_data[, "hospital"]), ]
        rel_col <- c("hospital", "state")
        ranks <- data.frame()
        state <- ranked[1, "state"]
        cur_state <- data.frame()
        ranking <- function(num) {
                if (num == "best" || num == 1) {
                        rel_row <- cur_state[1, rel_col]
                        ranks <<- rbind(ranks, rel_row)
                } else if (num == "worst") {
                        rel_row <- cur_state[nrow(cur_state), rel_col]
                        ranks <<- rbind(ranks, rel_row)
                } else if (num > nrow(cur_state)) {
                        rel_row <- c("NA", state)
                        ranks <<- rbind(ranks, rel_row)
                        colnames(ranks) <<- rel_col
                } else {
                        rel_row <- cur_state[num, rel_col]
                        ranks <<- rbind(ranks, rel_row)
                }
        }
        for (i in 1:nrow(ranked)) {
                if (i != nrow(ranked) && ranked[i, "state"] == state) {
                        rel_state <- ranked[i, rel_col]
                        cur_state <- rbind(cur_state, rel_state)
                } else if (i != nrow(ranked) && ranked[i, "state"] != state) {
                        ranking(num)
                        cur_state <- data.frame()
                        state <- ranked[i, "state"]
                        rel_state <- ranked[i, rel_col]
                        cur_state <- rbind(cur_state, rel_state)
                } else if (i == nrow(ranked) && ranked[i, "state"] == state) {
                        rel_state <- ranked[i, rel_col]
                        cur_state <- rbind(cur_state, rel_state)
                        ranking(num)
                } else {
                        cur_state <- data.frame()
                        rel_state <- ranked[i, rel_col]
                        cur_state <- rbind(cur_state, rel_state)
                        ranking(num)
                }
        }
        ## Return a data frame with the hospital names and the state name
        return(ranks)
}