library(StreamMetabolism)
library(lubridate)

get.sunrise <- function(lat, lon, date, n){
  tmp <- sunrise.set(lat, lon, date, timezone="UTC", num.days = n)  
  solar <- tmp
  solar$sunrise <- POSIXctToHour(tmp[,1]) #hour(tmp[,1]) + minute(tmp[,1]) / 60 + second(tmp[,1]) / 3600
  solar$sunset <- POSIXctToHour(tmp[,2])

  return (solar)
}

POSIXctToHour <- function(POSIXct){
  hour <- hour(POSIXct) + minute(POSIXct) / 60 + second(POSIXct) / 3600
  return (hour)
}

defaultNumeric <- function(input){
  if(is.null(input)){
    output=0
  }else{
    if (input == "") {
      output=0
    }else{
      if (is.numeric(input) == FALSE) {
        output=0
      }     
    }
  }
  return (output)
}
  
shinyServer(function(input, output, clientData) {
  
  output$nText2 <- renderPlot({
    
    lat <- input$lat
    lon <- input$lon
    
    time <- get.sunrise(lat, lon, input$date,input$n)
    plot(time$sunrise , ylab='Time UTC',xlab='Days', col='red',main='Solar Events', ylim=c(0,24))
    par(new=T)
    plot(time$sunset, ylab='Time',xlab='Days', col='Midnight Blue',main='Solar Events', ylim=c(0,24))
    par(new=F)
    legend('topright', pch=c(19,19),col=c('Midnight Blue','red'),legend=c('Sunset','Sunrise'))
  })
})