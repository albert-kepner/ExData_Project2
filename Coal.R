# Read the input files into R...
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

coal <- subset(SCC, EI.Sector == "Fuel Comb - Comm/Institutional - Coal")

coal_source <- as.character(coal$SCC)




