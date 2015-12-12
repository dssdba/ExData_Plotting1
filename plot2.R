## Exploratory Data Analysis
## Programming Assignment 1 - Plot 2
## Author: Rick Hutchison
## Created: 12/11/2015
## 
## This is a function to create the "Plot 2" plot and output
## it to a png file.  A function wrapper was used for ease
## of development.

genplot2 <- function(){
  ## this function assumes the working directory contains the source
  ## data and will be the destination for the resulting plot png file.
  
  library(data.table)
  
  ## load all source data since we have enough memory
  src <- fread("./household_power_consumption.txt", sep = ";", na.strings = "?")
  
  ## create subset of data from source for desired time interval
  srcsubset <- subset(src, Date=="1/2/2007" | Date=="2/2/2007")
  
  ## add a new date column from the combined Date and Time text strings in the source
  srcsubset[,datetime := as.POSIXct(paste(srcsubset$Date,srcsubset$Time), format = "%d/%m/%Y %H:%M:%S")]
  
  ## generate the plot
  plot(srcsubset$datetime, srcsubset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
  
  ## output the plot to the png file
  dev.copy(png, file = "./plot2.png", width = 480, height = 480)
  dev.off()  
}