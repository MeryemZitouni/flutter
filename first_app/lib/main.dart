import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/core/auth/login_page.dart';
import 'package:first_app/core/auth/welcome.dart';
import 'package:first_app/core/home/applications.dart';
import 'package:first_app/core/home/job_detail.dart';
import 'package:first_app/core/home/recruteur/Input.dart';
import 'package:first_app/core/home/recruteur/added.dart';
import 'package:first_app/core/home/recruteur/addedList.dart';
import 'package:first_app/core/search/search.dart';
import 'package:first_app/core/search/widget/SearchList.dart';
import 'package:first_app/models/application.dart';
import 'package:flutter/cupertino.dart';
import 'package:first_app/core/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:first_app/core/home/myapp.dart';
import 'firebase_options.dart';
import 'package:first_app/services/auth_service.dart';

AuthService _authService = AuthService();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(home: await getAuthState()));
}

/*class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 108, 67, 183),
          accentColor: Color.fromARGB(255, 233, 226, 126),
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
        ),
        home: SearchPage());
  }
}*/

Future<Widget> getAuthState() async {
  return StreamBuilder<User?>(
    stream: _firebaseAuth.authStateChanges(),
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasData) {
        return welcomepage();
      }
      return LoginScreen();
    },
  );
}
