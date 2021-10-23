import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference driverCollection =
      Firestore.instance.collection('brews');

  Future<void> updateUserData(String depart, String name, String car,
      String date, String destination) async {
    return await driverCollection.document(uid).setData({
      'depart': depart,
      'name': name,
      'car': car,
      'date': date,
      'destination': destination,
    });
  }
}
