## This is the R code to construct plot 4 for Assignment 1 of Coursera course 
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
png(filename = "plot4.png", width = 480, height = 480, units = "px")

## Set the plotting system to a matrix of plots with 2 rows and 2 columns.
##	Also reduce the font size to 75%
par (mfrow = c(2,2), cex = 0.75)

## Construct the plot of location (1,1)
plot(elecData$DateTime, elecData$Global_active_power, type = "l", 
	ylab = "Global Active Power", xlab = "")

## Construct the plot of location (1,2)
plot(elecData$DateTime, elecData$Voltage, type = "l", 
	ylab = "Voltage", xlab = "datetime")

## Construct the plot of location (2,1)
## Set-up the plot as we need to draw three line graphs...
xRange = range(elecData$DateTime) 
yRange = range(c(elecData$Sub_metering_1, elecData$Sub_metering_3, 
					elecData$Sub_metering_3)) 
plot(xRange, yRange, type = "n", xlab = "", ylab = "Energy sub metering") 

## Draw the lines for sub_meters_1 to 3.
lines(elecData$DateTime, elecData$Sub_metering_1, type="l", col = "black") 
lines(elecData$DateTime, elecData$Sub_metering_2, type="l", col = "red") 
lines(elecData$DateTime, elecData$Sub_metering_3, type="l", col = "blue") 

## Add the legend to the top right
legend ("topright", lty = c(1, 1, 1), lwd = c(2.5, 2.5, 2.5), bty = "n",
			legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
			col = c("black", "red", "blue"))

## Construct the plot of location (2,2)
plot(elecData$DateTime, elecData$Global_reactive_power, type = "l", 
	ylab = "Global_reactive_power", xlab = "datetime")
	
## Close the PNG device
dev.off()

## Done. Plot4 constructed.