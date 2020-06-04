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

plotData[,"Global_active_power"] <- as.numeric(as.character((plotData[,"Global_active_power"])))

plotData[,"Global_reactive_power"] <- as.numeric(as.character((plotData[,"Global_reactive_power"])))

plotData[,"Voltage"] <- as.numeric(as.character((plotData[,"Voltage"])))

plotData[,7] <- as.numeric(as.character(plotData[,7]))

plotData[,8] <- as.numeric(as.character(plotData[,8]))

plotMelt <- melt(plotData, id=c("DateTime"), measure.vars=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), na.rm = TRUE)

par(mfrow=c(2,2), mar=c(4,4,2,2))

with(plotData, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)",xlab=""))
with(plotData, plot(DateTime, Voltage, type="l", ylab="Voltage", xlab="datetime"))
with(plotMelt, plot(DateTime,value,ylab="Energy sub metering", xlab="", type="n"))
with(subset(plotMelt, variable == "Sub_metering_1"), lines(DateTime,value,type="l",col="black"))
with(subset(plotMelt, variable == "Sub_metering_2"), lines(DateTime,value,type="l",col="red"))
with(subset(plotMelt, variable == "Sub_metering_3"), lines(DateTime,value,type="l",col="blue"))
legend("topright", inset=0.01,box.lty=0, cex=0.75, col = c("black", "red", "blue"), lty=1, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
with(plotData, plot(DateTime, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime"))


dev.copy(png, file = "plot4.png")

dev.off()