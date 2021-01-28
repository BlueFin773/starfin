import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:starfin/model/location.dart';
import 'package:starfin/utils/store.dart';


//TODO: Make list items selectable

class MatchPage extends StatefulWidget {
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  List<Location> locations = getLocations();
  List<String> userSelected = getSelectedIDs();

  void _handleSelectedListChanged(String locationID){
    setState(() {
      if(userSelected.contains(locationID)){
        userSelected.remove(locationID);
      }else {
        userSelected.add(locationID);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Column _buildLocations(List<Location> locationsList) {
      return Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: locationsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(locationsList[index].name),
                      );
                    }
                )
            )
          ]
      );
    }


      const double _iconSize = 20.0;
      return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: PreferredSize(
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
              )
            ),
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
  }



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