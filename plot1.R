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
png(file='plot1.png', width = 480, height = 480)

# Plot the histogram
with(twoDaysEnergyUsage, hist(Global_active_power, 
                              col = 'red', 
                              main = 'Global Active Power', 
                              xlab = 'Global Active Power (kilowatts)'))

# Close the file
dev.off()