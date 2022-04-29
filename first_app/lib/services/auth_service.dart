import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/models/Student.dart';

class AuthService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //final GoogleSignIn _googleAuth = GoogleSignIn();

  //Init Firebase user
  Student _userFirebaseUser(User? firebaseUser) {
    return Student(
      uid: firebaseUser!.uid,
    );
  }

  //Signin Email/Pass
  Future loginUser(String login, String password) async {
    try {
      UserCredential endUserCredentials = await _firebaseAuth
          .signInWithEmailAndPassword(email: login, password: password);
      User firebaseUser = endUserCredentials.user!;
      return _userFirebaseUser(firebaseUser);
    } catch (e) {
      print('Account login failed, reason: ' + e.toString());
      return null;
    }
  }

  //Signup Email/Pass
  Future registerUser(String email, String password) async {
    try {
      UserCredential endUserCredentials = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User firebaseUser = endUserCredentials.user!;
      return _userFirebaseUser(firebaseUser);
    } catch (e) {
      print('Account creation failed, reason: ' + e.toString());
      return null;
    }
  }

  Future createUserDocument(String docId, Student mUser) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(docId)
          .set(mUser.toJson());
    } catch (e) {
      print(e);
    }
  }

  //Sign out
  Future<void> logout() async {
    try {
      print('logging out...');
      //await _googleAuth.signOut();
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}