import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Services/AuthServices.dart';
import '../../../../constants/constants.dart';
import '../../login/login_screen.dart';

class SignUpStudent extends StatefulWidget {
  const SignUpStudent({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpStudent> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();

  var firstName = TextEditingController();
  var lastName = TextEditingController();
  bool isvisible = true;
  bool confirmisvisible = true;
  File? _image;
  late FilePickerResult cv;
  bool check = false;
  File? pdfFile;
  bool loading = false;
  bool doneCv = false;
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
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
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
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white38,
                          radius: 50,
                          backgroundImage: _image == null
                              ? AssetImage('assets/images/user.png')
                                  as ImageProvider
                              : FileImage(_image!),
                        ),
                        Transform.translate(
                          offset: Offset(5, 5),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: IconButton(
                                onPressed: () {
                                  getProfileImage();
                                },
                                icon: Icon(
                                  Icons.add_photo_alternate_sharp,
                                  color: Colors.blueAccent,
                                  size: Constants.screenHeight * 0.03,
                                )),
                          ),
                        ),
                      ],
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

                    //sign Up Button
                    MaterialButton(
                      color: doneCv
                          ? Colors.green.withOpacity(0.5)
                          : Colors.redAccent.withOpacity(0.5),
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 50,
                      onPressed: () async {
                        cv = (await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf']))!;
                        if (cv.count != 1) {
                          Fluttertoast.showToast(
                              msg: "Cv obligatoire",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          setState(() {
                            doneCv = true;
                          });
                        }
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
                    loading
                        ? CircularProgressIndicator()
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
                                var imageUrl =
                                    await (await task).ref.getDownloadURL();
                                String? uploadFile = cv.files.single.path;
                                setState(() {
                                  pdfFile = File(cv.files.single.path!);
                                  print(pdfFile);
                                });
                                Reference reference = await FirebaseStorage
                                    .instance
                                    .ref()
                                    .child(pdfFile!.path);
                                print(reference);

                                final UploadTask uploadTask =
                                    reference.putFile(pdfFile!);

                                uploadTask.whenComplete(() async {
                                  var cvUpload = await uploadTask.snapshot.ref
                                      .getDownloadURL();
                                  bool check = await AuthServices()
                                      .signUpStudent(
                                          emailTextController.text,
                                          passwordTextController.text,
                                          firstName.text,
                                          lastName.text,
                                          imageUrl,
                                          "",
                                          cvUpload);
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
                                });
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

                    const SizedBox(
                      height: 30,
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
