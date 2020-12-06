import 'package:flutter/material.dart';

class RatePage extends StatefulWidget {
  @override
  _RatePageState createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text("Rate It!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36,),
                textAlign: TextAlign.center
            ),
            SizedBox(
              height: 40,
            ),
            Text(
                "Use the sliders to rate your preference towards different types of attractions.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center
            ),

            //TODO: Create sliders

            RaisedButton(
              onPressed: () {},
              child: Text("RATE IT!", style: TextStyle(fontSize: 18.0)),
            )
          ],
        ),
      ),
    );
  }
}