import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/ApplicationModel.dart';

class StudentServices {
  Future<bool> applyToRequirement(ApplicationModel applicationModel) async {
    try {
      var applicationCollection =
          FirebaseFirestore.instance.collection("application");
      applicationCollection.add(applicationModel.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
