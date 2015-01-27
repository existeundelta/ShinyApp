library(shiny)

shinyUI(fluidPage(
  headerPanel("Solar Sunrise & Sunset around the World from a date"),
  sidebarPanel(
    dateInput("date", "From Date:"),
    sliderInput("n", "Number of days ahead:", 
                min=0, max=1000, value=360),
    sliderInput("lat", "Latitud:", 
               min = -90, max = 90, value = 0.5, step= 0.0001),
    sliderInput("lon", "Longitud:", 
                min = -180, max = 180, value = 0.5, step= 0.0001),
    tags$div(HTML('
        <p id="demo">Lat,Lon;</p>
        <button onclick="updateMap()">Click the Button to Update Map with the actual Lat/Lon</button>
        <br/>
        <div id="mapholder"></div>
        
        <script>
        var x = document.getElementById("demo");
        
        function getLocation() {
          if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition, showError);
          } else {
            x.innerHTML = "Geolocation is not supported by this browser.";
          }
        }
        
        function showPosition(position) {
          var latlon = position.coords.latitude + "," + position.coords.longitude;
          var lat = $("#lat").data("ionRangeSlider");
          var lon = $("#lon").data("ionRangeSlider");
          lat.update({from:position.coords.latitude});
          lon.update({from:position.coords.longitude});
          x.innerHTML=latlon;
          var img_url = "http://maps.googleapis.com/maps/api/staticmap?center="
          +latlon+"&zoom=7&size=400x300&sensor=false";
          document.getElementById("mapholder").innerHTML = "<img src="+img_url+">";
        }
        
        function showError(error) {
          switch(error.code) {
            case error.PERMISSION_DENIED:
            x.innerHTML = "User denied the request for Geolocation."
            break;
          case error.POSITION_UNAVAILABLE:
            x.innerHTML = "Location information is unavailable."
            break;
          case error.TIMEOUT:
            x.innerHTML = "The request to get user location timed out."
            break;
          case error.UNKNOWN_ERROR:
            x.innerHTML = "An unknown error occurred."
            break;
          }
        }
        getLocation();

        function updateMap() {
       
          var latlon = lat.value + "," + lon.value;
      
          x.innerHTML=latlon;
          var img_url = "http://maps.googleapis.com/maps/api/staticmap?center="
          +latlon+"&zoom=3&size=400x300&sensor=false";
          document.getElementById("mapholder").innerHTML = "<img src="+img_url+">";
        }
        </script>              
        <a href="https://github.com/existeundelta/ShinyApp">GitHub repository</a>
        <br/>
        <a href="https://xavijacas.shinyapps.io/ShinyApp/PPT.html">App Presentation</a>
        <a href="http://rpubs.com/existeundelta/55279">App Presentation in Rpubs</a>
        <script src="https://xavijacas.shinyapps.io/ShinyApp/analytics.js"></script>
    '))
  ),
  mainPanel(
    plotOutput("nText2")
  )
))