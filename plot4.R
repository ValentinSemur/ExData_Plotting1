# Import the relevant library
library(tidyr)

# Read the data
energyUsage <- read.table("household_power_consumption.txt",
                          sep = ";", 
                          header = TRUE, 
                          na.strings = "?")

# Merge the date and time columns
energyUsage <- unite(energyUsage, DateTime, Date:Time, sep=' ')

# Change the format of the DateTime column
energyUsage$DateTime <- strptime(energyUsage$DateTime, "%d/%m/%Y %H:%M:%S")

# Subset the dataset to the two days to analyze
twoDaysEnergyUsage <- subset(energyUsage,
                             as.Date(DateTime) == '2007-02-01' | 
                               as.Date(DateTime) == '2007-02-02')

# Open a png file
png(file='plot4.png', width = 480, height = 480)

# Plot the charts
par(mfrow=c(2,2))

  # Chart 1
with(twoDaysEnergyUsage, plot(DateTime, Global_active_power, 
                              type='n', 
                              ylab = 'Global Active Power',
                              xlab = ''))
with(twoDaysEnergyUsage, lines(DateTime, Global_active_power))

  # Chart 2
with(twoDaysEnergyUsage, plot(DateTime, Voltage, 
                              type='n', 
                              ylab = 'Voltage',
                              xlab = 'datetime'))
with(twoDaysEnergyUsage, lines(DateTime, Voltage))

  # Chart 3
with(twoDaysEnergyUsage, plot(DateTime, Sub_metering_1, 
                              type='n', 
                              ylab = 'Energy sub metering',
                              xlab = ''))

with(twoDaysEnergyUsage, lines(DateTime, Sub_metering_1, col = 'black'))
with(twoDaysEnergyUsage, lines(DateTime, Sub_metering_2, col = 'red'))
with(twoDaysEnergyUsage, lines(DateTime, Sub_metering_3, col = 'blue'))

legend('topright', 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       col=c('black', 'red', 'blue'), 
       lty = 1,
       box.lty = 0)

  # Chart 4
with(twoDaysEnergyUsage, plot(DateTime, Global_reactive_power, 
                              type='n', 
                              ylab = 'Global_reactive_power',
                              xlab = 'datetime'))
with(twoDaysEnergyUsage, lines(DateTime, Global_reactive_power))

# Close the file
dev.off()
