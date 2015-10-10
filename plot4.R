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

## Plot4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kW)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy sub metering (Wh)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Reactive Power (kW)",xlab="")
})

## write to file graphics device
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()