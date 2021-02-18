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
  String polyline = "_hiaGpn}~N`@_E_IsAmC|B{G~AEud@bYqn@`hAk_CrLgUzReGfs@u@be@ShFpFsFMnQehBh@{nBa]}bAwq@wbBjPu{BaFo}@ie@s[et@yP_b@m]cSwbBcDqrBjFez@eQooEuJwnDy~AmiEytAolAym@s_Dgl@ccC_r@sq@_Nil@iIimGkb@_u@eKsf@~TcyAtIyhBvVqlAj@cuA}DgnG}FeeGqHudL~HuvA|b@sw@uBmpBuAojBmXwpBgLwnBlGa~@tQ_UpZuA`[mCbW}Ypk@euBrg@u|AtWcv@k^wgBchAkfCacAsxCeUeZwWu{@ie@wlB}HyiA_]cn@}T_nAwo@{vCk}AivBgfC}fAo]~Aa[tc@}UnBuz@q^qg@eOgu@tDksBbCuoAlBsn@m[w{A{nA{IgpA_Ni\\a_Ast@iEa~@wQa]anAoGw~FiPkmAgI{vBogA_dC{oAov@eb@m`@}q@waA}gBswBw~CqlBulDkcAoqButAagBotF{kH_yCyyE{rGojKyuCyqE_aBqgC}b@yVcqGxLq_@oc@sYex@gT}N}m@D_TqAuSc]cVgs@oTmDwi@gVeMav@kP}vAk[wr@qD}jB~Had@v\\sg@fWqj@pHwsFyUwiBQixCUg{CcTik@`GgjQzHktPo@wmVrI_fEeMuuGmAuii@E{`LEolC~@yiApMwc@``@s]sCtFaWo]g`Be`CPafBnMecLpNalMtBw~B{Z}cB{eAqtF_eAwlFo@uOt_@aPhe@}}@xi@yy@jqAwl@xYsLg@iNfRsHdf@qR`@a[uFio@~JqrAxO{mCfi@iTdoByZrgAwU`\\cW|Jo@kIqGqZyiEaYszEgq@yuBixAscPaaAkhL_WqfBss@sdAcdEs|GwfFkdIq{GelKe`AifCgOemAwRibB{BmtAkiA_lOiYgjEp]ygDqB{iB{YiqD}z@erImSyr@ku@yaGgk@grF{TsdDcK_iBtJsjAz^ykHuR{nGcMyoDmz@odFeh@e_Dwj@i`BSspBwFyjAi~@aqEmTwiAHwp@pS_}AoL{hCkg@w{@{`CqmBmb@oCuU{ZiXmvBmSet@qZ{t@{Twv@yOi`@oq@sEgh@|@mTkD_[fO}QpNgTiEcj@{rAg_AigBuoCw~Ck\\yh@}Mqi@sYq_@_z@}iB_iGibHcpEccFmoEefFkgAecA_aC_@wu@iFiuBm_C}lD}`Eke@_y@cw@_i@ozC{gD{|CsvDiu@e~G}Uy_Byd@_iAm_@a`AcHky@pg@arCia@upDuAyz@_NiK}Dy]";

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
    fetchMap(_currentPosition, selectedLocations);

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