# Problem 1:
# Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008?

# Answer:
# Total emissions decreased in the USA from 1999 to 2008.

# Load the NEI & SCC data frames.
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Aggreate emission per year
totalpm2.5 <- aggregate(Emissions ~ year, NEI, sum)

# Open the PNG device
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# Plot the annual emission
barplot((totalpm2.5$Emissions) / 10^6, names.arg = totalpm2.5$year, 
        xlab = "Year", ylab = "PM2.5 Emissions (10^6 Tons)",
        main = "Total PM2.5 Emissions")

# Close the PNG device
dev.off()