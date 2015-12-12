## Exploratory Data Analysis
## Programming Assignment 1 - Plot 4
## Author: Rick Hutchison
## Created: 12/11/2015
## 
## This is a function to create the "Plot 4" series of plots and output
## it to a single png file.  A function wrapper was used for ease
## of development.

genplot4 <- function(){
  ## this function assumes the working directory contains the source
  ## data and will be the destination for the resulting plot png file.
  
  library(data.table)
  
  ## load all source data since we have enough memory
  src <- fread("./household_power_consumption.txt", sep = ";", na.strings = "?")
  
  ## create subset of data from source for desired time interval
  srcsubset <- subset(src, Date=="1/2/2007" | Date=="2/2/2007")
  
  ## add a new date column from the combined Date and Time text strings in the source
  srcsubset[,datetime := as.POSIXct(paste(srcsubset$Date,srcsubset$Time), format = "%d/%m/%Y %H:%M:%S")]
  
  ## initialize the output png file
  png(filename = "./plot4.png", width = 480, height = 480)
  
  ## we want our 4 plots shown in a 2 x 2 format
  par(mfrow = c(2,2))
  
  # plot 1, upper left
  plot(srcsubset$datetime, srcsubset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  
  # plot 2, upper right
  plot(srcsubset$datetime, srcsubset$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  
  # plot 3, lower left
  plot(srcsubset$datetime, srcsubset$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(srcsubset$datetime, srcsubset$Sub_metering_2, type = "l", col = "red")
  lines(srcsubset$datetime, srcsubset$Sub_metering_3, type = "l", col = "blue")
  legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = 1, lty = 1,
         col = c("black","red","blue"), bty = "n")
  
  # plot 4, lower right
  plot(srcsubset$datetime, srcsubset$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
  
  ## complete the writing of the png file.
  dev.off()
}