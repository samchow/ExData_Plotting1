library(data.table)

# We use the fact that the data is time ordered 
# to read only the first 70K rows. 
# To see that it is sufficient, use tail(data) 
# to confirm the last row read is after 2/2/2007.
data_raw <- read.table("./household_power_consumption.txt", header=TRUE, 
                       sep=";", na.strings="?", nrows=70000)

datatable_raw <- as.data.table(data_raw)
# use data.table features to limit to dates of interest
dt <- datatable_raw[datatable_raw$Date=="1/2/2007" | datatable_raw$Date=="2/2/2007"]

## Generate plot
png("plot4.png")  # note: default width and height are 480 pixel, as needed

dateTime <- strptime(paste(dt$Date, dt$Time), format="%d/%m/%Y %H:%M:%S")
par(mfcol=c(2,2))
with(dt, {
  # 1st plot
  plot(dateTime, dt$Global_active_power, 
       type="n", xlab="", ylab="Global Active Power")
  lines(dateTime, dt$Global_active_power)
  
  
  
  # 2nd plot
  plot(dateTime, dt$Sub_metering_1, 
       type="n", xlab="", ylab="Energy sub metering")
  
  lines(dateTime, dt$Sub_metering_1)
  lines(dateTime, dt$Sub_metering_2, col= "red")
  lines(dateTime, dt$Sub_metering_3, col= "blue")
  
  # Can use lwd=c(1,1,1) to specify line width 
  legend("topright", 
         bty="n",
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         lty=c(1,1,1),  col=c("black", "red", "blue"))
  
  # 3rd plot
  plot(dateTime, dt$Voltage, 
       type="n", xlab="datetime",  ylab="Voltage")
  lines(dateTime, dt$Voltage)
  
  # 4th plot
  plot(dateTime, dt$Global_reactive_power, 
       type="n", xlab="datetime", ylab="Global Reactive Power")
  lines(dateTime, dt$Global_reactive_power)
  
})

dev.off()