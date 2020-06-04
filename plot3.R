library(dplyr)
library(lubridate)
library(datasets)
library(reshape2)

setwd("C:/Post_School/Coursera/Data_Science/exploratory-data-analysis/exdata_data_household_power_consumption")

allData <- read.csv("C:/Post_School/Coursera/Data_Science/exploratory-data-analysis/exdata_data_household_power_consumption/household_power_consumption.txt", sep=";", header=TRUE)

plotData <- filter(allData, (dmy(Date) == "2007-02-01") | (dmy(Date) == "2007-02-02"))

##allData[,1] <- dmy(allData[,1])

plotData$DateTime <- paste(plotData[,1],plotData[,2])

plotData[,10] <- as.character(plotData[,10])

plotData$DateTime <- strptime(plotData$DateTime,"%d/%m/%Y %H:%M:%S")

plotData$DateTime <- as.POSIXct(plotData$DateTime)

plotData[,7] <- as.numeric(as.character(plotData[,7]))

plotData[,8] <- as.numeric(as.character(plotData[,8]))

plotMelt <- melt(plotData, id=c("DateTime"), measure.vars=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), na.rm = TRUE)

with(plotMelt, plot(DateTime,value,ylab="Energy sub metering", type="n"))
with(subset(plotMelt, variable == "Sub_metering_1"), lines(DateTime,value,type="l",col="black"))
with(subset(plotMelt, variable == "Sub_metering_2"), lines(DateTime,value,type="l",col="red"))
with(subset(plotMelt, variable == "Sub_metering_3"), lines(DateTime,value,type="l",col="blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.copy(png, file = "plot3.png")

dev.off()