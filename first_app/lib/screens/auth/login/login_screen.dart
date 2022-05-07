import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/constants/constants.dart';
import 'package:first_app/models/recruteur.dart';
import 'package:first_app/screens/recruiter/home_page_recruter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Services/AuthServices.dart';
import '../../../models/Student.dart';
import '../components/alert_choose_type.dart';
import '../components/remember_controller.dart';
import '../reset_password/reset_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// now it is responsive
//now we make our app home screen
class _LoginScreenState extends State<LoginScreen> {
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  bool isVisible = true;
  final controller = RememberController();
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  Widget positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  Widget negative() {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "No ",
          style: TextStyle(color: Colors.blueAccent),
        ));
  }

  Future<bool> avoidRteurnButton() async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("You wanna quit "),
            actions: [
              negative(),
              positive(),
            ],
          );
        });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: avoidRteurnButton,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Constants.screenHeight * 0.1,
                    ),
                    const Text(
                      "Log in",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //email
                          Container(
                            padding: const EdgeInsets.only(left: 15.0),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: TextFormField(
                              controller: emailTextController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Email";
                                }
                                //now we use email validator package
                                final bool _isvalid = EmailValidator.validate(
                                    emailTextController.text);
                                if (!_isvalid) {
                                  return "Email was entered incorrectly";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.email_outlined),
                                hintText: "Email",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          //password field
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 15.0),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: TextFormField(
                              obscureText: isVisible,
                              controller: passwordTextController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Password";
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisible = !isVisible;
                                      });
                                    },
                                    icon: isVisible
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off)),
                                hintText: "Password",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          //forgot button
                          TextButton(
                            onPressed: () {
                              Get.to(ForgotPassword());
                            },
                            child: const Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //login button
                          loading
                              ? Center(child: CircularProgressIndicator())
                              : MaterialButton(
                                  color: Colors.green,
                                  minWidth: double.infinity,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  height: 50,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      Future check = AuthServices().signIn(
                                          emailTextController.text,
                                          passwordTextController.text);

                                      check.then((value) async {
                                        if (value) {
                                          final FirebaseAuth auth =
                                              await FirebaseAuth.instance;
                                          final User? user =
                                              await auth.currentUser;
                                          final uid = user!.uid;
                                          var UserData = await FirebaseFirestore
                                              .instance
                                              .collection('users')
                                              .doc(uid)
                                              .get();

                                          // token pour la notification
                                          if (UserData["role"] == "recruter") {
                                            // test de role
                                            await controller.RememberRecruter(
                                                Recruteur.fromJson(
                                                    UserData.data() as Map<
                                                        String,
                                                        dynamic>)); //.data() pour recuperer le donneées de document
                                            Get.to(HomepageRecruter());

                                            setState(() {
                                              loading = false;
                                            });
                                          } else {
                                            await controller.RememberStudent(
                                                Student.fromJson(UserData.data()
                                                    as Map<String, dynamic>));
                                            Get.toNamed("/home_student");

                                            setState(() {
                                              loading = false;
                                            });
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Login failed ",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.grey,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                          setState(() {
                                            loading = false;
                                          });
                                        }
                                      });
                                    }
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Constants.screenHeight * 0.4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "You have no account?",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            alertChooseType().show(context);
                          },
                          child: const Text(
                            "join us",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Constants.screenHeight * 0.1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
