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

# Convert Global_active_power to numeric for plot
pcDataSubset$Global_active_power <- as.numeric(as.character(pcDataSubset$Global_active_power))

# Transform datetime to posixct
pcDataSubset <- transform(pcDataSubset, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

# Create PNG file device with width 480 height 480
png(filename="plot2.png",width=480,height=480)

# Plot
plot(pcDataSubset$timestamp,pcDataSubset$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# Close the PNG file device
dev.off()