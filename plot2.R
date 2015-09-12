library(plyr)
library(dplyr)
library(graphics)
library(grDevices)
library(lubridate)

## Read the data from the dataset, for the dates 2007-02-01 and 2007-02-02
hpconsump <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),  sep = ";", na.strings = "?", header = TRUE)

##Give column names to the data frame
colnames(hpconsump) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

##Create a png file for the plot2
png(file = "plot2.png", width  = 480, height = 480) 

## Paste together the Date and Time of the power consumption
x <- paste(hpconsump$Date, hpconsump$Time)

##Convert the date-time into proper POSIXct date format and find the corresponding weekday
y <- as.POSIXct(x, format = "%d/%m/%Y %H:%M:%S")
z <- as.Date(y)
d1 <- weekdays(z, abbreviate = TRUE)

##Combine the date-time and weekday vectors with the dataframe
hpconsump <- cbind.data.frame(hpconsump,x, d1)

##Plot the day vs. Global active power
plot(y, hpconsump$Global_active_power, type = "l", xlab = " ", ylab= "Global Active Power (kilowatts)")

##Switch off the graphics device
dev.off()
