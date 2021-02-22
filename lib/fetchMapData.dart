import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:starfin/model/location.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';



//https://maps.googleapis.com/maps/api/directions/json?
//origin=Adelaide,SA&destination=Adelaide,SA
//&waypoints=optimize:true|Barossa+Valley,SA|Clare,SA|Connawarra,SA|McLaren+Vale,SA
//&key=googleAPI

String googleAPI = "AIzaSyCunipxVC-TLKSc12VPCpIGXATiO2GMm5I";
final List<LatLng> coordinates = [];
var endpointUrl= "https://maps.googleapis.com/maps/api/directions/json";

//format coordinates list to be used in url minus the last coordinate in the list
 formatCoordinates(List<LatLng> coordinates){
   String formatedCoordinates = '';
   if(coordinates == null){
     return print('coordinates are null');
   }else {
     for (int i = 0; i < coordinates.length-1; i++) {
        var coord = coordinates[i];
        formatedCoordinates = formatedCoordinates + coord.latitude.toString() + ',' + coord.longitude.toString() + '|';
     }
     return formatedCoordinates;
   }
}
// format the last coordinate in the list
formatCoordinate(LatLng point) {
   String formatedCoordinate = point.latitude.toString() + ',' + point.longitude.toString();
   return formatedCoordinate;
}

Future<Map<String,dynamic>> fetchMap(Position currentPosition, List<Location> locations) async{
  coordinates.clear();
  print(currentPosition);
  for(final location in locations){
    coordinates.add(LatLng(location.lat, location.lng));
  }
  print(coordinates);
  print(formatCoordinates(coordinates));
  print(formatCoordinate(coordinates[coordinates.length-1]));
  String _formattedCoords = formatCoordinates(coordinates);
  String _destinationCoord = formatCoordinate(coordinates[coordinates.length-1]); //TODO: make destination coordinate the farther away in the list
  //create the correct url
  Map<String,String> queryParams = {
    'origin': currentPosition.latitude.toString() + ',' + currentPosition.longitude.toString(),
    'destination': _destinationCoord,
    'waypoints': 'optimize:true|' + _formattedCoords,
    'key': googleAPI
  };
  String queryString = Uri(queryParameters: queryParams).query;
  var requestUrl = endpointUrl + '?' +queryString;
  print(requestUrl);
  final response = await http.get(requestUrl);
   if(response.statusCode == 200) {
     Map<String,dynamic> map = json.decode(response.body);
     //print(map);
     // List<MapData> posts = body
     //     .map(
     //       (dynamic item) => MapData.fromJson(item),
     // )
     //     .toList();

     return map;
   }else{
     throw Exception('Failed to load album');
   }
}





// To parse this JSON data, do
//
//     final mapData = mapDataFromJson(jsonString);


MapData mapDataFromJson(String str) => MapData.fromJson(json.decode(str));

String mapDataToJson(MapData data) => json.encode(data.toJson());

class MapData {
  MapData({
    this.geocodedWaypoints,
    this.routes,
    this.status,
  });

  List<GeocodedWaypoint> geocodedWaypoints;
  List<Route> routes;
  String status;

  factory MapData.fromJson(Map<String, dynamic> json) => MapData(
    geocodedWaypoints: List<GeocodedWaypoint>.from(json["geocoded_waypoints"].map((x) => GeocodedWaypoint.fromJson(x))),
    routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "geocoded_waypoints": List<dynamic>.from(geocodedWaypoints.map((x) => x.toJson())),
    "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
    "status": status,
  };
}

class GeocodedWaypoint {
  GeocodedWaypoint({
    this.geocoderStatus,
    this.placeId,
    this.types,
  });

  String geocoderStatus;
  String placeId;
  List<String> types;

  factory GeocodedWaypoint.fromJson(Map<String, dynamic> json) => GeocodedWaypoint(
    geocoderStatus: json["geocoder_status"],
    placeId: json["place_id"],
    types: List<String>.from(json["types"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "geocoder_status": geocoderStatus,
    "place_id": placeId,
    "types": List<dynamic>.from(types.map((x) => x)),
  };
}

class Route {
  Route({
    this.bounds,
    this.copyrights,
    this.legs,
    this.overviewPolyline,
    this.summary,
    this.warnings,
    this.waypointOrder,
  });

  Bounds bounds;
  String copyrights;
  List<Leg> legs;
  Polylines overviewPolyline;
  String summary;
  List<dynamic> warnings;
  List<int> waypointOrder;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    bounds: Bounds.fromJson(json["bounds"]),
    copyrights: json["copyrights"],
    legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
    overviewPolyline: Polylines.fromJson(json["overview_polyline"]),
    summary: json["summary"],
    warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
    waypointOrder: List<int>.from(json["waypoint_order"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "bounds": bounds.toJson(),
    "copyrights": copyrights,
    "legs": List<dynamic>.from(legs.map((x) => x.toJson())),
    "overview_polyline": overviewPolyline.toJson(),
    "summary": summary,
    "warnings": List<dynamic>.from(warnings.map((x) => x)),
    "waypoint_order": List<dynamic>.from(waypointOrder.map((x) => x)),
  };
}

class Bounds {
  Bounds({
    this.northeast,
    this.southwest,
  });

  Northeast northeast;
  Northeast southwest;

  factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
    northeast: Northeast.fromJson(json["northeast"]),
    southwest: Northeast.fromJson(json["southwest"]),
  );

  Map<String, dynamic> toJson() => {
    "northeast": northeast.toJson(),
    "southwest": southwest.toJson(),
  };
}

class Northeast {
  Northeast({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory Northeast.fromJson(Map<String, dynamic> json) => Northeast(
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Leg {
  Leg({
    this.distance,
    this.duration,
    this.endAddress,
    this.endLocation,
    this.startAddress,
    this.startLocation,
    this.steps,
    this.trafficSpeedEntry,
    this.viaWaypoint,
  });

  Distance distance;
  Distance duration;
  String endAddress;
  Northeast endLocation;
  String startAddress;
  Northeast startLocation;
  List<Step> steps;
  List<dynamic> trafficSpeedEntry;
  List<dynamic> viaWaypoint;

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
    distance: Distance.fromJson(json["distance"]),
    duration: Distance.fromJson(json["duration"]),
    endAddress: json["end_address"],
    endLocation: Northeast.fromJson(json["end_location"]),
    startAddress: json["start_address"],
    startLocation: Northeast.fromJson(json["start_location"]),
    steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
    trafficSpeedEntry: List<dynamic>.from(json["traffic_speed_entry"].map((x) => x)),
    viaWaypoint: List<dynamic>.from(json["via_waypoint"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "distance": distance.toJson(),
    "duration": duration.toJson(),
    "end_address": endAddress,
    "end_location": endLocation.toJson(),
    "start_address": startAddress,
    "start_location": startLocation.toJson(),
    "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
    "traffic_speed_entry": List<dynamic>.from(trafficSpeedEntry.map((x) => x)),
    "via_waypoint": List<dynamic>.from(viaWaypoint.map((x) => x)),
  };
}

class Distance {
  Distance({
    this.text,
    this.value,
  });

  String text;
  int value;

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
    text: json["text"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "value": value,
  };
}

class Step {
  Step({
    this.distance,
    this.duration,
    this.endLocation,
    this.htmlInstructions,
    this.polyline,
    this.startLocation,
    this.travelMode,
    this.maneuver,
  });

  Distance distance;
  Distance duration;
  Northeast endLocation;
  String htmlInstructions;
  Polylines polyline;
  Northeast startLocation;
  TravelMode travelMode;
  String maneuver;

  factory Step.fromJson(Map<String, dynamic> json) => Step(
    distance: Distance.fromJson(json["distance"]),
    duration: Distance.fromJson(json["duration"]),
    endLocation: Northeast.fromJson(json["end_location"]),
    htmlInstructions: json["html_instructions"],
    polyline: Polylines.fromJson(json["polyline"]),
    startLocation: Northeast.fromJson(json["start_location"]),
    travelMode: travelModeValues.map[json["travel_mode"]],
    maneuver: json["maneuver"] == null ? null : json["maneuver"],
  );

  Map<String, dynamic> toJson() => {
    "distance": distance.toJson(),
    "duration": duration.toJson(),
    "end_location": endLocation.toJson(),
    "html_instructions": htmlInstructions,
    "polyline": polyline.toJson(),
    "start_location": startLocation.toJson(),
    "travel_mode": travelModeValues.reverse[travelMode],
    "maneuver": maneuver == null ? null : maneuver,
  };
}

class Polylines {
  Polylines({
    this.points,
  });

  String points;

  factory Polylines.fromJson(Map<String, dynamic> json) => Polylines(
    points: json["points"],
  );

  Map<String, dynamic> toJson() => {
    "points": points,
  };
}

enum TravelMode { DRIVING }

final travelModeValues = EnumValues({
  "DRIVING": TravelMode.DRIVING
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

