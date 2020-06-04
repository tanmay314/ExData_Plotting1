library(dplyr)
library(lubridate)
library(datasets)

setwd("C:/Post_School/Coursera/Data_Science/exploratory-data-analysis/exdata_data_household_power_consumption")

allData <- read.csv("C:/Post_School/Coursera/Data_Science/exploratory-data-analysis/exdata_data_household_power_consumption/household_power_consumption.txt", sep=";", header=TRUE)

plotData <- filter(allData, (dmy(Date) == "2007-02-01") | (dmy(Date) == "2007-02-02"))

plotData[,1] <- dmy(plotData[,1])

plotData[,"Global_active_power"] <- as.numeric(as.character((plotData[,"Global_active_power"])))

hist(plotData$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

dev.copy(png, file = "plot1.png")

dev.off()