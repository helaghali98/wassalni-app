import 'package:flutter/material.dart';

class TabScreen2 extends StatelessWidget {
  static String tag = 'tab2-page';

  final Text text;
  TabScreen2(this.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body : Container(
          decoration : new BoxDecoration(
            gradient: new LinearGradient(
              colors:[Colors.grey,Colors.indigo],
              begin: const FractionalOffset(0.0, 0.0),
              end:const FractionalOffset(1.0, 0.0),
              stops:[0.0,1.0],
              tileMode: TileMode.clamp,
            ),
          ),

        ));
  }
}