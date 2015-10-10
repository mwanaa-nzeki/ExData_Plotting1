inputFile <- "household_power_consumption.txt"
## read in source file
sourceData <- read.table(inputFile, header=T, sep=";", stringsAsFactors = F, dec=".")
## class the date field
sourceData$Date <- as.Date(sourceData$Date, format="%d/%m/%Y")
## subset by date range
data <- subset(sourceData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
## remove large file from memory
rm(sourceData)
## converte date and time values
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot3
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
##add legend
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## write to file graphics device
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()