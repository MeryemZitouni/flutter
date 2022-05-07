import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../../constants/constants.dart';
import '../auth/login/login_screen.dart';
import '../recruiter/home_page_recruter.dart';
import '../student/home_page_student.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<SplashScreen> {
  var auth = GetStorage().read("auth");
  var type_auth = GetStorage().read("type_auth");
  @override
  void initState() {
    Timer(
      Duration(seconds: 4),
      () => Get.to(auth == 1
          ? (type_auth == 1 ? HomepageRecruter() : Homepage())
          : LoginScreen()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                    height: Constants.screenHeight * 0.1,
                    child: Image.asset("assets/images/logo.png")),
              ),
              SizedBox(
                height: Constants.screenHeight * 0.2,
              ),
              Text(
                "Stagy",
                style: TextStyle(fontSize: 25, color: Colors.blueAccent),
              ),
              SizedBox(
                height: Constants.screenHeight * 0.06,
              ),
              Container(
                child: Lottie.asset('assets/images/loading.json',
                    height: Constants.screenHeight * 0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
