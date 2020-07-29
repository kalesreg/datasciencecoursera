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

The "read.table()"" function is the most common function used to read files into
R because it is the most robust. However, it requires you to input more 
parameters and can be a bit slow. read.csv, read.csv2, read.xlsx, and read.xlsx2
are all good alternatives.

XML is widely used in internet applications, so it will be seen when using 
things like web scraping and internet APIs. It uses tags, elements, and 
attributes. You can read XML into R using the XML library, then pass it to 
"xmlTreeParse()". You can find more info [here](http://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf).
* "xmlTreeParse()" returns the xml for a given URL.
* "xmlRoot()" returns the internal structure of an XML file.
* "xmlName()" gives the element name for a given node.
* "xmlAttrs()" gives all the attributes/child nodes for a given node. Use 
"xmlGetAttr()" get a particular value.
* "xmlValue()" to get the text content for a given node.
* "xmlChildren()", "node[[i]]", or "node[["el-name"]]" to select a node.
* "xmlSApply()" to loop over the nodes and get the content as a string.
* XPath is a language for node subsetting by name, with specific attributes 
present, with attributes with particular values, and with parents, ancestors,
children.
        * /node - top-level node
        * //node - node at any level
        * node[@attr-name] - node that has an attribute named "attr-name"
        * node[@attr-name='bob'] - node that has attribute named attr-name with
        value 'bob
        * node/@x - value of attribute x in node with such attr. 

JSON is a lightweight data storage format for data from APIs. Similar to XML,
but different syntx/format. You can read JSON into R using the jsonlite library,
then pass it to "fronJSON()". You can find more infor on JSON files [here](http:// www.json.org/). 
A good tutorial on jsonlite can be found [here](http://www.r-bloggers.com/new-package-jsonlite-a-smarter-json-encoderdecoder/).

## data.table

"data.table()" is basically a faster version of "data.frame()". However,
"data.table()"does function slightly differently. 

data.tables don't automatically copy like data.frames do, so you have to
explicitly copy a data.table with "copy()".

Use "tables()"" to see all the data tables in memory.

"fread()" is much faster than "read.table()". 

A list of differences between data.table and data.frame can be found [here](http://stackoverflow.com/questions/13618488/what-you-can-do-with-data-frame-that-you-cant-in-data-table).

### Single Element Subsetting

Single-element subsetting in data.table refers to row, rather than columns.

### Row Subsetting

Row subsetting in "data.table()" is the same as "data.frame()", so it looks
like: DT[x, ]. However, unlike "data.frame()", you can use single element
subsetting with "data.table()" to get one row: DT[x].

### Column Subsetting

You can get a column from "data.table()" as a vector by DT[[x]]. If x is a
number, you can get a column from "data.table()" as a table by DT[, x]. If x is 
a column name, you can get a column from "data.table()" as a table by 
DT[, list(x)]. When using a column name in "data.table()", you don't have to 
surround it in quotation marks. 

### Expressions

In R, an expression is a collection of statements enclosed in curley brackets.
Expressions can be used to do multiple operations.

If you provide a list to the j expression, you generate a new data.table as an 
output with the operations in the list call. Example:
```{r}
library(data.table)
DT <- data.table(x=1:5, y=1:5)
DT[, list(mean_x = mean(x), sum_y = sum(y), sumsq=sum(x^2+y^2))]
```

Using the ":=" operator tells you to assign columns by reference into the 
data.table. Example:
```{r}
library(data.table)
DT <- data.table(x=1:5)
DT[, y := x^2]
```

The left side of the ":=" call can also be a character vector of names for 
which the corresponding final statement in the j expression is a list of the 
same length. Example:
```{r}
library(data.table)
DT <- data.table(x=1:5, y=6:10, z=11:15)
DT[, c('m', 'n') := { tmp <- (x + 1) / (y + 1); list( log2(tmp), log10(tmp) ) }]
DT[, `:=`(a=x^2, b=y^2)]
DT[, c("c","d"):=list(x^2, y^2)]
```

### Keys

Keys allow for faster indexing and subsetting. Using keys does a "binary search"
rather than a "vector scan", which is much faster.

Set the key using "setkey(DT, key)".

### Joins

Data.tables can be put together in multiple ways.
* Left join - keeps all the values present in the first DT. 
merge(DT1, DT2, all.x=TRUE)
* Right join - keeps all the values present in the second DT. 
merge(DT1, DT2, all.y=TRUE)
* Outer join - keeps all the values.
merge(DT1, DT2, all=TRUE)
* Inner join - keeps only the values that appear in both DTs.
merge(DT1, DT2, all=FALSE)

### Special Variables

* ".SD" is a data.table containing the subset of data for each group, excluding
columns used in "by".
* ".BY" is a list containing a length 1 vector for each item in "by".
* ".N" is an integer, length 1, containing the number of rows in ".SD".
* ".I" is a vector of indices, holding the row locations from which ".SD" was
pulled from the parent "DT".
* ".GRP" is a counter telling you which group you're working with.

# Week 2 - What I Learned

Reading in data from multiple different sources.

## Reading MySQL

mySQL is a free and widely used open source database software. Data are 
structured in databases, tables within databases, and fields within tables.

Open a connection to SQL with "dbConnect()". If you know that all the results 
will fit in memory, you can use "dbGetQuery()" to send, fetch, and clear the 
query. If you are not sure that the results will fit in memory, you can use 
"dbSendQuery()", "deFetch()", and "dbClearResult()" to query specific data from 
a particular database and table. Make sure to use "dbClearResult()" and 
"dbDisconnect()" after you are done to close the connection. 

"dbListTables()" lists all the tables in a particular database. 
"dbListFields()" gets the dimensions for a specific table.

## Reading HDF5

HDF5 is used for storing large data sets. 
* "h5createGroup()" creates a group in a hdf5 document.
* "h5write()" writes data into a file group. 
* "h5read()" reads data from a specified file group. 
* "h5ls()" lists the file contents. 

## Reading from the Web

Webscraping programatically extracts data from the HTML code of websites. Open
a connection to a website using "url()". Get the html code using "readLines()". 
Then, close the connection using "close()". Could also use "htmlTreeParse()" 
from the XML library. Could also use "GET()", "content()", and "htmlParse()" 
from the httr library. 

To access websites with passwords, use "GET(url, authenticate("user", 
"passwd"))". You can save handles with "handle("URL")"

## Reading from APIs

Use the httr library for APIs. Specific information required for each sites API.

## Reading from Other Sources

There is usually is already a R package available for most sources. Just google
it. 

# Week 3 - What I Learned

## Summarizing Data

"summary()" gives a quick overview of the data. It provides the column names 
and, depending on the type of data, some sort of summary info. This could be a
count, quantiles, or something else. 

"str()" also gives an overview but it is a bit more in depth. It tells you what
type of data the object is, number of observations and variables, and the column
name and that columns data type, levels, and the first few values.

"quantile()" gives the quantiles for quantitative variables. You can specify 
the values for which probabilities you want. 

You can make a table with specified info using "table()". For example:
```{r}
## gives a count of NA values in the zipcode column
table(restData$zipCode, useNA = "ifany")

## results in a table of cross-sections of council districts and zipcodes
table(restData$councilDistrict, restData$zipCode)
```

You can use "sum(is.na(data))" (count), "any(is.na(data))" (logical), and 
"all(data > 0)" (logical) to check for missing values.

"colSums()" gives the sum for given data.

You can search data for particular values with specific characteristics. This
can be done using "table(data %in% c("characteristic"))" or you can subset the
data by using "data[data %in% c("characteristic"), ]".

Use "xtabs()" to get cross tabs. For example,
```{r}
data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
xt = xtabs(Freq ~ Gender + Admit, data=DF)
xt
```
You can make flat tables from cross tabs using "ftable()".

Use "object.size()" and "print(object.size(), units="Mb")" to get the size of a
dataset. 

## Creating New Variables

## Reshaping Data

## Merging Data