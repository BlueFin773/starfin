// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'welcome.dart';
import 'rate.dart';

void main() => runApp(Starfin());

class Starfin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        accentColor: Color(0xFF6C63FF),
        textTheme: TextTheme(bodyText2:TextStyle(color: Color(0xFF59606D,))),


        buttonTheme: ButtonThemeData(
          minWidth: 200.0,
          height: 75.0,
          buttonColor: Color(0xFF6C63FF),
          textTheme: ButtonTextTheme.primary,

        ),
        fontFamily: 'Overpass_Mono',
      ),
      home: RatePage(),
    );
  }
}

