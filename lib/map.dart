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
  String polyline = "yxjiG|bpcNLb@^t@f@t@`@n@DJhA`Bh@q@`@_@`@SrAa@p@WJCG_@Gm@@q@IaBS}Aq@oFw@aDY}@u@sB_A_CWe@eB}D}AmDi@sA?MCWIWm@mBe@aB{@_CeEiK}@wCg@{Bg@oCYsB]gDU{BY_CMkAQqAB_@UcB{AoLw@yF[sB[wA]gBe@gDg@_D]yAcAsDi@iCYeAgAqE}@wDY}AWkCGyBB{@r@oAp@_ATc@Ne@No@@s@Au@Ck@m@i@m@CeBMg@?]Ba@P`@Q\\Cf@?dBLl@BHXHf@@LBl@GdAGXg@bAkAbBm@jBKp@?h@Bb@`@tBJd@JNFXvApGf@rBxAfGzAbId@`DnBbNbBvL|Db[fAfIVhAz@jCXx@[J_Bj@iDdAqAd@KFIJSH}Ab@QDHTNT\\f@NVh@~A`@|BZrB|Ag@pFeBhBm@ZMbAe@|Bs@zAg@h@UfDoBpA|FpApF|@lDXjAZdDPvBQwB[eDYkA}@mDqAqFqA}FgDnBi@T{Af@sA`@i@Pc@NS@]FyBp@qEvAoBj@]XwFpBiBj@{LxDyH`CSLMPYnAITOP}@ZaFvAeD~@uBj@";

  //initial camera position on load
  CameraPosition _initialLocation = CameraPosition(target: LatLng(43.64294036123222, -79.38707728379016),  zoom: 10.0);

  //initialize geolocator and define current position
  final Geolocator _geolocator = Geolocator();
  Position _currentPosition;

  final Map<String,Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();

  //fetch google api data


  //gets the selected locations and defines markers for those locations based on latitude and longitude
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final List userSelected =  ModalRoute.of(context).settings.arguments;
    List<Location> locations =  getLocations();
    List<Location> selectedLocations = locations.where((location) => userSelected.contains(location.id)).toList();
    log(selectedLocations.toString());
    mapController = controller;
    await _getCurrentLocation();
    var data = fetchMap(_currentPosition, selectedLocations);
    print(data);



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
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialLocation,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        onMapCreated: _onMapCreated,
        markers: _markers.values.toSet(),
        polylines: _polylines,
      ),
    );
  }
}