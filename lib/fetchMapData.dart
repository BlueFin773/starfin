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


Future<http.Response> fetchMap(Position currentPosition, List<Location> locations){
  coordinates.clear();
  print(currentPosition);
  //create the correct url
  Map<String,String> queryParams = {
    'origin': currentPosition.toString(),
    'destination': 'CN Tower',
    'waypoints': 'optimize:true' + 'Eaton Center',
    'key': googleAPI
  };
  String queryString = Uri(queryParameters: queryParams).query;
  var requestUrl = endpointUrl + '?' +queryString;
  print(requestUrl);
  var response = http.get(requestUrl);

  for(final location in locations){
    coordinates.add(LatLng(location.lat, location.lng));

  }
  print(coordinates);
  return response;

}