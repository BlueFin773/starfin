import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:starfin/match.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:starfin/model/location.dart';
import 'package:starfin/utils/store.dart';
import 'dart:developer';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:starfin/fetchMapData.dart';
import 'package:starfin/rate.dart';
import 'dart:convert';


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();

  }
  GoogleMapController mapController;


  //test polyline

  //initial camera position on load
  CameraPosition _initialLocation = CameraPosition(target: LatLng(43.64294036123222, -79.38707728379016),  zoom: 10.0);

  //initialize geolocator and define current position
  final Geolocator _geolocator = Geolocator();
  Position _currentPosition;

  final Map<String,Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<String,dynamic> mapdata;
  String polyline = "";
  List<dynamic> overviewPolyline;

  //fetch google api data


  //gets the selected locations and defines markers for those locations based on latitude and longitude
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final List userSelected =  ModalRoute.of(context).settings.arguments;
    List<Location> locations =  getLocations();
    List<Location> selectedLocations = locations.where((location) => userSelected.contains(location.id)).toList();
    log(selectedLocations.toString());
    mapController = controller;
    await _getCurrentLocation();
    await fetchMap(_currentPosition, selectedLocations).then((data){
      setState(() {
        mapdata = data;
        overviewPolyline = mapdata["routes"];
        polyline = (overviewPolyline[0]["overview_polyline"]["points"]);
      });

      print(polyline);
    });




    //set polyline equal to the API response "overview_polyline: points:"

    //decodes the google API "points"
    List<PointLatLng> result = polylinePoints.decodePolyline(polyline);

    final List<LatLng> polylineCoordinates = [];

    setState(() {
      //define the markers
      _markers.clear();
      for (final location in selectedLocations){
        final marker = Marker(
          markerId: MarkerId(location.id),
          position: LatLng(location.lat, location.lng),
          infoWindow: InfoWindow(
            title:location.name
          )
        );
        _markers[location.name] = marker;
      }
      //converts the points from result to a list of type LatLng which is required to define the polyline
      for (var point in result){
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      //creating the polyline set
      _polylines.add(Polyline(
        polylineId: PolylineId('1'),
        visible: true,
        points: polylineCoordinates,
        color: Colors.purple,
        width: 4,
      ));
    });
  }

  //method to retrieve current location
  _getCurrentLocation() async {
    await _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
          setState(() {
            //store the position
            _currentPosition = position;

            //print('Current Position: $_currentPosition');

            //move camera to current position
            mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 13.0,
                ),
              ),
            );
          });
    }).catchError((e){
      print(e);
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Text("Your Map!",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36,),
          textAlign: TextAlign.center
          ),
        new Expanded(
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialLocation,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            mapToolbarEnabled: false,
            onMapCreated: _onMapCreated,
            markers: _markers.values.toSet(),
            polylines: _polylines,
           ),
        ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                //TODO: Navigate to rate screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RatePage()),
                );
              },
              child: Text("Finish!", style: TextStyle(fontSize: 18.0)),
            )
      ]
        ),
    ),
    );
  }
}