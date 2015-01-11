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
png("plot2.png")  # note: default width and height are 480 pixel, as needed

dateTime <- strptime(paste(dt$Date, dt$Time), format="%d/%m/%Y %H:%M:%S")
plot(dateTime, dt$Global_active_power, 
     type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(dateTime, dt$Global_active_power)
dev.off()