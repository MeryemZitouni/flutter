import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/core/home/recruteur/added.dart';

import 'package:first_app/models/recruteur.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:first_app/core/auth/social.dart';

import 'login_page.dart';
import 'package:first_app/services/authr_service.dart';

class SignUpRecScreen extends StatefulWidget {
  const SignUpRecScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpRecScreen> {
  Recruteur recruteur = Recruteur(
      companyName: 'testUser',
      location: 'test user',
      emailr: 'testuser@mail.com',
      logoUrl: 'jhfgghj',
      uid: '076665542');
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthRecService _authServices = new AuthRecService();
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  var confirmpasswordTextController = TextEditingController();
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  bool isvisible = true;
  bool confirmisvisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
                        controller: firstName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter First Name";
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.person_outline),
                          hintText: "First Name",
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
                        controller: lastName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Last Name";
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.person_outline),
                          hintText: "Last Name",
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
                        obscureText: isvisible,
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
                                isvisible = !isvisible;
                              });
                            },
                            icon: isvisible == true
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            color:
                                isvisible == true ? Colors.grey : Colors.green,
                          ),
                          hintText: "Password",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    //confirm password field
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
                        controller: confirmpasswordTextController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Password";
                          }
                          if (passwordTextController.text !=
                              confirmpasswordTextController.text) {
                            return "Password not Matched";
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
                                ? Colors.grey
                                : Colors.green,
                          ),
                          hintText: "Re-Enter Password",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //sign Up Button
                    MaterialButton(
                      color: Colors.grey,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 50,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      child: const Text(
                        "Upload CV",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //sign Up Button
                    MaterialButton(
                      color: Colors.grey,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 50,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          dynamic credentials =
                              await _authServices.registerUser(
                            emailTextController.text.trim(),
                            passwordTextController.text.trim(),
                          );
                          if (credentials == null) {
                            const snackBar = SnackBar(
                              content: Text('Email/Password are invalid'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            _authServices
                                .createUserDocument(
                                    _firebaseAuth.currentUser!.uid, recruteur)
                                .then((value) => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => added())));
                            /*Navigator.pushReplacement
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Homepage()));*/
                          }
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
                    const SizedBox(
                      height: 20,
                    ),
                    SocialLoginBtn(),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already a member ?",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text(
                            "Log in",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
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
