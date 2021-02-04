import 'package:flutter/material.dart';
import 'package:starfin/match.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:starfin/model/location.dart';
import 'package:starfin/utils/store.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Widget build(BuildContext context) {
    final List userSelected = ModalRoute.of(context).settings.arguments;
    return Container(
      child: Text(userSelected.toString())
    );
  }
}