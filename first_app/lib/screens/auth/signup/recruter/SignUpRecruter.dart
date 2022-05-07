import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/Services/AuthServices.dart';
import 'package:first_app/constants/constants.dart';
import 'package:first_app/screens/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUprecruter extends StatefulWidget {
  const SignUprecruter({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUprecruter> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  var confirmpasswordTextController = TextEditingController();
  var locationController = TextEditingController();
  var companyNameController = TextEditingController();
  bool isvisible = true;
  bool confirmisvisible = true;
  File? _image;
  bool check = false;
  bool loading = false;
  Future getProfileImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _image = File(image!.path);
      check = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white38,
                          radius: 80,
                          backgroundImage: _image == null
                              ? AssetImage('assets/images/office.png')
                                  as ImageProvider
                              : FileImage(_image!),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              bottom: 10, end: 2),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: IconButton(
                                onPressed: () {
                                  getProfileImage();
                                },
                                icon: Icon(
                                  Icons.add_photo_alternate_sharp,
                                  color: Colors.blueAccent,
                                  size: Constants.screenHeight * 0.05,
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
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
                          final bool _isvalid =
                              EmailValidator.validate(emailTextController.text);
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
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextFormField(
                        controller: companyNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter First Name";
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.person_outline),
                          hintText: "Company name",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextFormField(
                        controller: locationController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter location";
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.location_on),
                          hintText: "Location",
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
                        obscureText: confirmisvisible,
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
                                confirmisvisible = !confirmisvisible;
                              });
                            },
                            icon: confirmisvisible == true
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            color: confirmisvisible == true
                                ? Colors.blueAccent
                                : Colors.green,
                          ),
                          hintText: "Enter Password",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //sign Up Button

                    const SizedBox(
                      height: 30,
                    ),
                    //sign Up Button
                    loading
                        ? Center(child: CircularProgressIndicator())
                        : MaterialButton(
                            color: Colors.grey,
                            minWidth: double.infinity,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            height: 50,
                            onPressed: () async {
                              if (_formKey.currentState!.validate() &&
                                  _image != null) {
                                setState(() {
                                  loading = true;
                                });
                                var image =
                                    FirebaseStorage.instance.ref(_image!.path);
                                var task = image.putFile(_image!);
                                var logoUrl =
                                    await (await task).ref.getDownloadURL();
                                bool check =
                                    await AuthServices().signUpRecruter(
                                  emailTextController.text,
                                  passwordTextController.text,
                                  companyNameController.text,
                                  locationController.text,
                                  logoUrl,
                                );
                                if (check) {
                                  setState(() {
                                    loading = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "done",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  Get.to(LoginScreen());
                                } else {
                                  setState(() {
                                    loading = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "user exists",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "image ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
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
