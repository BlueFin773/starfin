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
  String googleAPI = "AIzaSyCunipxVC-TLKSc12VPCpIGXATiO2GMm5I";
  //test polyline
  String polyline = "h`vmE{`|y[xgLxfAbi@ptWfiCjje@ruU|cS~i^~|Tt~Yv_Y|vLph]rnUjwUxgWvgi@nyIbua@saAncLd`GzsMrmEvol@at@lx_A|fEhdW}uDtk\\ydEzvYvkFphVzbD`k}@hqKftSbhYlbPrdNbmK``E|pQxbMvi\\|wL~nNprE|tLruG}jA~zMbiHbgKfcItt_@v~\\ftEntQ|cPziKn_WvvU~v@fiWpwVfuGxpJfvXerCjkS|lHv}NxeI`p`@joOl~Kf}Q|mEnlGtrRrhNpdYxmc@vvyAraSlkSnqHx_\\vdJ~t]dmT|o\\zap@tcKhnj@jkOfkLtwC|mLajCt_P{z@nnBtdP~kDcmFxjMgaCtdB`pTgyL~sSouKfp`@{cDnuXeqIzmUioIdobAind@nuxC{dNzgl@ahMjxKm~f@br`@stf@t}hAsxSx|^{id@vcLseQ`gXerKvbj@ztG|ogAyvO`wtBqgYpgv@gsZrfg@m}Vjaf@y~r@tpr@{v`@tiXca[~va@}tVdsUcyIxkT|HhmPgvEjqd@e{JxvSckLpeh@_nJ|ySm{LhiC_kXy{@k~b@jjW}xcAv_x@si_@wmIoiMrcGwmNqk@g}g@s`Hkc^~qFoc_@bf@yvYzsPoy]dbJuaKlbHesa@baCoo`@lnGsk[zc]zeM`|Y~~Kvge@neEvd]r{Jlm[vuUhiSdpo@xu}@fqFbqs@bdSbsUg`Ebs}@aiGpzt@khB|sYwlJ`|Q_vWlph@mgXt_`@utTj~v@eya@rl_@}hXb|XrLlgZ}jJvjKk`Zf{c@qvNv`w@kbCfaa@gk\\`bn@cxDlkoAszPrr|@e~@xlcA_~DprWw|TvlTabYpe^ioW~h|@{eKx~`A|dSroxAb_Plbu@tuBnou@buCtn_BliIpyfBdlCdhdAxt[nwtBfwLx|tBztBh|`DfxJ~xn@zhEd`aAbxLfzmAb~Pjte@dwThlm@nxDdfm@zoHfvlAlyDbmo@`qGbbhAtpFdufAgp]riy@izo@higBeiGtja@p|Ihz\\rhAptmBzoJh|v@nyFrjFq`EloE{oAnhFsySv`Ee{^lfEgzXytKozNjzKghWjvEstKxkGumx@vfXutZrqXgqM~z_@hgNrly@pcXbrr@|eJpjdAfwFl`c@jxAtzaBszCjam@dbLt_k@`qKllp@ca@hr_@~|SztiAvfXbujAv}Dp}yAlv@xwg@y~EloZbsEppKuw@bz^}gAhmXrrQrff@toQt}\\vdLbxHt`BtdPmBrvc@hpGbk]jf@|k@";

  //initial camera position on load
  CameraPosition _initialLocation = CameraPosition(target: LatLng(43.64294036123222, -79.38707728379016),  zoom: 10.0);

  //initialize geolocator and define current position
  final Geolocator _geolocator = Geolocator();
  Position _currentPosition;

  final Map<String,Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();

  //gets the selected locations and defines markers for those locations based on latitude and longitude
  Future<void> _onMapCreated(GoogleMapController controller) {
    final List userSelected =  ModalRoute.of(context).settings.arguments;
    List<Location> locations =  getLocations();
    List<Location> selectedLocations = locations.where((location) => userSelected.contains(location.id)).toList();
    log(selectedLocations.toString());
    mapController = controller;

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

            print('Current Position: $_currentPosition');

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