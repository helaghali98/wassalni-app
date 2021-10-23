import 'package:flutter/material.dart';
import 'package:wassalni_app/allScreens/trip_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/src/widgets/text.dart';

class MyTripsPage extends StatefulWidget {
  static String tag = 'trips-page';
  @override
  _MyTripsPageState createState() => new _MyTripsPageState();
}

class _MyTripsPageState extends State<MyTripsPage> {
  Query _ref;
  @override
  void initState() {
    super.initState();

    _ref = FirebaseDatabase.instance.reference().child('Contacts');
  }

  void removeNode(String end) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: new Text(
              " Supprimer cette annonce",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            content: Text(
              'Vous etes sur de supprimer cette annonce ?',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text(
                  "Fermer",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(
                  "OK",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  FirebaseDatabase.instance
                      .reference()
                      .child('Contacts')
                      .orderByChild('end')
                      .equalTo(end)
                      .once()
                      .then((DataSnapshot snapshot) {
                    Map<dynamic, dynamic> children = snapshot.value;
                    children.forEach((key, value) {
                      FirebaseDatabase.instance
                          .reference()
                          .child('Contacts')
                          .child(key)
                          .remove();
                    });
                  });
                },
              ),
            ],
          );
        });
  }

  Widget _buildCategoryItem({Map contact}) {
    Color typeColor = Colors.grey;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.indigo[400],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /*const*/ ListTile(
              leading: Icon(
                Icons.check,
                color: typeColor,
                size: 40,
              ),
              title: Text(
                'destination: ' + contact['end'],
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black, //Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                'depart: ' + contact['init'] + ' numero: ' + contact['way'],
                style: TextStyle(
                  fontSize: 16,
                  //color: Theme.of(context).accentColor,
                  //fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: //Text('Due Date'),
                      Icon(
                    Icons.date_range,
                    color: Colors.grey[600],
                  ), //Text('BTN1'),
                  onPressed: () {/* ... */},
                ),
                FlatButton(
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey[600],
                  ), //Text('BTN2'),
                  //Text('BTN2'),
                  onPressed: () {
                    removeNode(contact['end']);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes Trajets"),
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
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map contact = snapshot.value;
            return _buildCategoryItem(contact: contact);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return TripPage();
          }));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        child: Text(
          'Contacts',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
