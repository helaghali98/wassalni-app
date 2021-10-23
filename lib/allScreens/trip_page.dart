import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:wassalni_app/main.dart';
import 'package:intl/intl.dart';

import 'addCar_page.dart';
import 'mytrips_page.dart';

class TripPage extends StatefulWidget {
  static String tag = 'trip-page';

  @override
  _TripPageState createState() => new _TripPageState();
}

class Dialogs {
  addCar(BuildContext context, String title, String description) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(description)],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => _addCar(false, context),
                child: Text('Annuler'),
              ),
              FlatButton(
                onPressed: () => _addCar(true, context),
                child: Text('Ajouter'),
              )
            ],
          );
        });
  }
}

_addCar(bool isAdd, BuildContext context) {
  if (isAdd) {
    Navigator.of(context).pushNamed(AddCarPage.tag);
  } else {
    Navigator.pop(context);
  }
}

class _TripPageState extends State<TripPage> {
  List<DropdownMenuItem<String>> Listplaces = [];

  String depart = null;
  String destination = null;
  TextEditingController _initController, _endController, wayController;
  TextEditingController _prixController;
  TextEditingController _dateController = TextEditingController();
  DatabaseReference _ref;
  int _seats = 0;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  void Places() {
    Listplaces.clear();
    Listplaces.add(
      DropdownMenuItem(
        value: 'Monastir',
        child: Text('Monastir',
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
      ),
    );
    Listplaces.add(
      DropdownMenuItem(
        value: 'Sfax',
        child: Text('Sfax',
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
      ),
    );
    Listplaces.add(
      DropdownMenuItem(
        value: 'Tunis',
        child: Text('Tunis',
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
      ),
    );
    Listplaces.add(
      DropdownMenuItem(
        value: 'Ariana',
        child: Text('Ariana',
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
      ),
    );
    Listplaces.add(
      DropdownMenuItem(
        value: 'Kef',
        child: Text('Kef',
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
      ),
    );
    Listplaces.add(
      DropdownMenuItem(
        value: 'Touzeur',
        child: Text('Touzeur',
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
      ),
    );
    Listplaces.add(
      DropdownMenuItem(
        value: 'Mahdia',
        child: Text('Mahdia',
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
      ),
    );
    Listplaces.add(
      DropdownMenuItem(
        value: 'Sousse',
        child: Text('Sousse',
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
      ),
    );
    Listplaces.add(
      DropdownMenuItem(
        value: 'Ben Arous',
        child: Text('Ben Arous',
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _prixController = TextEditingController();
    _initController = TextEditingController();
    _endController = TextEditingController();
    wayController = TextEditingController();
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _ref = FirebaseDatabase.instance.reference().child('Contacts');
  }

  Dialogs dialogs = new Dialogs();

  String title;
  String result = "";
  void _addSeat() {
    setState(() {
      if (_seats < 4) _seats++;
    });
    //print(_seats);
  }

  void _reduceSeat() {
    setState(() {
      if (_seats != 0) _seats--;
    });
    //print(_seats);
  }

  getData(BuildContext context) async {
    var fDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );
    if (fDate != null)
      setState(() {
        _selectedDate = fDate;
        _dateController.text = DateFormat.yMd().format(_selectedDate);
      });
  }

  void getTime(context) async {
    var ftime =
        await showTimePicker(context: context, initialTime: _selectedTime);
    if (ftime != null) setState(() => _selectedTime = ftime);
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat df = DateFormat("dd/MM/yyyy");

    final dateTime = new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(df.format(_selectedDate)),
            IconButton(
              icon: Icon(Icons.date_range),
              color: Colors.blue,
              onPressed: () {
                getData(context);
              },
            ),
            Text(_selectedTime.format(context)),
            IconButton(
                icon: Icon(Icons.date_range),
                color: Colors.blue,
                onPressed: () {
                  getTime(context);
                }),
          ],
        )
      ],
    );
    final seats = Container(
      child: new Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new FloatingActionButton(
              heroTag: 'btn1',
              mini: true,
              onPressed: _reduceSeat,
              child: new Icon(
                  const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                  color: Colors.black),
              backgroundColor: Colors.white,
            ),
            new Text(
              '$_seats',
              style: new TextStyle(fontSize: 20.0),
            ),
            new FloatingActionButton(
              heroTag: 'btn2',
              mini: true,
              onPressed: _addSeat,
              child: new Icon(Icons.add, color: Colors.black),
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );

    final price = Padding(
      padding: EdgeInsets.only(left: 130.0, right: 130.0),
      child: TextFormField(
        controller: _prixController,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Q.',
          contentPadding: EdgeInsets.fromLTRB(40.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
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

    final inicioLabel = new ListTile(
      title:
          Text('Départ', style: TextStyle(color: Colors.black, fontSize: 15.0)),
    );

    final initPoint = Padding(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: DropdownButton(
          value: depart,
          elevation: 10,
          items: Listplaces,
          hint: Text(
            'Sélectionnez votre place',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          onChanged: (value) {
            setState(() {
              depart = value;
            });
          },
        ));

    final finalLabel = new ListTile(
      title: Text('Destination',
          style: TextStyle(color: Colors.black, fontSize: 15.0)),
    );

    final endPoint = Padding(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: DropdownButton(
          value: destination,
          elevation: 10,
          items: Listplaces,
          hint: Text(
            'Sélectionnez votre destination',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          onChanged: (value) {
            setState(() {
              destination = value;
            });
          },
        ));

    final waypoints = Padding(
      padding: EdgeInsets.only(left: 24.0, right: 200.0),
      child: Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new TextField(
                textCapitalization: TextCapitalization.sentences,
                decoration: new InputDecoration(hintText: 'numero'),
                onSubmitted: (String str) {
                  setState(() {
                    result = result + '\n' + str;
                    //print(result);
                  });
                  wayController.text = '';
                },
                controller: wayController,
              ),
              new Text(result,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
            ],
          ),
        ),
      ),
    );

    final dialogBtn = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.assignment_late),
              color: Colors.grey,
              iconSize: (25.0),
              onPressed: () {
                dialogs.addCar(context, 'Ajouter plus de détail',
                    'Ajouter les caracterstiques de votre voiture avant de publier votre annonce ');
              },
            )
          ],
        )
      ],
    );
    final dateTimeLabel = new ListTile(
      title:
          Text('Date', style: TextStyle(color: Colors.black, fontSize: 15.0)),
    );

    final seatsLabel = new ListTile(
      title: Text('Nombre de places disponible ',
          style: TextStyle(color: Colors.black, fontSize: 15.0)),
    );

    final priceLabel = new ListTile(
      title: Text('Prix/personne ',
          style: TextStyle(color: Colors.black, fontSize: 15.0)),
    );

    Places();
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
            SizedBox(height: 15.0),
            logo,
            SizedBox(height: 10.0),
            inicioLabel,
            SizedBox(height: 0.1),
            initPoint,
            SizedBox(height: 10.0),
            finalLabel,
            SizedBox(height: 0.1),
            endPoint,
            dateTimeLabel,
            dateTime,
            seatsLabel,
            seats,
            priceLabel,
            price,

            SizedBox(height: 15.0),
            waypoints,
            dialogBtn,
            //SizedBox(height: 0.5),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveContact();
        },
        child: Text('>', style: TextStyle(color: Colors.white, fontSize: 25.0)),
        backgroundColor: Colors.indigo[600],
      ),
    );
  }

  void saveContact() {
    String init = depart;
    String end = destination;
    String way = wayController.text;
    String prix = _prixController.text;
    String date = _dateController.text;
    String seat = _seats.toString();

    Map<String, String> contact = {
      'init': init,
      'end': end,
      'way': way,
      'prix': prix,
      'date': date,
      'seat': seat,
    };

    _ref.push().set(contact).then((value) {
      Navigator.of(context).pushNamed(MyTripsPage.tag);
    });
  }
}
