import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class ProgressDialog extends StatelessWidget
{
  String message;
  ProgressDialog({this.message});
  @override
  Widget build(BuildContext context)
  {
    return Dialog(
      backgroundColor:Colors.indigo[400],
      child: Container(
        margin: EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.circular(6.0),

        ),
        child:Padding(
          padding:EdgeInsets.all(15.0),
          child: Row(
            children: [
              SizedBox(width: 6.0,),
              CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.indigo[400]),),
              SizedBox(width:26.0),
              Text(
                message,
                style:TextStyle(color:Colors.indigo[400],fontSize:10.0),
              ),
            ],
          ),
        ),
      ),

    );

  }
}

