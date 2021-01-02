# plot1.R
#
# Question 1:
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, 
## make a plot showing the total PM2.5 emission from all sources 
## for each of the years 1999, 2002, 2005, and 2008.


# Read the input files into R...
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

NEI <- transform(NEI, yearFactor = factor(as.character(year)))

NEI_by_year <- with(NEI, split(NEI,yearFactor))

rows <- numeric()

for(yearData in NEI_by_year) {
  year_TotalEmissions <- c(yearData[1,6], sum(yearData[,4]))
  year <- yearData[1,6]
  yearEmissions = sum(yearData[,4]) / 1000000
  rows <- c(rows, year, yearEmissions)
}


mat <- matrix(rows, nrow=length(NEI_by_year), ncol=2, byrow=TRUE)
df <- data.frame(mat)
names(df) <- c("Year", "Total_Emissions")

with(df, plot(Year, Total_Emissions,
              main="US Total PM2.5 Emmissions for Selected Years",
              ylab="US Total PM2.5 Emissions (millions of tons)", pch=19))

dev.copy(png, file = "plot1.png", width=450, height=450)
dev.off()





     
     


