import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/recruteur.dart';

import '../models/Student.dart';

class DbServices {
  var userCollection = FirebaseFirestore.instance.collection('users');

  saveStudent(Student student) async {
    try {
      // .set(json ) pour ajouter des champs dans une document
      await userCollection
          .doc(student.uid)
          .set(student.toJson()); // ajout d'utilisateur dans le document
    } catch (e) {}
  }

  saveRecruteur(Recruteur recruteur) async {
    try {
      // .set(json ) pour ajouter des champs dans une document
      await userCollection
          .doc(recruteur.uid)
          .set(recruteur.toJson()); // ajout d'utilisateur dans le document
    } catch (e) {}
  }
}
