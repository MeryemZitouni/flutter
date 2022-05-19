import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../constants/constants.dart';

class Profile extends StatefulWidget {
  final String uid;
  const Profile({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<Profile> {
  ScrollController _controller = ScrollController();
  late FilePickerResult cv;
  bool check = false;
  File? pdfFile;
  bool loading = false;
  bool doneCv = false;
  var user = GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blueAccent,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xffe3eaef),
      body: Container(
        width: double.infinity,
        height: Constants.screenHeight,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc("${widget.uid}")
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage:
                                NetworkImage("${snapshot.data!.get("url")}"),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name : ${snapshot.data!.get("firstName")}",
                              style: TextStyle(
                                  fontSize: Constants.screenHeight * 0.015),
                            ),
                            Text(
                              "Lastname : ${snapshot.data!.get("lastName")}",
                              style: TextStyle(
                                  fontSize: Constants.screenHeight * 0.015),
                            ),
                            Text(
                              "Profile : ${snapshot.data!.get("instLevel")}",
                              style: TextStyle(
                                  fontSize: Constants.screenHeight * 0.015),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    "Email : ${snapshot.data!.get("email")}",
                                    style: TextStyle(
                                        fontSize:
                                            Constants.screenHeight * 0.015),
                                  ),
                                ],
                              ),
                            ),
                            if (user['role'] == "student") ...[
                              ElevatedButton.icon(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return AlertDialog(
                                            content: Container(
                                              height:
                                                  Constants.screenHeight * 0.2,
                                              child: Column(
                                                children: [
                                                  MaterialButton(
                                                    color: doneCv
                                                        ? Colors.green
                                                            .withOpacity(0.5)
                                                        : Colors.redAccent
                                                            .withOpacity(0.5),
                                                    minWidth: double.infinity,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    height: 50,
                                                    onPressed: () async {
                                                      cv = (await FilePicker
                                                          .platform
                                                          .pickFiles(
                                                              type: FileType
                                                                  .custom,
                                                              allowedExtensions: [
                                                            'pdf'
                                                          ]))!;
                                                      if (cv.count != 1) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Cv obligatoire",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.grey,
                                                            textColor:
                                                                Colors.white,
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
                                                  loading
                                                      ? Center(
                                                          child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ))
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                if (doneCv) {
                                                                  setState(() {
                                                                    loading =
                                                                        true;
                                                                  });
                                                                  String?
                                                                      uploadFile =
                                                                      cv
                                                                          .files
                                                                          .single
                                                                          .path;
                                                                  setState(() {
                                                                    pdfFile = File(cv
                                                                        .files
                                                                        .single
                                                                        .path!);
                                                                    print(
                                                                        pdfFile);
                                                                  });
                                                                  Reference
                                                                      reference =
                                                                      await FirebaseStorage
                                                                          .instance
                                                                          .ref()
                                                                          .child(
                                                                              pdfFile!.path);
                                                                  print(
                                                                      reference);

                                                                  final UploadTask
                                                                      uploadTask =
                                                                      reference
                                                                          .putFile(
                                                                              pdfFile!);
                                                                  uploadTask
                                                                      .whenComplete(
                                                                          () async {
                                                                    var cvUpload =
                                                                        await uploadTask
                                                                            .snapshot
                                                                            .ref
                                                                            .getDownloadURL();
                                                                    snapshot
                                                                        .data!
                                                                        .reference
                                                                        .update({
                                                                      'cv':
                                                                          cvUpload
                                                                    });
                                                                  });
                                                                  Future.delayed(
                                                                      Duration(
                                                                          seconds:
                                                                              3),
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      loading =
                                                                          false;
                                                                    });
                                                                    Fluttertoast.showToast(
                                                                        msg:
                                                                            "Update done",
                                                                        toastLength:
                                                                            Toast
                                                                                .LENGTH_SHORT,
                                                                        gravity:
                                                                            ToastGravity
                                                                                .BOTTOM,
                                                                        timeInSecForIosWeb:
                                                                            1,
                                                                        backgroundColor:
                                                                            Colors
                                                                                .grey,
                                                                        textColor:
                                                                            Colors
                                                                                .white,
                                                                        fontSize:
                                                                            16.0);
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                } else {
                                                                  setState(() {
                                                                    loading =
                                                                        false;
                                                                  });
                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          "Please select a cv file",
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_SHORT,
                                                                      gravity: ToastGravity
                                                                          .BOTTOM,
                                                                      timeInSecForIosWeb:
                                                                          1,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .grey,
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      fontSize:
                                                                          16.0);
                                                                }
                                                              },
                                                              child:
                                                                  Text("Edit")),
                                                        )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                      });
                                },
                                label: Text("Edit CV"),
                              )
                            ],
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                          child: SfPdfViewer.network(
                        "${snapshot.data!.get("cv")}",
                        canShowPaginationDialog: true,
                        canShowScrollStatus: true,
                        canShowScrollHead: true,
                      )),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            }),
      ),
    ));
  }
}
