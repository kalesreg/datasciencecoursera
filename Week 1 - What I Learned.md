---
title: "Week 1 - What I Learned"
author: "Kaley Regner"
date: "6/24/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Week 1 - What I Learned 

R was derived from S. R is open source, so it is free and users can add to it. R is meant to be able to be used by data analysts who are and are not familiar with programming.  

## Resources to keep in mind:
* [CRAN manuals](https://cran.r-project.org/manuals.html)
* [Basic R Cheat Sheet](https://rstudio.com/wp-content/uploads/2016/10/r-cheat-sheet-3.pdf)
* [RMarkdown Cheat Sheet](https://rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)
* [Forms of the Extract Operator](https://github.com/lgreski/datasciencectacontent/blob/master/markdown/rprog-extractOperator.md)

## Basics
* "<-" is the assignment operator.
* "#" is the comment operator. 
* The five basic classes of objects are: character, numeric, integer, complex, and logical.
* A vector can only contain objects of the same class. A list is an exception, meaning it can contain objects of different classes.
* Add the "L" suffix to specify that a number is an integer instead of a numeric object. 
* "Inf" is infinity. "NaN" is an undefined value or not a number. 
* R objects can have attributes, such as : names/dimnames, dimensions, class, length, or other user-defined attributes. Attributes can be access using the "attributes()" function.
* "c()" function can be used to create vectors by concatenating objects together. 
* If you try to mix different classes of objects, coercion occurs so that every element in the vector is of the same class. You can also change the class of an object manually through explicit coercion using the "as.*" function.
* Matrices are vactors with a dimension attribute. They are constructed column-wise, meaning numbers run down instead of sideways. 
  + Vectors can be turned into matrices by adding a dimension attribute. Use "dim(*) <- c(#r, #c)".
  + Matrices can also be created by column-binding or row-binding with "cbind()" and "rbind()" functions. 
* Create a list using "list()" function. 

## Getting into the Data
* Use "is.na()" to test objects if they are "NA."
* Use "is.nan()" to test objects for "NaN."
* Data frames can store different classes of objects in each column. They have column names and row names. Often created using "read.table()" or "read.csv()". They can be created manually using "data.frame()". 
* Calculating Memory Requirements for R Objects: (#r * #c * 8bytes/numeric)/(2^20^)/(1000) = amount of RAM required. Double it to determine how much RAM you need to read in a large dataset. 

### Subsetting R Objects
* The single bracket operator always returns an object of the same class as the original. It can be used to select multiple elements of an object.
* The double bracket operator is used to extract elements of a list or a data frame. It can only be used to extract a single element and the class of the returned object will not necessarily be a list or data frame.
* The "$" operator is used to extract elements of a list or data frame by literal name. Its semantics are similar to that of the double bracket. 
* Use "complete.cases(*)" to mark NA values as FALSE. Then, take a subset of the data marked TRUE.

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

