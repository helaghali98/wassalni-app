import 'package:wassalni_app/allScreens/resumen_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

class RiderPage extends StatefulWidget {
  static String tag = 'rider-page';

  @override
  _RiderPageState createState() => new _RiderPageState();
}

class _RiderPageState extends State<RiderPage> {
  int _seats = 0;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  DatabaseReference _ref;
  TextEditingController _prixController;
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _prixController = TextEditingController();
    _dateController.text = DateFormat.yMd().format(DateTime.now());
    _ref = FirebaseDatabase.instance.reference().child('Contacts');
  }

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

    final tripBtn = Padding(
      padding: EdgeInsets.symmetric(vertical: 26.0),
      child: Center(
        child: Container(
          width: 150.0,
          height: 50.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            color: Colors.indigo[600],
            onPressed: () {
              saveContact();
            },
            child: Text('FINALISER',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
      ),
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

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [Colors.grey, Colors.indigo],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        )),
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
            SizedBox(height: 5.0),
            dateTimeLabel,
            dateTime,
            seatsLabel,
            seats,
            priceLabel,
            price,
            SizedBox(height: 50.0),
            tripBtn,
          ],
        ),
      ),
    );
  }

  void saveContact() {
    String prix = _prixController.text;
    String date = _dateController.text;

    Map<String, dynamic> contact = {
      'prix': prix,
      'date': date,
    };

    _ref.push().set(contact).then((value) {
      Navigator.of(context).pushNamed(ResumenPage.tag);
    });
  }
}
