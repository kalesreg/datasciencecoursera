## The rankall function returns a data frame containing the hospital in each 
## state that has the ranking specified in num. 

## The rankall function handles ties in the 30-day mortality rates by listing
## the ties alphabetically in the rankings. 

rankall <- function(outcome, num = "best") {
        ## Read outcome data
        ## Check that state and outcome are valid
        ## For each state, find the hospital of the given rank
        ## Return a data frame with the hospital names and the state name
}

## Note: The function should return a value for every state (some may be NA). 
## The first column in the data frame is named hospital, which contains the 
## hospital name, and the second column is named state, which contains the 
## 2-character abbreviation for the state name. Hospitals that do not have data 
## on a particular outcome should be excluded from the set of hospitals when 
## deciding the rankings.

## NOTE: For the purpose of this part of the assignment (and for efficiency), 
## your function should NOT call the rankhospital function from the previous 
## section.