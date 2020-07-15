---
title: "R Programming - What I Learned"
author: "Kaley Regner"
date: "6/24/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Week 1 - What I Learned 

R was derived from S. R is open source, so it is free and users can add to it. 
R is meant to be able to be used by data analysts who are and are not familiar 
with programming.  

## Resources to keep in mind:
* [CRAN manuals](https://cran.r-project.org/manuals.html)
* [Basic R Cheat Sheet](https://rstudio.com/wp-content/uploads/2016/10/r-cheat-sheet-3.pdf)
* [RMarkdown Cheat Sheet](https://rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)
* [Forms of the Extract Operator](https://github.com/lgreski/datasciencectacontent/blob/master/markdown/rprog-extractOperator.md)

## Basics
* "<-" is the assignment operator.
* "#" is the comment operator. 
* The five basic classes of objects are: character, numeric, integer, complex, 
and logical.
* A vector can only contain objects of the same class. A list is an exception, 
meaning it can contain objects of different classes.
* Add the "L" suffix to specify that a number is an integer instead of a 
numeric object. 
* "Inf" is infinity. "NaN" is an undefined value or not a number. 
* R objects can have attributes, such as : names/dimnames, dimensions, class, 
length, or other user-defined attributes. Attributes can be access using the 
"attributes()" function.
* "c()" function can be used to create vectors by concatenating objects 
together. 
* If you try to mix different classes of objects, coercion occurs so that every
element in the vector is of the same class. You can also change the class of an
object manually through explicit coercion using the "as.*" function.
* Matrices are vactors with a dimension attribute. They are constructed 
column-wise, meaning numbers run down instead of sideways. 
  + Vectors can be turned into matrices by adding a dimension attribute. Use 
  "dim(*) <- c(#r, #c)".
  + Matrices can also be created by column-binding or row-binding with 
  "cbind()" and "rbind()" functions. 
* Create a list using "list()" function.
* "ls()" lists all the variables in your workspace.
* "class()" tells you the class of the variable.
* "dim()" tells you the number of rows/observations and columns/variables.
* "object.size()" tells you how much space the dataset is occupying in memory.
* "names()" creates a character vector of the column names. 
* "head()" allows you to preview the top of the dataset.
* "tail()" allows you to preview the end of the dataset.
* "summary()" provides information about each variable in the dataset, 
including how it is distributed and how much of the dataset is missing. 

## Getting into the Data
* Use "is.na()" to test objects if they are "NA."
* Use "is.nan()" to test objects for "NaN."
* Data frames can store different classes of objects in each column. They have 
column names and row names. Often created using "read.table()" or "read.csv()".
They can be created manually using "data.frame()". 
* Calculating Memory Requirements for R Objects: (#r * #c * 
8bytes/numeric)/(2^20^)/(1000) = amount of RAM required. Double it to determine
how much RAM you need to read in a large dataset. 

### Subsetting R Objects
* The single bracket operator always returns an object of the same class as the
original. It can be used to select multiple elements of an object.
* The double bracket operator is used to extract elements of a list or a data 
frame. It can only be used to extract a single element and the class of the 
returned object will not necessarily be a list or data frame.
* The "$" operator is used to extract elements of a list or data frame by 
literal name. Its semantics are similar to that of the double bracket. 
* Use "complete.cases(*)" to mark NA values as FALSE. Then, take a subset of 
the data marked TRUE.

####Examples
Reading in the data and showing the first 10 rows and one specific value:
```{r}
data <- read.csv("hw1_data.csv")

data[1:10, ]

data[47,1]
```

Determining the number of missing values in the first column:
```{r}
ozone <- data[, 1]
misozone <- is.na(ozone)
sum(misozone)
```

Mean of the first column, excluding missing values:
```{r}
compozone <- ozone[complete.cases(ozone)]
mean(compozone)
```

Determining the mean of Solar.R using a subset of data where we are looking for Ozone values above 31 and Temp values above 90, excluding missing values:
```{r}
theCols <- c("Ozone", "Solar.R", "Temp")
q18 <- data[, theCols]
subq18 <- q18[q18$Ozone > 31 & q18$Temp > 90, ]
comsubq18 <- subq18[complete.cases(subq18), ]
mean(comsubq18$Solar.R)
```

Mean of Temp when the month is 6:
```{r}
theCols <- c("Temp", "Month")
q19 <- data[, theCols]
june <- q19[q19$Month == 6, ]
compjune <- june[complete.cases(june), ]
mean(compjune$Temp)
```

Max Ozone value in the Month of May:
```{r}
theCols <- c("Ozone", "Month")
q20 <- data[, theCols]
may <- q20[q20$Month == 5, ]
compmay <- may[complete.cases(may),]
max(compmay$Ozone)
```

# Week 2 - What I Learned

Overview of Control Structures, Functions, and Scoping. 

## Control Structures

Control Structures are used to control the flow of an R program. 

### If - Else

If-Else is used for testing of logical conditions. The else potion is optional.
Structure:

if(condition) {
        ## do something
} else if {
        ## do something different
} else {
        #do something different
}

Example:

```{r}
if(x > 3) {
        y <- 10
} else {
        y <- 0
}
```

### For Loops

For loops are used for executing a loop a fixed number of times. Structure :

for(i in ##sequence of numbers) {
        ## do something
}

Example:
```{r}
x <- c("a", "b", "c", "d")

for(i in 1:4) {
print(x[i])
}
```

For loops can be nested, so you can have a for loop inside a for loop. For 
readability, limit nesting to 2 or 3 levels. 

### While Loops

While loops are used for executing a loop while a condition is true. Structure:

while(##some condition) {
        ## Do something
}

Example:
```{r}
count <- 0

while(count < 10) {
        print(count)
        count <- count + 1
}
```

While loops can potentially result in an infinite loop if not written properly.

### Repeat, Next, Break

Repeat allows you to execute an infinite loop. Structure:

repeat {
        ## do something
}

Must call Break in order to break our of a repeat loop.

Next skips to the next iteration. Example:

for(i in 1:100) {
        if(i <= 20) {
                ## Skip the first 20 iterations
                next
        }
        ## Do something
}

## Functions

Functions are used to do more complex tasks. They are used to encapsulate a 
sequence of expressions that need to be executed numerous times. Usually 
They are written in a script separate from the console. The console tends to be
more interactive, so it makes sense to keep functions separated. 

Structure:

'##object name <- funtion(##arguments and defaults) {
        ## do something
}

Example:

```{r}
add2 <- function(x, y) {
        x + y
}
```

## Scoping

When R tries to bind a value to a symbol, it searches through a series of 
environments to find the appropriate value. The order in which things occur is 
roughly: 1) search the global environment for a symbol name matching the one 
requested and 2) search the namespaces of each of the packages on the search 
list. 

Lexical scoping means that the values of free variables are searched for in the
environment in which the function was defined, then the parent environment, and
so on. 

## Other Important Things I Learned This Week

* Create a list of files: list.files("##folder path", full.names=TRUE)
* Reading in a bunch of files from a folder and combining them:
files_list <- list.files(directory, full.names=TRUE)
data <- data.frame()
for (i in 1:5) {
        # loops through the files, rbinding them together
        data <- rbind(data, read.csv(files_list[i]))
}

# Week 3 - What I Learned

Overview of loop functions and debugging.

## lapply - Loop function

lapply is used to loop over a list of objects and apply a function to every 
element of that list. Structure:

lapply <- function (X, FUN, ...) {
        FUN <- match.fun(FUN)
        if (!is.vector(X) || is.object(X)) {
                X <- as.list(X)
        }
        .Internal(lapply(X, FUN))
}

To use lapply, you would do lapply(## some list, ## some function, ## any 
arguments that go with the function)

Example:
```{r}
x <- list(a = 1:5, b = rnorm(10))
lapply(X, mean)
```

## sapply - Loop function

sapply is a variant of lapply that simplifies the results. If lapply were to 
return a list where every element is a length 1, then sapply will return it as 
a vector of all of those elements. If lapply were to return a list where every 
element is a vector of the same length, then sapply will return it is a matrix.

Example:
```{r}
x <- list(a = 1:5, b = rnorm(10))
sapply(X, mean)
```

## split

Split splits objects into sub-pieces. It doesn't apply anything to objects, but
it's often useful in conjunction with functions like lapply or sapply.

Structure:
split <- function (x, f, drop = FALSE, ...)
X is a vector or list or data frame.
f is a factor or coerced to one or a list of factors.
drop indicates whether empty factors levels should be dropped. 

Example:
```{r}
library(datasets)
head(airquality)
s <- split(airquality, airquality$Month)
str(s)
lapply(s, function(x) {
        colMeans(x[, c("Ozone", "Solar.R", "Wind")])
})
sapply(s, function(x) {
        colMeans(x[, c("Ozone", "Solar.R", "Wind")])
})
sapply(s, function(x) {
        colMeans(x[, c("Ozone", "Solar.R", "Wind")],
        na.rm = TRUE)
})
```

## tapply - Loop function

tapply is short for table apply. It applies a function over subsets of a 
vector. 

Structure:
tapply <- function (X, INDEX, FUN = NULL, ..., simplify = TRUE)
X is a vector.
INDEX is a factor or a list of factors.
FUN is a function to be applied.
... contains other arguments to be passed FUN.

Example:
```{r}
x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- g1(3, 10)
f
tapply(x, f, mean)
tapply(x, f, mean, simplify = FALSE)
```

## mapply - Loop function

mapply is a multivariate version of lapply, which applies a function in 
parallel over a set of arguments. 

Structure:
mapply <- function (FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE, USE.NAMES = 
TRUE)
FUN is a function to apply.
... contains R objects to apply over.
MoreArgs is a list of other arguments to FUN.
SIMPLIFY indicates whether the results should be similified. 

Example:
Instead of list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1)),
```{r}
mapply(rep, 1:4, 4:1)
```

## apply - Loop function

apply is a function that operates over the margins of an array. It is used to 
apply a function to the rows or columns of a matrix, which is a 2D array.

Structure:
apply <- function (X, MARGIN, FUN, ...)
X is an array.
MARGIN is an integer vector indicating which margins should be "retained."
FUN is a function to be applied.
... is for other arguments to be passed to FUN.

Example:
```{r}
x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean) ## Take the mean of each column.
apply(x, 1, sum) ## Take the mean of each row.
```

rowSums = apply(x, 1, sum)
rowMeans = apply(x, 1, mean)
colSums = apply(x, 2, sum)
colMeans = apply(x, 2, mean)

## Debugging Tools

There are three main types of indications. The first is a message, which is a 
tame notification. It does not stop your function from executing, it just 
prints and keeps going.

The next level up is a warning, which is an indication that something 
unexpected happened that isn't necessarily a problem. The execution of the 
function will continue and the warning will print at the end.

An error is a fatal problem, it stops the execution of the function. 

The traceback debugging tool prints out the function call stack after an error 
occurs. 

The debug function tool allows you to work through the function line by line, 
which allows you to pinpoint the specific line of code when the error occurs. 
Browser suspends the execution of a function wherever it is called and puts the
function in debug mode. 
"n" executes the current expression and moves to the next expression.
"c" continues execution of the function and does not stop until either an error
or the function exits.
"Q" quits the browser.
If you call debug on a function, you have to call undebug() to turn it off.

## Other Important Things I Learned This Week
* A cache is a way to store objects in memory to accelerate subsequent access 
to the same object. More here: https://github.com/lgreski/datasciencectacontent/blob/master/markdown/rprog-breakingDownMakeVector.md
*Regular Expressions:
  * Metacharaters:
    * "^"" represents the start of a line.
    * "$"" represents the end of a line.
    * "[]" represents a character class. When "^" is used in a character class,
    it means not.
    * "." is used to refer to any character. You may need to preceed it with a 
    "\" to show that you are looking for a literal period instead of the 
    metacharacter for any character. 
    * "|" represents "or".
    * "( and )" group two conditions together.
    * "?" indicates an optional expression.
    * The "*" means anything that proceeds it will be repeated any number of 
    times, including none. It will always look for the longest possible string 
    that satisfies the expression. If you use "?" after the star, it will look 
    for the shortest possible string that satisfies the expression. 
    * The "+" means anything that proceeds it will be repeated at least one 
    time.
    * The "{}" are interval quantifiers that allow us to specify the minimum 
    and maximum number of matches of an expression. Can be a range represented 
    as m,n or an exact match m or at least represented as m,. 
    * The "\1" and "\2" is used to repeat a previous expression that is in
    "()".
  * R Functions:
    * "grep()" searches for matches of a regular expression/pattern in a 
    charater vector and returns the indicies into a character vector.
      * In the "stringr" library, the "str_subset()" function is basically 
      "grep(value = TRUE"). 
    * "grep1()" searches for matches of a regular expression/pattern in a
    character vector and returns a TRUE/FALSE vector.
      * In the "stringr" library, "str_detect()" is essentially "grep1()".
    * "regexpr()" and "gregexpr()" searche a chacter vector for regular 
    expression matches and returns the indicies of the string where the match 
    begins and the length of the match.
      * In the "stringr" library, "str_extract()" is the same as "regexpr()".
    * "sub()" and "gsub()" search a character vector for regular expression
    matches and replace that match with another string.
    * "regexec()" searches a character vector for a regular expression and 
    returns the locations of any paranthesized sub-expressions.
      * In the "stringr" library, "str_match" is the same as "regexec()".
      
# Week 4 - What I Learned

Overview of str function, simulation, and R profiling.

## str()

Str stands for structure, so the str() function compactly displays the internal
structure of an R object. Its goal is to produce roughly one line of output per
basic object. It is an alternative to summary().

## Simulation

R comes with a set of pseuodo-random number generators that allow you to 
simulate from well-known probability distributions like the Normal, Poisson, 
and binomial. For Example:

* rnorm: generate random Normal variates with a given mean and standard 
deviation.
* dnorm: evaluate the Normal probability density (with a given mean/SD) at a 
point or vector of points.
* pnorm: evaluate the cummulative distribution function for a normal 
distribution.
* rpois: generate random Poisson veriates with a given rate. 

* "d" for density.
* "r" for random number generation.
* "p" for cumulative distribution.
* "q" for quantile function (inverse cumulative distribution)

When simulating any random numbers it is essential to set the random number 
seed with set.seed(). This allows for reproducibility. 

The sample() function draws randomly from a specified set of scalar objects 
allowing you to sample from arbitrary distributions of numbers.

## R Profiling 

The R profiling tool is used to determine exactly what part of R code is taking
a long time to load when developing larger programs for doing big data 
analyses.

It is important to first write your code, making sure it is working properly 
and is able to be understood, and then later optimize the code using R 
profiling. 

### system.time()

The system.time() function takes an arbitrary R expression and evaluates that 
expression and then tells you the amount of time (in seconds) it took to 
evaluate that expression.

The user time is the amount of time that is charged to the CPU for running this
expression. The elapsed time is the amount of time that you experience. These
are relatively close most of the time, but there are some situations where one
will be bigger or smaller than the other.

### rprof()

Rprof() is used to start the profiler in R. The rprof() function keeps track of
the function call stack at regularly sampled intervals. It prints out the 
function call stack every 0.02 seconds.

Turn on by calling Rprof() with no arguments. Turn off by calling Rprof(NULL).

Do not use the system.time() function and the R profiler function together.

### summaryRprof()

summaryRprof() takes the output from the profiler and summarizes it in a way 
that is readable, because the raw output from the profiler is generally not 
very usable. Basically, it calculates how much time is spent in which function 
by tabulating the frequency in the rprof() output with the interval 0.02. 

by.total divides the time spent in each function by the total run time. by.self
subtracts out time spent in the functions above in the call stack. by.self is
more helpful and accurate because it tells you how much time is being spent in
a given function, but after subtracting out all of the time spent in lower 
level functions that it calls.