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
            SizedBox(
              height: 20,
            ),
            Text("Welcome to StarFin!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36, ),
              textAlign: TextAlign.center
            ),
            SizedBox(
              height: 40,
            ),
            Text("StarFin helps you create a custom day plan to visit tourist attractions in the Toronto area based on your preferences.",
                style: TextStyle(fontSize:18),
                textAlign: TextAlign.center
            ),
            SizedBox(
              height: 60,
            ),
            Image.asset('assets/images/map2.png'),
            SizedBox(
              height: 100,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("Let's Go!", style: TextStyle(fontSize: 18.0)),
             )
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}