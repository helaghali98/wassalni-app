import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wassalni_app/Allscreens/loginScreen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String idScreen = "Welcome";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Scaffold(
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
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(
              height: 40.0,
            ),
            Image(
              image: AssetImage("images/image6.png"),
              width: 390.0,
              height: 350.0,
              alignment: Alignment.center,
            ),
            SizedBox(
              height: 2.0,
              width: 2.0,
            ),
            Text(
              "Envie de Réduire vos frais de transport ? \n Vous cherchez l'application qui simplifie vos trajets ?",
              style: TextStyle(fontSize: 20.0, fontFamily: "Brand-Regular"),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(60.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 9.0,
                  ),
                  RaisedButton(
                    color: Colors.indigo[400],
                    textColor: Colors.white,
                    child: Container(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Commencer",
                          style: TextStyle(
                              fontSize: 20.0, fontFamily: "Brand-Regular"),
                        ),
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen.idScreen, (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
