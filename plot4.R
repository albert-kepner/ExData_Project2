# plot4.R
#
# Question 4:
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?


# Read the input files into R...
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

coal <- subset(SCC, EI.Sector == "Fuel Comb - Comm/Institutional - Coal")

coal_source <- as.character(coal$SCC)

NEI <- transform(NEI, yearFactor = factor(as.character(year)))

NEI <- subset(NEI, SCC %in% coal_source)

NEI_by_year <- with(NEI, split(NEI,yearFactor))

rows <- numeric()

for(yearData in NEI_by_year) {
  year_TotalEmissions <- c(yearData[1,6], sum(yearData[,4]))
  year <- yearData[1,6]
  yearEmissions = sum(yearData[,4]) / 1000
  rows <- c(rows, year, yearEmissions)
}


mat <- matrix(rows, nrow=length(NEI_by_year), ncol=2, byrow=TRUE)
df <- data.frame(mat)
names(df) <- c("Year", "Total_Emissions")

with(df, plot(Year, Total_Emissions,
              main="US Coal PM2.5 Emmissions for Selected Years",
              ylab="US Coal PM2.5 Emissions (thousands of tons)", pch=19))

dev.copy(png, file = "plot4.png", width=450, height=450)
dev.off()





     
     


