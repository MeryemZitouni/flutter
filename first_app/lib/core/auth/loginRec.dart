import 'package:email_validator/email_validator.dart';
import 'package:first_app/core/auth/SignUpRec.dart';
import 'package:first_app/core/home/recruteur/added.dart';
import 'package:first_app/core/search/search.dart';
import 'package:flutter/material.dart';
import 'package:first_app/core/home/home_page.dart';
import 'package:first_app/core/auth/reset_password.dart';
import 'package:first_app/core/auth/signup_page.dart';
import 'package:first_app/core/auth/social.dart';
import 'package:first_app/services/authr_service.dart';

class LoginRecScreen extends StatefulWidget {
  const LoginRecScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// now it is responsive
//now we make our app home screen
class _LoginScreenState extends State<LoginRecScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
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
                    height: _size.height * 0.1,
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
                  const TextFields(),
                  SizedBox(
                    height: _size.height * 0.1,
                  ),
                  const SocialLoginBtn(),
                  SizedBox(
                    height: _size.height * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Not a member ?",
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
                                  builder: (context) =>
                                      const SignUpRecScreen()));
                        },
                        child: const Text(
                          "Join now",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _size.height * 0.1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFields extends StatefulWidget {
  const TextFields({
    Key? key,
  }) : super(key: key);

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  AuthRecService _authServices = new AuthRecService();
  final _formKey = GlobalKey<FormState>();

  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  bool isvisible = true;
  @override
  Widget build(BuildContext context) {
    return Form(
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
                  color: isvisible == true ? Colors.grey : Colors.green,
                ),
                hintText: "Password",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          //forgot button
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ForgotPassword()));
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
          MaterialButton(
            color: Colors.green,
            minWidth: double.infinity,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            height: 50,
            onPressed: () async {
              if (emailTextController.text.trim().isEmpty ||
                  passwordTextController.text.trim().isEmpty) {
                const snackBar = SnackBar(
                  content: Text('Email/Password can\'t be empty'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                dynamic credentials = await _authServices.loginUser(
                    emailTextController.text.trim(),
                    passwordTextController.text.trim());

                print('credentials are: ' + credentials.toString());
                if (credentials == null) {
                  const snackBar = SnackBar(
                    content: Text('Email/Password are invalid'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => added()));
                }
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
    );
  }
}
