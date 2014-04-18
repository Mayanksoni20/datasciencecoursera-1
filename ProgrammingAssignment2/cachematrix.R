## These functions compute the inverse of a matrix and stores it in a cache for future use.

## makeCacheMatrix takes in a matrix, and returns a list of subfunctions to either 
## 1) set the value of the matrix
## 2) get the current value of the matrix
## 3) get the inverse of the matrix
## 4) set the inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    get <- function() x
    setinv <- function(inverse) inv <<- inverse 
    getinv <- function() inv
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
}


## cacheSolve checks to see if the inverse of the matrix has been previously computed and cached. 
### If so, it returns the cached value. Otherwise, it computes the inverse.
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
    inv <- x$getinv()
    if(!is.null(inv)) {
        message("getting cached data")
        return(inv)
    }
    data <- x$get()
    inv <- solve(data, ...)
    x$setinv(inv)
    inv
}

### here is some code I used to test the data
b=makeCacheMatrix(matrix(c(1,0,0,1),2,2))  ### getting the special matrix
cacheSolve(b)  ### calculating the inverse
b$getinv()  ### checking that the inverse in cache is the one calculated above
b$setinv(3)  ## setting the inverse to 3
cacheSolve(b) ### should return 3, as I set it to 3 in the above line