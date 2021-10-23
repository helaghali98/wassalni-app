import 'package:wassalni_app/Welcome/WelcomeScreen.dart';
import 'package:wassalni_app/allScreens/addCar_page.dart';
import 'package:wassalni_app/allScreens/finalUser_page.dart';
import 'package:wassalni_app/allScreens/final_page.dart';
import 'package:wassalni_app/allScreens/home_page.dart';
import 'package:wassalni_app/allScreens/loginScreen.dart';
import 'package:wassalni_app/allScreens/mytrips_page.dart';
import 'package:wassalni_app/allScreens/registerationScreen.dart';
import 'package:wassalni_app/allScreens/results_page.dart';
import 'package:wassalni_app/allScreens/resumen_page.dart';
import 'package:wassalni_app/allScreens/search_page.dart';
import 'package:wassalni_app/allScreens/trip2_page.dart';
import 'package:wassalni_app/allScreens/trip_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference usersRef =
    FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasselni',
      theme: ThemeData(
        fontFamily: "Brand Bold",
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: WelcomeScreen.idScreen,
      routes: {
        RegisterationScreen.idScreen: (context) => RegisterationScreen(),
        LoginScreen.idScreen: (context) => LoginScreen(),
        HomePage.idScreen: (context) => HomePage(),
        WelcomeScreen.idScreen: (context) => WelcomeScreen(),
        TripPage.tag: (context) => TripPage(),
        RiderPage.tag: (context) => RiderPage(),
        ResumenPage.tag: (context) => ResumenPage(),
        FinalRidePage.tag: (context) => FinalRidePage(),
        SearchPage.tag: (context) => SearchPage(),
        AddCarPage.tag: (context) => AddCarPage(),
        ResultsPage.tag: (context) => ResultsPage(),
        FinalUserPage.tag: (context) => FinalUserPage(),
        MyTripsPage.tag: (context) => MyTripsPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
