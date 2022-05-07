import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
