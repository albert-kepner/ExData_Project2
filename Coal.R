# Read the input files into R...
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

library(dplyr)

# find col combustion related SCC
scc_coal <- SCC %>% select(SCC, EI.Sector) %>% filter(grepl("Coal",EI.Sector))

#join tow table 
coal <- merge(NEI, scc_coal, by= "SCC")

#summary by year
s <- with(coal, tapply(Emissions, as.character(year), sum))

#create data frame and plot
d <- data.frame(Year=names(s), CoalPM2.5 = s)

plot(d$Year, d$CoalPM2.5, pch=19)


## plot(as.numeric(d$Year), d$CoalPM2.5, pch=19)



