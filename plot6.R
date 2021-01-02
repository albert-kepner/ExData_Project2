# plot6.R
#
# Question 6:

## Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in 
## Los Angeles County, California fips == "06037".
## Which city has seen greater changes over time in motor vehicle emissions?

# Read the input files into R...
NEI <- readRDS("data/summarySCC_PM25.rds")

## Restrict the data frame to Baltimore City and Los Angeles County rows.
NEI <- NEI[NEI$fips == "24510" | NEI$fips == "06037",]






NEI <- transform(NEI, yearFactor = factor(as.character(year)))
## Restrict the data frame to motor vehicle rows
NEI <- subset(NEI, type == "ON-ROAD")

## Add a Place column to indicate Baltimore_City or Los_Angeles_County

NEI$Place <- "Place"
NEI[NEI$fips == "24510",8] = "Baltimore_City"
NEI[NEI$fips == "06037",8] = "Los_Angeles_County"

NEI_by_year <- with(NEI, split(NEI,yearFactor))

rows <- numeric()
places <- character()

## split the emission data by year
for(yearData in NEI_by_year) {
  ## Need to split again by Place
  yearByPlace <- split(yearData, yearData$Place)
  for(data in yearByPlace) {
    year <- data[1,6]
    yearEmissions = sum(data[,4])
    rows <- c(rows, year, yearEmissions)
    place <- data[1,8]
    places <- c(places, place)
  }
}


mat <- matrix(rows, ncol=2, byrow=TRUE)
df <- data.frame(mat)
names(df) <- c("Year", "Total_Emissions")

df$Place <- places
df <- transform(df, Place=factor(Place))

library(ggplot2)
g <- ggplot(df, aes(x=Year, y=Total_Emissions))

g+geom_point( aes(col=Place), size=2) +
  labs(title="Baltimore City vs Los Angeles County PM2.5 Motor Vehicle Emissions", y="Total Emissions (tons)")

dev.copy(png, file = "plot6.png", width=450, height=450)
dev.off()





     
     


