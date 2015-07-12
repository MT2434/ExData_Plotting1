## Read in table and subset
table <- read.csv2("household_power_consumption.txt", header = TRUE)
new_table <- subset(table, Date == "1/2/2007" | Date == "2/2/2007")
rm(table)

## Convert power consumption columns to numeric
x <- colnames(new_table[,c(-1,-2)])
for (i in x) {new_table[,i] <- as.numeric(as.character(new_table[,i]))}
rm(i)
rm(x)

## Convert date-time to POSIXct
new_table$Date <- as.character(new_table$Date)
new_table$Time <- as.character(new_table$Time)
new_str <- sapply(seq_along(new_table$Date), function(x) {
                paste(new_table[x,"Date"], new_table[x,"Time"])
                })
date_time <- strptime(new_str, format = "%d/%m/%Y %H:%M:%S")
new_table <- cbind(new_table, date_time)

## Create line chart in png device, add points for Sub_metering_2 (and _3)
png(file = "plot3.png")
par(bg = "gray87")
with(new_table, {
        plot(date_time,Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
        points(date_time,Sub_metering_2, type = "l", col = "red")
        points(date_time,Sub_metering_3, type = "l", col = "blue")
        legend("topright", lty = 1, col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
        })
dev.off()