coalCombustion <- function() {
  library(plyr)
  library(ggplot2)
  
  scc <- readRDS(file = "Source_Classification_Code.rds");
  pm25 <- readRDS(file = "summarySCC_PM25.rds");
  
  coalSources <- scc[grepl("Fuel Comb.*Coal", scc$EI.Sector),]
  
  coalPM25 <- pm25[pm25$SCC %in% coalSources$SCC,]
  
  emissionsByYear <- ddply(coalPM25, "year", summarise, total = sum(Emissions))
  
  png(filename="plot4.png")
  qplot(x      = year,
        xlab   = "Year",
        y      = total,
        ylab   = "Total Emissions (tons)",
        data   = emissionsByYear,
        geom   = c("point", "smooth"),
        method = "loess")
  dev.off()
}