import 'package:flutter/material.dart';
import 'match.dart';

class RatePage extends StatefulWidget {
  @override
  _RatePageState createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  int _culture = 6;
  int _nature = 4;
  int _entertainment = 7;
  int _historical = 3;
  int _architecture = 1;
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

            SizedBox(
              height: 40,
            ),

            // culture slider
            Text(
                  "Culture",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center
            ),
              new Expanded(
              child: Slider(
                value: _culture.toDouble(),
                min:1.0,
                max:10.0,
                divisions:9,
                activeColor: Color(0xFF6C63FF),
                inactiveColor: Color(0xFF707070),
                onChanged:(double newValue){
                  setState((){
                    _culture = newValue.round();
                  });
                },
              ),
            ),

            // nature slider
            Text(
                "Nature",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center
            ),
            new Expanded(
              child: Slider(
                value: _nature.toDouble(),
                min:1.0,
                max:10.0,
                divisions:9,
                activeColor: Color(0xFF6C63FF),
                inactiveColor: Color(0xFF707070),
                onChanged:(double newValue){
                  setState((){
                    _nature = newValue.round();
                  });
                },
              ),
            ),

            // entertainment slider
            Text(
                "Entertainment",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center
            ),
            new Expanded(
              child: Slider(
                value: _entertainment.toDouble(),
                min:1.0,
                max:10.0,
                divisions:9,
                activeColor: Color(0xFF6C63FF),
                inactiveColor: Color(0xFF707070),
                onChanged:(double newValue){
                  setState((){
                    _entertainment = newValue.round();
                  });
                },
              ),
            ),

            // historical slider
            Text(
                "Historical",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center
            ),
            new Expanded(
              child: Slider(
                value: _historical.toDouble(),
                min:1.0,
                max:10.0,
                divisions:9,
                activeColor: Color(0xFF6C63FF),
                inactiveColor: Color(0xFF707070),
                onChanged:(double newValue){
                  setState((){
                    _historical = newValue.round();
                  });
                },
              ),
            ),

            // architecture slider
            Text(
                "Architecture",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center
            ),
            new Expanded(
              child: Slider(
                value: _architecture.toDouble(),
                min:1.0,
                max:10.0,
                divisions:9,
                activeColor: Color(0xFF6C63FF),
                inactiveColor: Color(0xFF707070),
                onChanged:(double newValue){
                  setState((){
                    _architecture = newValue.round();
                  });
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),


            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchPage()),
                );
              },
              child: Text("RATE IT!", style: TextStyle(fontSize: 18.0)),
            )
          ],
        ),
      ),
    );
  }
}