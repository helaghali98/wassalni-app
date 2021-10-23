import 'package:wassalni_app/AllWidgets/progressDialog.dart';
import 'package:wassalni_app/Welcome/WelcomeScreen.dart';
import 'package:wassalni_app/allScreens/home_page.dart';
import 'package:wassalni_app/allScreens/registerationScreen.dart';
import 'package:wassalni_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "Login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                height: 5.0,
              ),
              Image(
                image: AssetImage("images/image7.png"),
                width: 390.0,
                height: 350.0,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 2.0,
                width: 2.0,
              ),
              Text(
                "Bienvenue sur notre application Wasselni",
                style: TextStyle(fontSize: 20.0, fontFamily: "Brand-Regular"),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Adresse e-mail",
                        labelStyle: TextStyle(
                            fontSize: 14.0, fontFamily: "Brand-Regular"),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Mot de passe",
                        labelStyle: TextStyle(
                            fontSize: 14.0, fontFamily: "Brand-Regular"),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    RaisedButton(
                      color: Colors.indigo[400],
                      textColor: Colors.white,
                      child: Container(
                        height: 30.0,
                        child: Center(
                          child: Text(
                            "Connexion",
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: "Brand-Regular"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: () {
                        if (!emailTextEditingController.text.contains("@")) {
                          displayToastMessage("e-mail invalide", context);
                        }
                        if (passwordTextEditingController.text.isEmpty) {
                          displayToastMessage(
                              "vous devez saisir une mot de passe", context);
                        } else {
                          LoginAuthUser(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RegisterationScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Créer un compte.",
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, WelcomeScreen.idScreen, (route) => false);
                },
                child: Text(
                  "retour à la page précédente ?",
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void LoginAuthUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Merci pour votre attente .. ",
          );
        });
    final User firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Erreur , votre compte n'exite pas", context);
    }))
        .user;
    if (firebaseUser != null) {
      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomePage.idScreen, (route) => false);
          displayToastMessage("Vous etes connecté en succés", context);
        } else {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage("Merci de créer un compte", context);
        }
      });
    } else {
      Navigator.pop(context);
      displayToastMessage("Erreur", context);
    }
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
