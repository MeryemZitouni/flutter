import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/screens/auth/login/login_screen.dart';
import 'package:first_app/screens/recruiter/home_page_recruter.dart';
import 'package:first_app/screens/splash_screen/splash_screen.dart';
import 'package:first_app/screens/student/home_page_student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'screens/recruiter/components/add_requirement.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized(); //
  await Firebase.initializeApp(); //

  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash_screen",
      getPages: [
        GetPage(
            name: '/splash_screen',
            page: () => SplashScreen(),
            transition: Transition.rightToLeftWithFade),
        GetPage(
            name: '/add_job',
            page: () => AddJob(),
            transition: Transition.rightToLeftWithFade),
        GetPage(
            name: '/home_recruter',
            page: () => HomepageRecruter(),
            transition: Transition.rightToLeftWithFade),
        GetPage(
            name: '/login',
            page: () => LoginScreen(),
            transition: Transition.rightToLeftWithFade),
        GetPage(
            name: '/home_student',
            page: () => Homepage(),
            transition: Transition.rightToLeftWithFade),
      ],
    );
  }
}
