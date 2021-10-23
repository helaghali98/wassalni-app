import 'package:wassalni_app/AllWidgets/progressDialog.dart';
import 'package:wassalni_app/allScreens/home_page.dart';
import 'package:wassalni_app/allScreens/loginScreen.dart';
import 'package:wassalni_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';

class RegisterationScreen extends StatelessWidget {
  static const String idScreen = "register";
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
            child: Column(
              children: [
                SizedBox(
                  height: 35.0,
                ),
                Image(
                  image: AssetImage("images/image7.png"),
                  width: 350.0,
                  height: 250.0,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Bienvenue sur Wasselni",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontFamily: "Cherry Bold",
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12.0,
                      ),
                      TextField(
                        controller: nameTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "Nom",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            )),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      TextField(
                        controller: emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            )),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      TextField(
                        controller: phoneTextEditingController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: "Numéro de téléphone",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            )),
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
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.indigo[400],
                              fontSize: 10.0,
                            )),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(height: 10.0),
                      RaisedButton(
                          color: Colors.indigo[400],
                          textColor: Colors.white,
                          child: Container(
                            height: 50.0,
                            child: Center(
                              child: Text(
                                "Créer un compte",
                                style: TextStyle(
                                    fontSize: 18.0, fontFamily: "Cherry Bold"),
                              ),
                            ),
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(24.0)),
                          onPressed: () {
                            if (nameTextEditingController.text.length < 3) {
                              displayToastMessage(
                                  "Name must be at least 3 characters.",
                                  context);
                            } else if (!emailTextEditingController.text
                                .contains("@")) {
                              displayToastMessage(
                                  "Email address is not Valid", context);
                            } else if (phoneTextEditingController
                                .text.isEmpty) {
                              displayToastMessage(
                                  "Phone number is compulsory", context);
                            } else if (passwordTextEditingController
                                    .text.length <
                                6) {
                              displayToastMessage(
                                  "Password must be at least 6 characters.",
                                  context);
                            } else {
                              registerNewUser(context);
                            }
                          }),
                    ],
                  ),
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen.idScreen, (route) => false);
                    },
                    child: Text(
                      "Vous avez déjà un compte? Connectez-vous ici",
                      style: TextStyle(fontSize: 13.0, color: Colors.grey),
                    )),
              ],
            ),
          ),
        ));
  }

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: " Registering please wait...",
          );
        });
    final User firebaseUser = (await firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);

      displayToastMessage("Error : " + errMsg.toString(), context);
    }))
        .user;
    if (firebaseUser != null) //user created
    {
      //save user info to database
      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage("Félicitations, votre compte a été créé", context);
      Navigator.pushNamedAndRemoveUntil(
          context, HomePage.idScreen, (route) => false);
    } else {
      Navigator.pop(context);

      //erreur + message
      displayToastMessage("Un nouveau compte utilisateur a été créé", context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
