import 'package:flutter/material.dart';
import 'match.dart';

class RatePage extends StatefulWidget {
  @override
  RatePageState createState() => RatePageState(5,5,5,5,5);
}

class RatePageState extends State<RatePage> {
  int culture;
  int nature;
  int entertainment;
  int historical;
  int architecture;

  //needed to pass on state to next page
  RatePageState(this.culture,this.nature,this.entertainment,this.historical,this.architecture);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Rate It!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36,),
                textAlign: TextAlign.center
            ),
            SizedBox(
              height: 20,
            ),
            Text(
                "Use the sliders to rate your preference towards different types of attractions.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center
            ),
            SizedBox(
              height: 20,
            ),

            // culture slider
            Text(
                  "Culture",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center
            ),
              new Expanded(
              child: Slider(
                value: culture.toDouble(),
                min:1.0,
                max:10.0,
                divisions:9,
                activeColor: Color(0xFF6C63FF),
                inactiveColor: Color(0xFF707070),
                onChanged:(double newValue){
                  setState((){
                    culture = newValue.round();
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
                value: nature.toDouble(),
                min:1.0,
                max:10.0,
                divisions:9,
                activeColor: Color(0xFF6C63FF),
                inactiveColor: Color(0xFF707070),
                onChanged:(double newValue){
                  setState((){
                    nature = newValue.round();
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
                value: entertainment.toDouble(),
                min:1.0,
                max:10.0,
                divisions:9,
                activeColor: Color(0xFF6C63FF),
                inactiveColor: Color(0xFF707070),
                onChanged:(double newValue){
                  setState((){
                    entertainment = newValue.round();
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
                value: historical.toDouble(),
                min:1.0,
                max:10.0,
                divisions:9,
                activeColor: Color(0xFF6C63FF),
                inactiveColor: Color(0xFF707070),
                onChanged:(double newValue){
                  setState((){
                    historical = newValue.round();
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
                value: architecture.toDouble(),
                min:1.0,
                max:10.0,
                divisions:9,
                activeColor: Color(0xFF6C63FF),
                inactiveColor: Color(0xFF707070),
                onChanged:(double newValue){
                  setState((){
                    architecture = newValue.round();
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
                  //navigate to the Match page and pass on the state of the sliders
                  MaterialPageRoute(builder: (context) => MatchPage(),settings: RouteSettings(arguments: RatePageState(culture,nature,entertainment,historical,architecture))),
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