import 'package:flutter/material.dart';

//TODO: Make list items selectable

class MatchPage extends StatefulWidget {
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      new GestureDetector(
                        onTap: (){
                          debugPrint("card clicked");

                         },
                        child: new Card(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MatchPage()),
                    );
                  },
                  child: Text("MAP IT!", style: TextStyle(fontSize: 18.0)),
                )
              ],
          ),
        ),
    );
  }
}