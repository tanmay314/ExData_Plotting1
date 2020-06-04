library(dplyr)
library(lubridate)
library(datasets)

setwd("C:/Post_School/Coursera/Data_Science/exploratory-data-analysis/exdata_data_household_power_consumption")

allData <- read.csv("C:/Post_School/Coursera/Data_Science/exploratory-data-analysis/exdata_data_household_power_consumption/household_power_consumption.txt", sep=";", header=TRUE)

plotData <- filter(allData, (dmy(Date) == "2007-02-01") | (dmy(Date) == "2007-02-02"))

##allData[,1] <- dmy(allData[,1])

plotData$DateTime <- paste(plotData[,1],plotData[,2])

plotData[,10] <- as.character(plotData[,10])

plotData$DateTime <- strptime(plotData$DateTime,"%d/%m/%Y %H:%M:%S")

plotData[,"Global_active_power"] <- as.numeric(as.character((plotData[,"Global_active_power"])))

plot(plotData$DateTime,plotData$Global_active_power, type="l", ylab="Global Active Power (kilowatts)")

dev.copy(png, file = "plot2.png")

dev.off()