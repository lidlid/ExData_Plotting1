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

# Format metering data as numeric
pcDataSubset$Sub_metering_1 <- as.numeric(as.character(pcDataSubset$Sub_metering_1))
pcDataSubset$Sub_metering_2 <- as.numeric(as.character(pcDataSubset$Sub_metering_2))
pcDataSubset$Sub_metering_3 <- as.numeric(as.character(pcDataSubset$Sub_metering_3))

# Transform datetime to posixct
pcDataSubset <- transform(pcDataSubset, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

# Create PNG file device with width 480 height 480
png(filename="plot3.png",width=480,height=480)

# Plot
plot(pcDataSubset$timestamp,pcDataSubset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(pcDataSubset$timestamp,pcDataSubset$Sub_metering_2,col="red")
lines(pcDataSubset$timestamp,pcDataSubset$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

# Close the PNG file device
dev.off()