motorEmissionInCitiesByYear <- function(){
  library(plyr)
  library(ggplot2)
  
  scc <- readRDS(file = "Source_Classification_Code.rds")
  pm25 <- readRDS(file = "summarySCC_PM25.rds")
  
  subsetPM25 <- pm25[pm25$fips == "24510" | pm25$fips == "06037",]
  
  motorSources <- scc[grepl("*Vehicles", scc$EI.Sector),]
  motorPM25 <- subsetPM25[subsetPM25$SCC %in% motorSources$SCC,]
  
  emissionsByYear <- ddply(motorPM25, c("year", "fips"), summarise, total = sum(Emissions))
  
  emissionsByYear$city <- ifelse(emissionsByYear$fips == "24510", "Baltimore", "Los Angeles")
  
  png(filename="plot5.png")
  qplot(x      = year,
        xlab   = "Year",
        y      = total,
        ylab   = "Total Emissions",
        data   = emissionsByYear,
        color  = city,
        geom   = c("point", "smooth"),
        method = "loess")
  dev.off()
}