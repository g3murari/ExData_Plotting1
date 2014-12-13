## This is the R code to construct plot 1 for Assignment 1 of Coursera course 
##	"Exploratory Data Analysis" from John Hopkins University by Dr.Roger D. Peng
## This R code to construct the plot is copyright of Kanthimathi Gayatri Sukumar. 
##	This code shall not be copied or reused.

## Load the necessary libraries
library(chron)

## Read the first few lines of data to get the column names
header = read.table(
	"household_power_consumption.txt", 
	header = TRUE, sep=";", na.strings = "?", nrows = 5)
	
## Read the data for 1/1/2007 and 2/1/2007 only and set the column names.
elecData = read.table (
    "household_power_consumption.txt", 
	header = TRUE, sep=";", na.strings = "?", skip = 66636, nrows = 2880, 
	stringsAsFactors = FALSE, col.names = names(header))
	
## Transform the Date and Time to the proper formats
elecData$DateTime = paste(elecData$Date, elecData$Time)
elecData$DateTime = strptime(elecData$DateTime, "%d/%m/%Y %H:%M:%S")

elecData = transform(elecData, Date = as.Date(Date, "%d/%m/%Y"))
elecData = transform(elecData, Time = chron(times=Time))

## Open the PNG device of width and height 480 px as required in the assignment.
png(filename = "plot1.png", width = 480, height = 480, units = "px")
	
## Construct the histogram specified for plot1
hist(elecData$Global_active_power, col = "red", 
	xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
	
## Close the PNG device
dev.off()

## Done. Plot1 constructed.