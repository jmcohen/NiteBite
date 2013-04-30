var map;
var service;
var center;
var placeIds = {};
var places = [];

// The Place class

function Place(position, name, address, isOpen){
	this.position_ = position;
	this.name_ = name;
	this.address_ = address;
	this.isOpen_ = isOpen;

	var icon = {
		path: google.maps.SymbolPath.CIRCLE,
		fillColor: this.isOpen_? 'lime' : 'red',
		fillOpacity: .7,
		scale: 15,
		strokeWeight: 0,
	};
	
	this.marker = new google.maps.Marker({
		position: position,
		map: map,
		icon: icon,
	});
	
	
	google.maps.event.addListener(marker, 'click', function(){
		$('#popup-name').fadeOut(300, function(){
			$(this).text(name).fadeIn(300);
		})
		
		$('#popup-address').fadeOut(300, function(){
			$(this).text(address).fadeIn(300);
		})
	});

	this.marker.setMap(map);	
}

function loadPlaces(){
	center = map.getCenter();
	var searchRequest = {
		location: center,
		rankBy: google.maps.places.RankBy.DISTANCE,
		types: ['bakery', 'bar', 'cafe', 'convenience_store', 'liquor_store', 'meal_delivery', 'meal_takeaway', 'night_club', 'restaurant'],
	};
	
	service.nearbySearch(searchRequest, function(searchResults, status, pagination){
		if (status == google.maps.places.PlacesServiceStatus.OK){

			// Request another page
			if (pagination.hasNextPage){
			  pagination.nextPage();
			}
		
			for (var i = 0; i < searchResults.length; i++){
			    console.log(searchResults[i]);
				if (searchResults[i].opening_hours != null){
					if (searchResults[i].id in placeIds == false){
						var position = searchResults[i].geometry.location;
						var name = searchResults[i].name;
						var address = searchResults[i].vicinity;
						var isOpen = searchResults[i].opening_hours.open_now;
						Place(position, name, address, isOpen);
					}
					placeIds[searchResults[i].id] = true;
				}
				searchResults[i] = null;
			}
		}
	});
}
  
function initialize() {
	var nightMapStyles = [
		{
			featureType: 'all',
			elementType: 'labels',
			stylers: [ {visibility: 'off'} ]
	 	},
		{
			featureType: 'landscape',
			elementType: 'all',
			stylers: [ {hue: '#000000'}, {lightness: -100} ]
	 	},
	 	{
			featureType: 'road',
			elementType: 'all',
			stylers: [ {visibility: 'simplified'} , {hue: '#FFFFFF'}, {lightness: 100} ]
	 	},
		{
			featureType: 'poi',
			elementType: 'all',
			stylers: [ {visibility: 'off'} ]
		},
		{
			featureType: 'water',
			elementType: 'all',
			stylers: [ {lightness: -80} ]
		},         
	];
	
	var nightMapType = new google.maps.StyledMapType(nightMapStyles);
  
	var mapOptions = {
		center: new google.maps.LatLng(40.7142, -74.0064),
		zoom: 18,
	  	mapTypeControlOptions: {
			mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'night']
	  	},
		disableDefaultUI: true,
	};
	
	map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
	map.mapTypes.set('night', nightMapType);
	map.setMapTypeId('night');
	service = new google.maps.places.PlacesService(map);
	
	var popup = $('#popup').get(0);
	map.controls[google.maps.ControlPosition.TOP].push(popup);

	loadPlaces();
	setInterval(function(){
		if (!center.equals(map.getCenter())){
			loadPlaces();
		}
	}, 5000);     
}