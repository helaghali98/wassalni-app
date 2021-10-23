import 'package:wassalni_app/allScreens/trip_page.dart';
import 'package:flutter/material.dart';

class AddCarPage extends StatefulWidget {
  static String tag = 'addcar-page';
  @override
  _AddCarPageState createState() => new _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  @override
  Widget build(BuildContext context) {
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
                          image: AssetImage("images/image55.png"),
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

    final marcaLabel = new ListTile(
      title: Text('Marque: ',
          style: TextStyle(color: Colors.black, fontSize: 15.0)),
    );

    final marca = Padding(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: TextFormField(
          textCapitalization: TextCapitalization.sentences,
          autofocus: false,
          initialValue: '',
          decoration: InputDecoration(
            hintText: 'Mazda',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
        ));

    final serieLabel = new ListTile(
      title:
          Text('Série:', style: TextStyle(color: Colors.black, fontSize: 15.0)),
    );

    final serie = Padding(
      padding: EdgeInsets.only(left: 24.0, right: 24.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        autofocus: false,
        initialValue: '',
        decoration: InputDecoration(
          hintText: 'Mazda 3',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );

    final placasLabel = new ListTile(
      title: Text('Matricule:',
          style: TextStyle(color: Colors.black, fontSize: 15.0)),
    );

    final placas = Padding(
      padding: EdgeInsets.only(left: 24.0, right: 24.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        autofocus: false,
        initialValue: '',
        decoration: InputDecoration(
          hintText: 'P-123ABC',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );

    final tipoLabel = new ListTile(
      title:
          Text('Type:', style: TextStyle(color: Colors.black, fontSize: 15.0)),
    );

    final tipo = Padding(
      padding: EdgeInsets.only(left: 24.0, right: 24.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        autofocus: false,
        initialValue: '',
        decoration: InputDecoration(
          hintText: 'Hatchback',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );

    final saveBtn = Padding(
      padding: EdgeInsets.symmetric(vertical: 26.0),
      child: Center(
        child: Container(
          width: 200.0,
          height: 50.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            color: Colors.indigo[400],
            onPressed: () {
              Navigator.of(context).pushNamed(TripPage.tag);
            },
            child: Text('ENREGISTRER',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
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
            marcaLabel,
            marca,
            serieLabel,
            serie,
            placasLabel,
            placas,
            tipoLabel,
            tipo,
            saveBtn,
          ],
        ),
      ),
    );
  }
}
