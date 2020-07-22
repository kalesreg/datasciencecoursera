---
title: "Getting and Cleaning Data - What I Learned"
author: "Kaley Regner"
date: "7/20/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Week 1 - What I Learned

Overview of raw and processed data, downloading files, reading different file 
types into R, and data.table. 

## Raw Data

Raw data is the original source of the data. It is often hard to use for data 
analyses. 

## Processed Data

Processed data is ready for analysis. Processing includes merging, subsetting,
transforming, etc. 

After processing the data, you should have a document that includes the study
design, code book, and the instruction list. The study design has a thorough
description of how the data was collected, how the data was extracted from the 
database, what was excluded, and so forth. The code book describes each 
variable and it's value in the tidy data set. The instruction list should give 
you the steps to go from the raw data to the processed data, usually through 
the use of a script. 

## Downloading Files

It is helpful to download files in R because then the downloading process can 
be included in the processing script. 

It is helpful to keep track of the date that the data was downloaded as the 
data could change over time. 

## Reading Different File Types Into R

The read.table() function is the most common function used to read files into R
because it is the most robust. However, it requires you to input more parameters
and can be a bit slow. read.csv, read.csv2, read.xlsx, and read.xlsx2 are all 
good alternatives.

XML is widely used in internet applications, so it will be seen when using 
things like web scraping and internet APIs. It uses tags, elements, and 
attributes. You can read XML into R using the XML library, then pass it to 
xmlTreeParse(). You can find more XPath info [here](http://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf).

JSON is a lightweight data storage format for data from APIs. Similar to XML,
but different syntx/format. You can read JSON into R using the jsonlite library,
then pass it to fronJSON(). You can find more infor on JSON files [here](http:// www.json.org/). 
A good tutorial on jsonlite can be found [here](http://www.r-bloggers.com/new-package-jsonlite-a-smarter-json-encoderdecoder/).

## data.table

data.table is basically a faster version of data.frame. However, data.table
does function slightly differently. 

### Single Element Subsetting

Single-element subsetting in data.table refers to row, rather than columns.

### Row Subsetting

Row subsetting in data.table is the same as data.frame, so it looks like:
DT[x, ]. However, unlike data.frame, you can use single
element subsetting with data.table to get one row: DT[x].

### Column Subsetting

You can get a column from data.table as a vector by DT[[x]]. If x is a number, 
you can get a column from data.table as a table by DT[, x]. If x is a column
name, you can get a column from data.table as a table by DT[, list(x)]. When 
using a column name in data.table, you don't have to surround it in quotation 
marks. 

Expressions

Key. Join using keys. 

.N is an integer, length 1. 

Use tables() to see all the data tables in memory.

fread() is much faster than read.table. 

A list of differences between data.table and data.frame can be found [here](http://stackoverflow.com/questions/13618488/what-you-can-do-with-data-frame-that-you-cant-in-data-table).
