import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/Requirement.dart';
import 'package:get_storage/get_storage.dart';

class RecruterSrvices {
  Future<bool> createRequirement(Requirement requirement) async {
    try {
      var user = GetStorage().read("user");
      var requirementCollection =
          FirebaseFirestore.instance.collection("requirement").doc();
      requirementCollection.set(requirement.toJson(requirementCollection.id));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> editRequirement(Requirement requirement) async {
    try {
      var user = GetStorage().read("user");
      var requirementCollection = FirebaseFirestore.instance
          .collection("requirement")
          .doc(requirement.requirementId);
      requirementCollection
          .update(requirement.toJson(requirement.requirementId!));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
