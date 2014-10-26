totalEmissionOverTime <- function() {
  ##Load "plyr" library
  library(plyr)
  
  ##Load dataset
  scc <- readRDS(file = "Source_Classification_Code.rds");
  pm25 <- readRDS(file = "summarySCC_PM25.rds");
  
  emissionsByYear <- ddply(pm25, "year", summarise, total = sum(Emissions))
  
  ##Plot
  png(filename="plot1.png")
  plot(x = emissionsByYear$year, y = emissionsByYear$total / 1000, type = "l",
    ylab = "Total Emissions from All Sources (kilotons)", xlab = "Year")
  dev.off()
}