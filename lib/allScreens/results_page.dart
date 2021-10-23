import 'package:flutter/material.dart';
import 'package:wassalni_app/allScreens/search_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/src/widgets/text.dart';

import 'package:wassalni_app/allScreens/finalUser_page.dart';

class ResultsPage extends StatefulWidget {
  final String text;
  static String tag = 'results-page';
  ResultsPage({Key key, @required this.text}) : super(key: key);

  @override
  _ResultsPageState createState() => new _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  Query _ref;

  @override
  void initState() {
    super.initState();

    _ref = FirebaseDatabase.instance
        .reference()
        .child('Contacts')
        .orderByChild('init')
        .equalTo(widget.text);
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
                  color: Colors.black,
                  //fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  //Text('Due Date'),
                  child: Text('RESERVER',
                      style: TextStyle(
                          color: Colors.white, fontSize: 18.0)), //Text('BTN1'),
                  onPressed: () {
                    Navigator.of(context).pushNamed(FinalUserPage.tag);
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
    );
  }
}
