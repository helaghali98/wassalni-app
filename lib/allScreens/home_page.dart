import 'dart:async';
import 'package:wassalni_app/allScreens/mytrips_page.dart';
import 'package:flutter/material.dart';
import 'package:wassalni_app/allScreens/search_page.dart';
import 'package:wassalni_app/allScreens/trip_page.dart';

class HomePage extends StatefulWidget {
  static const String idScreen = "mainScreen";
  static String tag = 'home-page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final logo = AspectRatio(
      aspectRatio: 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          AspectRatio(
            aspectRatio: 2.5,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/image5.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );

    final riderBtn = Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Center(
        child: Container(
          width: 250.0,
          height: 60.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            color: Colors.indigo[400],
            //withOpacity(0.95), //Aqua#1DDCB2 Purple #4B2CB3
            onPressed: () {
              Navigator.of(context).pushNamed(TripPage.tag);
            },
            child: Text('Poposez un Trajet',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
      ),
    );

    final userBtn = Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Center(
        child: Container(
          width: 250.0,
          height: 60.0,
          child: RaisedButton(
            //.icon
            //icon: Icon(Icons.airport_shuttle, color: Colors.white, size: 50.0,),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            color: Colors.indigo[400],
            //withOpacity(0.95), //Aqua#1DDCB2 Purple #4B2CB3
            onPressed: () {
              Navigator.of(context).pushNamed(SearchPage.tag);
            },
            child: Text('Cherchez un Trajet',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0)), //cambiar child por label
          ),
        ),
      ),
    );

    final tripsBtn = Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Center(
        child: Container(
          width: 250.0,
          height: 60.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            color: Colors.indigo[400],
            //withOpacity(0.95), //Aqua#1DDCB2 Purple #4B2CB3
            onPressed: () {
              Navigator.of(context).pushNamed(MyTripsPage.tag);
            },
            child: Text('Mes Plans',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
      ),
    );

    return Scaffold(
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              decoration:
                  BoxDecoration(color: Colors.lightBlue.withOpacity(0.50)),
              margin: EdgeInsets.only(bottom: 40.0),
              currentAccountPicture: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://revistadiners.pe/wp-content/uploads/2019/05/robertdowneyjr_800x669-1.jpg")),
                ),
              ),
              accountName: Text('TONY STARK',
                  style: TextStyle(color: Colors.black, fontSize: 18.0)),
              accountEmail: Text('adsfg@asdf.com',
                  style: TextStyle(color: Colors.black, fontSize: 15.0)),
            ),
            new ListTile(
              title: Text('MESSAGES',
                  style: TextStyle(color: Colors.black, fontSize: 18.0)),
            ),
            new ListTile(
              title: Text('TRAVEL REQUESTS',
                  style: TextStyle(color: Colors.black, fontSize: 18.0)),
              selected: true,
            ),
            new ListTile(
              title: Text('CONFIGURATIONS',
                  style: TextStyle(color: Colors.black, fontSize: 18.0)),
            ),
            new ListTile(
              title: Text('GO OUT',
                  style: TextStyle(color: Colors.black, fontSize: 18.0)),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [Colors.grey, Colors.indigo],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: ListView(
          children: <Widget>[
            logo,
            riderBtn,
            userBtn,
            tripsBtn,
          ],
        ),
      ),
    );
  }
}
