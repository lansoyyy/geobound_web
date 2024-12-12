import 'package:cloud_firestore/cloud_firestore.dart';

Future addVehicle(model, color, platenumber, userId) async {
  final docUser = FirebaseFirestore.instance.collection('Vehicles').doc();

  final json = {
    'model': model,
    'color': color,
    'platenumber': platenumber,
    'userId': userId,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}
