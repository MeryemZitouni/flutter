import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Services/AuthServices.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  var emailTextController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
          child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Spacer(),
                      const Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
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
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Forgot password don't worry, provide us your registered email,we will send you an email to reset your password.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      const Spacer(),
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : MaterialButton(
                              color: Colors.green,
                              minWidth: double.infinity,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              height: 50,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  AuthServices()
                                      .resetPassword(emailTextController.text)
                                      .then((value) {
                                    if (value) {
                                      Fluttertoast.showToast(
                                          backgroundColor: Colors.grey,
                                          msg:
                                              "we have sent a reset password email", // message
                                          toastLength:
                                              Toast.LENGTH_SHORT, // length
                                          gravity:
                                              ToastGravity.BOTTOM, // location
                                          timeInSecForIosWeb: 1 // duration
                                          );
                                      setState(() {
                                        isLoading = false;
                                      });
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Fluttertoast.showToast(
                                          backgroundColor: Colors.grey,
                                          msg:
                                              "No account found with this email", // message
                                          toastLength:
                                              Toast.LENGTH_SHORT, // length
                                          gravity:
                                              ToastGravity.BOTTOM, // location
                                          timeInSecForIosWeb: 1 // duration
                                          );
                                    }
                                  });
                                }
                              },
                              child: const Text(
                                "Reset Password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}
