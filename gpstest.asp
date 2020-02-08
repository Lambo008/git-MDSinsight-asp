﻿
HTML Source Code:

<html>
<head>

<script type="text/javascript">

function getGPS() {
	if (navigator.geolocation) {  
		navigator.geolocation.getCurrentPosition(showGPS, gpsError);
	} else {  
		gpsText.innerText = "No GPS Functionality.";  
	}
}

function gpsError(error) {
	alert("GPS Error: "+error.code+", "+error.message);
}

function showGPS(position) {
	gpsText.innerText = "Latitude: "+position.coords.latitude+"\nLongitude: "+position.coords.longitude;
	
	// alternate
	//gpsText.innerHTML = "<a href='http://maps.google.com/maps?q="+position.coords.latitude+","+position.coords.longitude+"+(Your+Location)&iwloc=A&z=17'>"+position.coords.latitude+","+position.coords.longitude+"</a>";
}

</script>
</head>

<body>

<a href=# onclick="getGPS()">Get GPS Data</a>

<div id=gpsText></div>

</body>
</html>

