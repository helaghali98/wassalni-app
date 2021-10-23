import 'package:wassalni_app/allScreens/results_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  static String tag = 'search-page';
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textFieldController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final DateFormat df = DateFormat("dd/MM/yyyy");

    void getData(BuildContext context) async {
      var fDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2018),
        lastDate: DateTime(2030),
      );
      if (fDate != null) setState(() => _selectedDate = fDate);
      //print(_selectedDate);
    }

    final logo = AspectRatio(
      aspectRatio: 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.5,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/image26.png"),
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
    final inicioLabel = new ListTile(
      title:
          Text('Départ', style: TextStyle(color: Colors.black, fontSize: 15.0)),
    );

    final initPoint = Padding(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: TextFormField(
          controller: textFieldController,
          textCapitalization: TextCapitalization.sentences,
          autofocus: false,
          decoration: InputDecoration(
            hintText: 'Région',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
        ));

    final finalLabel = new ListTile(
      title: Text('Destination',
          style: TextStyle(color: Colors.black, fontSize: 15.0)),
    );

    final endPoint = Padding(
      padding: EdgeInsets.only(left: 24.0, right: 24.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        autofocus: false,
        initialValue: '',
        decoration: InputDecoration(
          hintText: 'Région',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );

    final dateTime = new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(df.format(_selectedDate)),
            IconButton(
              icon: Icon(Icons.date_range),
              color: Colors.black,
              onPressed: () {
                getData(context);
              },
            ),
          ],
        )
      ],
    );

    final searchBtn = Padding(
      padding: EdgeInsets.symmetric(vertical: 26.0),
      child: Center(
        child: Container(
          width: 150.0,
          height: 50.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            color: Colors.indigo[400],
            onPressed: () {
              _sendDataToSecondScreen(context);
            },
            child: Text('Rechercher',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
      ),
    );

    final dateTimeLabel = new ListTile(
      title:
          Text('Date', style: TextStyle(color: Colors.black, fontSize: 15.0)),
    );

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
        child: ListView(
          children: <Widget>[
            SizedBox(height: 30.0),

            logo,
            inicioLabel,
            initPoint,
            //SizedBox(height: 10.0),
            finalLabel,
            //SizedBox(height: 0.1),
            endPoint,
            //SizedBox(height: 30.0),
            dateTimeLabel,
            dateTime,
            SizedBox(height: 50.0),
            searchBtn,
          ],
        ),
      ),
    );
  }

  void _sendDataToSecondScreen(BuildContext context) {
    String textToSend = textFieldController.text;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(
            text: textToSend,
          ),
        ));
  }
}
