# Problem 6:
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Answer:
# LA.

# Load the NEI & SCC data frames.
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Subset motor vehicles.
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehiclesSCC <- SCC[vehicles, ]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC, ]

vehiclesBaltimore <- vehiclesNEI[vehiclesNEI$fips == 24510,]
vehiclesBaltimore$city <- "Baltimore"
vehiclesLA <- vehiclesNEI[vehiclesNEI$fips == "06037",]
vehiclesLA$city <- "LA"
bothNEI <- rbind(vehiclesBaltimore, vehiclesLA)

# Open the PNG device
png(filename = "plot6.png", width = 480, height = 480, 
    units = "px", bg = "transparent")

# Plot the distribution of the coal combustion.
library(ggplot2)

ggp <- ggplot(bothNEI, aes(x=factor(year), y = Emissions, fill = city)) +
  geom_bar(aes(fill = year),stat = "identity") +
  facet_grid(scales = "free", space = "free", .~city) +
  guides(fill = FALSE) + theme_bw() +
  labs(x = "year", y = expression("Total PM2.5 Emission (Kilo-Tons)")) + 
  labs(title = expression("PM2.5 From Motor Vehicle in Baltimore & LA from 1999 to 2008"))

print(ggp)


# Close the PNG device
dev.off()