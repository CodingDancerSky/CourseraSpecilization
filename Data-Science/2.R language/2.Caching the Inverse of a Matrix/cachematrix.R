## Function: inverse a square matrix

## This function works like a class in JAVA, 
## it contains 4 member functions: set, get, setInverseMatrix, getInverseMatrix.
## <<- assignment operator is to make the internal variables just be in the current evirnoment 

makeCacheMatrix <- function(x = matrix()) {
	m <- NULL
	set <- function(y){
		x <<- y
		m <<- NULL
	}
    
	get <- function() x
	setInverseMatrix <- function(inv) m<<-inv
	getInverseMatrix <- function() m
	list(set = set, get = get,
		 setInverseMatrix = setInverseMatrix,
		 getInverseMatrix = getInverseMatrix)
}

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        m <- x$getmean()
        if(!is.null(m)){
        	message("getting cached inversed matrix")
        	return(m)
        }
        newMatrix <- x$get()
        m <- inv(newMatrix, ...)
        x$setInverseMatrix(m)
        m
}
