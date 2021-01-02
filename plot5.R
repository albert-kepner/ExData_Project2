# plot5.R
#
# Question 5:
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


# Read the input files into R...
NEI <- readRDS("data/summarySCC_PM25.rds")

## Restrict the data frame to Baltimore City rows.
NEI <- NEI[NEI$fips == 24510,]



NEI <- transform(NEI, yearFactor = factor(as.character(year)))
## Restrict the data frome to motor vehicle rows
NEI <- subset(NEI, type == "ON-ROAD")

NEI_by_year <- with(NEI, split(NEI,yearFactor))

rows <- numeric()

for(yearData in NEI_by_year) {
  year <- yearData[1,6]
  yearEmissions = sum(yearData[,4]) 
  rows <- c(rows, year, yearEmissions)
}


mat <- matrix(rows, nrow=length(NEI_by_year), ncol=2, byrow=TRUE)
df <- data.frame(mat)
names(df) <- c("Year", "Total_Emissions")

with(df, plot(Year, Total_Emissions,
              main="Baltimore City, Motor Vehicle PM2.5 Emmissions for Selected Years",
              ylab="Total Motor Vehicle Emissions (tons)", pch=19))

dev.copy(png, file = "plot5.png", width=450, height=450)
dev.off()





     
     


