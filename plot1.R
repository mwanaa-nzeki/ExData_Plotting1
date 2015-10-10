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

## Plot1
globalActivePower <- as.numeric(data$Global_active_power)
hist(globalActivePower, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
## write to file graphics device
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()