# Problem 4:
# How have emissions from motor vehicle sources changed from 1999–2008 
# in Baltimore City?

# Answer:
# Emissions from motor decreased from 1999 to 2008 in Baltimore City.

# Load the NEI & SCC data frames.
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Subset motor vehicles.
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehiclesSCC <- SCC[vehicles, ]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC, ]

baltimoreVehicles <- vehiclesNEI[vehiclesNEI$fips == 24510,]

# Open the PNG device
png(filename = "plot5.png", width = 480, height = 480, 
    units = "px", bg = "transparent")

# Plot the distribution of the coal combustion.
library(ggplot2)

ggp <- ggplot(baltimoreVehicles, aes(factor(year), Emissions)) +
  geom_bar(stat = "identity", fill = "grey", width = 0.75) +
  theme_bw() +  guides(fill = FALSE) +
  labs(x = "year", y = expression("Total PM2.5 Emission (10^5 Tons)")) + 
  labs(title = expression("PM2.5 Motor Vehicle in Baltimore from 1999 to 2008"))

print(ggp)


# Close the PNG device
dev.off()