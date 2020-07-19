## makeCacheMatrix and cacheSolve work together to determine the inverse of a 
## given matrix and save the inverse matrix in cached data. 

## makeCacheMatrix makes a list of functions to create, set, and get a matrix 
## to be used in the cacheSolve function below. 

makeCacheMatrix <- function(x = matrix()) {
        m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        get <- function() x
        setmatrix <- function(matrix) m <<- matrix
        getmatrix <- function() m
        list(set = set, get = get,
             setmatrix = setmatrix,
             getmatrix = getmatrix)
}


## cacheSolve either computes the inverse of the matrix created by the 
## makeCacheMatrix function above and saves it in cached data using setmatrix
## or retrieves the inverse matrix created by a previous call of cacheSolve 
## from the cache using getmatrix.

cacheSolve <- function(x, ...) {
        m <- x$getmatrix()
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        data <- x$get()
        m <- solve(data, ...)
        x$setmatrix(m)
        m
}
