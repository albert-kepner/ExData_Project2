# plot3.R
#
# Question 3:
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting 
## system to make a plot answer this question.


# Read the input files into R...
NEI <- readRDS("data/summarySCC_PM25.rds")
NEI <- NEI[NEI$fips == 24510,]


NEI <- transform(NEI, yearFactor = factor(as.character(year)))

NEI_by_year <- with(NEI, split(NEI, yearFactor))

rows <- numeric()
types <- character()


for(yearData in NEI_by_year) {
  yearByType <- split(yearData, yearData$type )
  for(data in yearByType) {
    year <- data[1,6]
    yearEmissions = sum(data[,4])
    type <- data[1,5]
    rows <- c(rows, year, yearEmissions)
    types <- c(types, type)
  }
}


mat <- matrix(rows,  ncol=2, byrow=TRUE)
df <- data.frame(mat)
names(df) <- c("Year", "Total_Emissions")

df$type <- types

df <- transform(df, type=factor(type))

library(ggplot2)
g <- ggplot(df, aes(x=Year, y=Total_Emissions))

g+geom_point( aes(col=type), size=2) +
  labs(title="Baltimore City PM2.5 Emission Sources by Year", y="Total Emissions (tons)")


dev.copy(png, file = "plot3.png", width=450, height=450)
dev.off()





     
     


