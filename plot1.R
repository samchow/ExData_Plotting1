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

## Now do the ploting:
png("plot1.png")  # the default width and height are equal 480 pixel.
hist(dt$Global_active_power, xlab="Global Active Power (kilowatts)", 
     main="Global Active Power", col="red", ylim=c(0,1200))
dev.off()