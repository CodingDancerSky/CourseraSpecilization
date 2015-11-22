# Problem 2:
# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? 

# Answer:
# Yes, total emissions decreased.

# Load the NEI & SCC data frames.
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Subset NEI data by Baltimore's fip.
subNEI <- NEI[NEI$fips == "24510", ]

# Aggregate using sum the Baltimore emissions data by year
baltimore <- aggregate(Emissions ~ year, subNEI, sum)

# Open the PNG device
png(filename = "plot2.png", width = 480, height = 480, units = "px")

# Plot the annual emission
barplot(baltimore$Emissions, names.arg = baltimore$year, 
        xlab = "Year", ylab = "PM2.5 Emissions",
        main = "Total PM2.5 Emissions From Baltimore City")

# Close the PNG device
dev.off()