baltimoreTotalEmission <- function() {
  ##Load "plyr" library
  library(plyr)

  ##Load dataset
  scc <- readRDS(file = "Source_Classification_Code.rds");
  pm25 <- readRDS(file = "summarySCC_PM25.rds");
  
  baltimorePM25 <- pm25[pm25["fips"] == "24510",]
  
  emissionsByYear <- ddply(baltimorePM25, "year", summarise, total = sum(Emissions))
  
  ##Plot
  png(filename="plot2.png")
  plot(x    = emissionsByYear$year,
       y    = emissionsByYear$total / 1000,
       type = "l",
       ylab = "Total Emissions from All Sources (kilotons)",
       xlab = "Year"
       )
  dev.off()
}