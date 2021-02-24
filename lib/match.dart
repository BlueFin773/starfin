import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
  List<Location> bestLocationMatches;
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
   _compare(List userRating, List locationRating){
    //check if both vectors are the same size
    if(userRating.length != locationRating.length){
      print("Error: Comparison vectors are not the same length");
      return;
    }else{
      double product = 0.0;
      double normUserRating = 0.0;
      double normLocationRating = 0.0;

      for(int i = 0; i < userRating.length; i++){
        product += userRating[i] * locationRating[i];
        normUserRating += pow(userRating[i],2);
        normLocationRating += pow(locationRating[i], 2);
      }
      return product / (sqrt(normUserRating) * sqrt(normLocationRating));
    }
  }

  //run compare against all locations and return the top 5 best matches
  _compareAll(List userRating, List<Location> locations){
    List<double> results;
    for(var location in locations){
      double result = _compare(userRating,location.rating);
      results.add(result);
    }
  }


  @override
  Widget build(BuildContext context) {

    //getting data from rate page and saving as an array which can be used to compare to database listings
    args = ModalRoute.of(context).settings.arguments;
    ratings = [args.culture, args.nature, args.entertainment, args.historical, args.architecture];
    print(ratings);
    print(userSelected);

    //TODO: Query the database to show the best 10 matches to the user using the comparison method
    Column _buildLocations(List<Location> locationsList) {
      return Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: locationsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: Text(locationsList[index].name),
                          leading: Image.network(locationsList[index].imageURL),
                          subtitle: Text(allLocations[index].description),
                          enabled: true,
                          selected: allLocations[index].selected,
                          selectedTileColor: Color(0xFF6C63FF),
                          onTap: () {
                            setState(() {
                              allLocations[index].selected =
                              !allLocations[index].selected;
                              _handleSelectedListChanged(allLocations[index].id);
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
                        child: _buildLocations(allLocations.toList()),
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