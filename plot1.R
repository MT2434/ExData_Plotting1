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

## Create and format histogram in png device
png(file = "plot1.png") 
par(bg = "gray87")
hist(new_table$Global_active_power, axes = F, col = "red", xlim = c(0,8), ylim = c(0,1200),
        xlab = "Global Active Power (kilowatts)", main = "Global Active Power",
                breaks = 16)
        axis(2)
        axis(1, at = seq(0,6,2))
dev.off()
