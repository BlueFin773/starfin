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

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }
  GoogleMapController mapController;
  //initial camera position on load
  CameraPosition _initialLocation = CameraPosition(target: LatLng(43.741219, -79.412415));

  //initialize geolocator and define current position
  final Geolocator _geolocator = Geolocator();
  Position _currentPosition;

  //method to retrieve current location
  _getCurrentLocation() async {
    await _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
          setState(() {
            //store the position
            _currentPosition = position;

            print('Current Position: $_currentPosition');

            //move camera to current position
            mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 18.0,
                ),
              ),
            );
          });
    }).catchError((e){
      print(e);
    });
  }

  //method to retrieve the address based on coordinates

/*  _getAddress() async {
    try {
      List<Placemark> p = await _geolocator.placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude
      );

      Placemark place = p[0];

      setState(() {
        var _currentAddress = "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    }
  }*/



  Widget build(BuildContext context) {
    final List userSelected = ModalRoute.of(context).settings.arguments;
    List<Location> locations = getLocations();
    List<Location> selectedLocations = locations.where((location) => userSelected.contains(location.id)).toList();
    log(selectedLocations.toString());
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialLocation,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }

}