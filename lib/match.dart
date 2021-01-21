import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

//TODO: Make list items selectable

class MatchPage extends StatefulWidget {
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  bool card1Status = false;
  bool card2Status = false;
  bool card3Status = false;
  bool card4Status = false;
  bool card5Status = false;
  bool card6Status = false;
  bool card7Status = false;
  bool card8Status = false;
  bool card9Status = false;
  bool card10Status = false;


  //TODO: get this working
  // get data from firestore database
  void getLocations(){

  }

  @override
  Widget build(BuildContext context) {
    CollectionReference locations = FirebaseFirestore.instance.collection('locations');
    return FutureBuilder<DocumentSnapshot>(
      future: locations.doc('dMF0VaYNbC3z3slY43xp').get(),
      builder:
      (BuildContext context , AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError){
          return Text("Something went wrong");
        }

        if(snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text("Data: ${data['name']} ${data['description']}");
        }
        return Text("loading");
      },
    );


    /*return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Your Matches!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36,),
                    textAlign: TextAlign.center
                ),

                new Expanded(
                  child: ListView(
                    children: [
                      Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                             ListTile(
                              leading: Icon(Icons.album),
                              title: Text('The Enchanted Nightingale'),
                              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                              enabled: true,
                              selected: card1Status,
                              selectedTileColor: Colors.red,
                              onTap: () {
                                setState(() {
                                  if(card1Status == false){
                                    card1Status = true;
                                  }else
                                  card1Status = false;
                                });
                                debugPrint("card clicked");
                              },
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                             ListTile(
                              leading: Icon(Icons.album),
                              title: Text('The Enchanted Nightingale'),
                              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                              selected: card2Status,
                              selectedTileColor: Colors.red,
                              onTap: () {
                                setState(() {
                                  if(card2Status == false){
                                    card2Status = true;
                                  }else
                                    card2Status = false;
                                });
                                debugPrint("card clicked");
                              },
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              leading: Icon(Icons.album),
                              title: Text('The Enchanted Nightingale'),
                              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              leading: Icon(Icons.album),
                              title: Text('The Enchanted Nightingale'),
                              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              leading: Icon(Icons.album),
                              title: Text('The Enchanted Nightingale'),
                              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              leading: Icon(Icons.album),
                              title: Text('The Enchanted Nightingale'),
                              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                RaisedButton(
                  onPressed: () {
                    getLocations();
                    //Navigator.push(
                      //context,
                      //MaterialPageRoute(builder: (context) => MatchPage()),
                    //);
                  },
                  child: Text("MAP IT!", style: TextStyle(fontSize: 18.0)),
                )
              ],
          ),
        ),
    );*/
  }
}