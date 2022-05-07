import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/models/Student.dart';

import '../models/recruteur.dart';
import 'DbServices.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> signIn(String emailController, String passwordController) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: emailController, password: passwordController);

      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> signUpStudent(
      String emailController,
      String passwordController,
      String firstNameController,
      String lastNameController,
      String urlController,
      String instLevel,
      String cv) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: emailController, password: passwordController);

      await DbServices().saveStudent(Student(
          uid: user!.uid,
          cv: cv,
          email: emailController,
          firstName: firstNameController,
          instLevel: instLevel,
          lastName: lastNameController,
          url: urlController,
          role: "student")); // à travers le formulaire

      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signUpRecruter(
      String emailController,
      String passwordController,
      String companyNameController,
      String locationController,
      String logourl) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: emailController, password: passwordController);

      await DbServices().saveRecruteur(Recruteur(
          uid: user!.uid,
          companyName: companyNameController,
          emailr: emailController,
          location: locationController,
          logoUrl: logourl,
          role: "recruter")); // à travers le formulaire

      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> resetPassword(String emailController) async {
    try {
      await auth.sendPasswordResetEmail(email: emailController);
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  User? get user => auth.currentUser; //pour recuperer l'utilisateur courant
}
