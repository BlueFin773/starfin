import 'dart:developer';
import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starfin/model/location.dart';
import 'package:starfin/utils/store.dart';
import 'package:starfin/map.dart';
import 'package:starfin/rate.dart';

class MatchPage extends StatefulWidget {
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  List<Location> allLocations = getLocations();
  List<dynamic> bestLocationMatches;
  List<String> userSelected = getSelectedIDs();
  RatePageState args;
  var ratings;

  //handle user selected list
  void _handleSelectedListChanged(String locationID) {
    setState(() {
      if (userSelected.contains(locationID)) {
        userSelected.remove(locationID);
      } else {
        userSelected.add(locationID);
      }
    });
  }

  //compare two ratings by cosine similarity
   _compare(List<int> userRating, List<int> locationRating){
     double product = 0.0;
     double normUserRating = 0.0;
     double normLocationRating = 0.0;
    //check if both vectors are the same size
    if(userRating.length != locationRating.length){
      print("Error: Comparison vectors are not the same length");
      return;
    }else{
      for(int i = 0; i < userRating.length; i++){
        product += userRating[i] * locationRating[i];
        normUserRating += pow(userRating[i],2);
        normLocationRating += pow(locationRating[i], 2);
      }
    }
     return product / (sqrt(normUserRating) * sqrt(normLocationRating));
  }

  //run compare against all locations and return the top 5 best matches
  _compareAll(List userRating, List<Location> locations){
    var map = new Map();
    for(var location in locations){
       map[location] = _compare(userRating,location.rating);
    }
    print("Map" + map.toString());
    var sortedKeys = map.keys.toList(growable:false)
      ..sort((k1, k2) => map[k2].compareTo(map[k1]));
    LinkedHashMap sortedMap = new LinkedHashMap
        .fromIterable(sortedKeys, key: (k) => k, value: (k) => map[k]);
    print("sorted:" + sortedMap.toString());
    bestLocationMatches = sortedMap.keys.toList();
  }

  @override
  Widget build(BuildContext context) {

    //getting data from rate page and saving as an array which can be used to compare to database listings
    args = ModalRoute.of(context).settings.arguments;
    ratings = [args.culture, args.nature, args.entertainment, args.historical, args.architecture];
    _compareAll(ratings, allLocations);
    print("Ratings" + ratings.toString());
    print("User selected" + userSelected.toString());

    Column _buildLocations(List<dynamic> locationsList) {
      return Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemExtent:100,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: Text(locationsList[index].name, style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          leading:  SizedBox(
                            width:100,
                            height:100,
                            child:Image.network(locationsList[index].imageURL, fit:BoxFit.cover ),
                          ),
                          subtitle: Text(locationsList[index].description, style:TextStyle(fontSize: 12)),
                          enabled: true,
                          selected: locationsList[index].selected,
                          selectedTileColor: Color(0xFF6C63FF),
                          onTap: () {
                            setState(() {
                              locationsList[index].selected =
                              !locationsList[index].selected;
                              _handleSelectedListChanged(locationsList[index].id);
                            });
                          }
                      );
                    }
                )
            )
          ]
      );
    }

    //const double _iconSize = 20.0;
    return Scaffold(
        body:Container(
            padding: const EdgeInsets.all(32),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Your Matches!",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36,),
                      textAlign: TextAlign.center
                  ),
                  new Expanded(
                        child: _buildLocations(bestLocationMatches.toList()),
                      ),

                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () {
                      print(userSelected.toString());
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapPage(), settings: RouteSettings(arguments: userSelected))
                      );
                    },
                    child: Text("MAP IT!", style: TextStyle(fontSize: 18.0)),
                  )
                ]
            )
        )
    );
  }
}
          //length: 2,
          //child: Scaffold(
/*            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 2.0,
                bottom: TabBar(
                  labelColor: Theme.of(context).indicatorColor,
                  tabs:[
                    Tab(icon: Icon(Icons.restaurant, size: _iconSize)),
                    Tab(icon: Icon(Icons.favorite, size: _iconSize)),
                  ],
                )
              )*/
           /* ),
              body: Padding(
              padding: EdgeInsets.all(5.0),
              child: TabBarView(
                children:[
                  _buildLocations(locations.toList()),
                  _buildLocations(locations.where((location) => userSelected.contains(location.id)).toList()),
                ]
              )
          )

          ));
    }
  }*/



  /*getLocationItems(AsyncSnapshot<QuerySnapshot> snapshot){
    return snapshot.data.docs
        .map((doc) => new ListTile (
            leading: Icon(Icons.album),
            title: new Text(doc["name"]),
            subtitle: new Text(doc["description"]),
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

      )
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference locations = FirebaseFirestore.instance.collection('locations');

    return StreamBuilder<QuerySnapshot>(
      stream: locations.snapshots(),
      builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
        if (!snapshot.hasData) return new Text("There is no data");
        //return new ListView(children: getLocationItems(snapshot));
        return Scaffold(
          body:Container(
            padding: const EdgeInsets.all(32),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Your Matches!",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36,),
                      textAlign: TextAlign.center
                  ),
                  new Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return getLocationItems(snapshot);
                      } ,
                      //children: getLocationItems(snapshot)
                    )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () {
                      //getLocations();
                      //Navigator.push(
                      //context,
                      //MaterialPageRoute(builder: (context) => MatchPage()),
                      //);
                    },
                    child: Text("MAP IT!", style: TextStyle(fontSize: 18.0)),
                  )
                ]
            )
          )
        );
    });
  }
}*/