# plot1.R
#
# Question 1:
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, 
## make a plot showing the total PM2.5 emission from all sources 
## for each of the years 1999, 2002, 2005, and 2008.


# Read the input files into R...
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- transform(NEI, yearFactor = factor(as.character(year)))

NEI_by_year <- with(NEI, split(NEI,yearFactor))

for(yearData in NEI_by_year) {
  year_TotalEmissions <- c(yearData[1,6], sum(yearData[,4]))
  yearTotal = data.frame(year_TotalEmissions, nrow=1, ncol=2)
  names(yearTotal) <- c("Year", "Total Emmissions Tons")
  print(yearTotal)
}
