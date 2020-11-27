import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children:[
            Text("Welcome to StarFin!"),
            Text("StarFin helps you create a custom day plan to visit tourist attractions in the Toronto area based on your preference."),
            Image.asset('assets/images/map.png'),
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    );
    throw UnimplementedError();
  }
}