baltimoreEmissionsByType <- function(){

  ##Load "plyr" and "ggplot2" libraries
  library(plyr)
  library(ggplot2)

  ##Load data
  scc <- readRDS(file = "Source_Classification_Code.rds");
  pm25 <- readRDS(file = "summarySCC_PM25.rds");
  
  baltimorePM25 <- pm25[pm25["fips"] == "24510",]
  baltimorePM25$typefactor <- factor(baltimorePM25$type)
  
  emissionsByYearByType <- ddply(baltimorePM25, c("year", "typefactor"), summarise, total = sum(Emissions))
  
  ##Plot
  png(filename="plot3.png")
  qplot(x = year,
        xlab = "Year",
        y = total,
        ylab = "Total Emissions (tons)",
        data = emissionsByYearByType,
        color = typefactor,
        geom = c("point", "smooth"),
        method = "loess")
  dev.off()
}