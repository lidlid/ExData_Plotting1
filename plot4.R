# Set the file containing the "Individual household electric power consumption Data Set"
# Asssumes the working directory includes the exdata-data-household_power_consumption directory
# housing the household_power_consumption.txt file
pcFile <- "./exdata-data-household_power_consumption/household_power_consumption.txt"

# Read the full data set 
pcDataFull <- read.table(pcFile, header=TRUE, sep=";")

# convert the Date and Time variables to Date/Time classes
pcDataFull$Date<-as.Date(pcDataFull$Date, format="%d/%m/%Y")

# Subset the data to the data for dates 2007-02-01 to 2007-02-02
pcDataSubset<-pcDataFull[(pcDataFull$Date=="2007-02-01") | (pcDataFull$Date=="2007-02-02"),]

# Format metering data, global active power, global reactive power and voltage as numeric
pcDataSubset$Sub_metering_1 <- as.numeric(as.character(pcDataSubset$Sub_metering_1))
pcDataSubset$Sub_metering_2 <- as.numeric(as.character(pcDataSubset$Sub_metering_2))
pcDataSubset$Sub_metering_3 <- as.numeric(as.character(pcDataSubset$Sub_metering_3))
pcDataSubset$Global_active_power <- as.numeric(as.character(pcDataSubset$Global_active_power))
pcDataSubset$Global_reactive_power <- as.numeric(as.character(pcDataSubset$Global_reactive_power))
pcDataSubset$Voltage <- as.numeric(as.character(pcDataSubset$Voltage))

# Transform datetime to posixct
pcDataSubset <- transform(pcDataSubset, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

# Create PNG file device with width 480 height 480
png(filename="plot4.png",width=480,height=480)

# Set the number of rows and columns on the canvas
par(mfrow=c(2,2))
    
# Plot
plot(pcDataSubset$timestamp,pcDataSubset$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(pcDataSubset$timestamp,pcDataSubset$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(pcDataSubset$timestamp,pcDataSubset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(pcDataSubset$timestamp,pcDataSubset$Sub_metering_2,col="red")
lines(pcDataSubset$timestamp,pcDataSubset$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
plot(pcDataSubset$timestamp,pcDataSubset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# Close the PNG file device
dev.off()