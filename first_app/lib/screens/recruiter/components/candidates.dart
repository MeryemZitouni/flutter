import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/Requirement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/constants.dart';
import '../../../models/ApplicationModel.dart';
import '../../student/profile.dart';

class Candidates extends StatefulWidget {
  final Requirement requirement;
  Candidates({Key? key, required this.requirement}) : super(key: key);

  @override
  _CandidatesState createState() => _CandidatesState();
}

class _CandidatesState extends State<Candidates> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Color> colors = [
    Color(0xffebd834),
    Color(0xff08c99c),
    Color(0xffFF6A88),
  ];
  int color = 0;
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {
          color = _tabController.index;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.blueAccent, //change your color here
        ),
        centerTitle: true,
        title: Text(
          "Candidates",
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: Container(
              alignment: Alignment.center,
              child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.blueAccent,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colors[color],
                ),
                controller: _tabController,
                tabs: [
                  Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text("Pending")),
                  Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text("Accepted")),
                  Container(
                      padding: const EdgeInsets.only(
                          right: 10, left: 10, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(" Refused ")),
                ],
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: TabBarView(
                controller: _tabController,
                children: [
                  pendingApplications(
                    status: "pending",
                    requirement: widget.requirement,
                  ),
                  pendingApplications(
                    status: "accepted",
                    requirement: widget.requirement,
                  ),
                  pendingApplications(
                    status: "refused",
                    requirement: widget.requirement,
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    ));
  }
}

class pendingApplications extends StatefulWidget {
  final String status;
  final Requirement requirement;
  pendingApplications({
    Key? key,
    required this.status,
    required this.requirement,
  }) : super(key: key);
  var user = GetStorage().read("user");

  @override
  _pendingApplicationsState createState() => _pendingApplicationsState();
}

class _pendingApplicationsState extends State<pendingApplications> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('application')
            .where("status", isEqualTo: "${widget.status}")
            .where("requirementId", isEqualTo: widget.requirement.requirementId)
            .snapshots(),
        builder: (context, snapshot1) {
          if (snapshot1.hasData) {
            if (snapshot1.data!.docs != 0) {
              return ListView.builder(
                  itemCount: snapshot1.data!.size,
                  itemBuilder: (context, index) {
                    var listOfData = snapshot1.data!.docs.toList();
                    List<ApplicationModel> listOfApplications = [];
                    for (var data in listOfData) {
                      listOfApplications.add(ApplicationModel.fromJson(
                          data.data() as Map<String, dynamic>));
                    }
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20)),
                          height: Constants.screenHeight * 0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("requirement")
                                      .doc(listOfApplications[index]
                                          .requirementId)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<
                                              DocumentSnapshot<
                                                  Map<String, dynamic>>>
                                          snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection("users")
                                                        .doc(listOfApplications[
                                                                index]
                                                            .studentId)
                                                        .snapshots(),
                                                    builder: (context,
                                                        AsyncSnapshot<
                                                                DocumentSnapshot<
                                                                    Map<String,
                                                                        dynamic>>>
                                                            snapshot2) {
                                                      if (snapshot2.hasData) {
                                                        return CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                            "${snapshot2.data!.get("url")}",
                                                          ),
                                                          radius: Constants
                                                                  .screenHeight *
                                                              0.04,
                                                        );
                                                      } else {
                                                        return Container();
                                                      }
                                                    }),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      StreamBuilder(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "users")
                                                              .doc(listOfApplications[
                                                                      index]
                                                                  .studentId)
                                                              .snapshots(),
                                                          builder: (context,
                                                              AsyncSnapshot<
                                                                      DocumentSnapshot<
                                                                          Map<String,
                                                                              dynamic>>>
                                                                  snapshot2) {
                                                            if (snapshot2
                                                                .hasData) {
                                                              return Text(
                                                                  " Full name : ${snapshot2.data!.get("firstName")} ${snapshot2.data!.get("lastName")}");
                                                            } else {
                                                              return Container();
                                                            }
                                                          }),
                                                      Text(
                                                          "Profile : ${snapshot.data!.get("profile")}"),
                                                      if (listOfApplications[
                                                                  index]
                                                              .status ==
                                                          "accepted") ...[
                                                        Text(
                                                            "Date : ${DateFormat("yyyy-mm-dd-hh-mm").format(listOfApplications[index].date!)}")
                                                      ]
                                                    ],
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                              if (listOfApplications[index].status ==
                                  "pending") ...[
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(
                                            listOfApplications[index].studentId)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<
                                                DocumentSnapshot<
                                                    Map<String, dynamic>>>
                                            snapshot) {
                                      if (snapshot.hasData) {
                                        return Container(
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    snapshot1.data!.docs[index]
                                                        .reference
                                                        .update({
                                                      'status': "refused"
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors.red),
                                                  child: Text("Refuse")),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Get.to(Profile(
                                                        uid: snapshot.data!
                                                            .get("uid")));
                                                  },
                                                  child: Text("See cv")),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.green),
                                                  onPressed: () {
                                                    bottomSheetDemandeur(
                                                      context,
                                                      snapshot1
                                                          .data!.docs[index],
                                                    );
                                                  },
                                                  child: Text("Accept")),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }),
                              ]
                            ],
                          )),
                    );
                  });
            } else {
              return Center(
                child: Text("none"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

bottomSheetDemandeur(BuildContext context, DocumentSnapshot snapshot) {
  final _formKey = GlobalKey<FormState>();
  TextEditingController LinkController = TextEditingController();

  bool isLoading = false;
  bool isDone = false;
  DateTime date = DateTime.now();

  Size size = MediaQuery.of(context).size;
  showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            color: Colors.transparent,
            child: Container(
              height: size.height * 0.7,
              decoration: BoxDecoration(
                  color: Color(0xffe3eaef),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.07, vertical: 50),
                child: isDone
                    ? doneAddPlanning(context, size)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Add interview details   "),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "enter link";
                                      }
                                    },
                                    controller: LinkController,

                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide.none,
                                      ), // OutlineInputBorder
                                      filled: true,
                                      fillColor: Color(0xFFe7edeb),
                                      hintText: "Meet Link",
                                      prefixIcon: Icon(
                                        Icons.format_list_numbered_sharp,
                                        color: Colors.grey[600],
                                      ), //Icon
                                    ), // InputDecoration
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: date,
                                              firstDate: date,
                                              lastDate: DateTime(2023))
                                          .then((value) {
                                        setState(() {
                                          date = value!;
                                        });
                                      });
                                    },
                                    child: Text(
                                        "Date:${DateFormat("yyyy-MM-dd").format(date)}"))
                              ],
                            ),
                          ),
                          isLoading
                              ? CircularProgressIndicator()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          padding: EdgeInsets.all(15),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text("Cancel"),
                                        )),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          padding: EdgeInsets.all(15),
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            snapshot.reference.update({
                                              'date': date,
                                              "status": "accepted",
                                              "meetUrl": LinkController.text,
                                            });
                                            setState(() {
                                              isDone = true;
                                              isLoading = false;
                                            });
                                          }
                                        },
                                        child: Text("Confirm")),
                                  ],
                                ),
                        ],
                      ),
              ),
            ),
          );
        });
      });
}

Column doneAddPlanning(BuildContext context, Size size) {
  return Column(
    children: [
      Lottie.asset("assets/images/success.json",
          height: size.height * 0.1, repeat: false),
      Text(
        "this student has been accepted",
        style: TextStyle(fontSize: size.height * 0.02),
      ),
      SizedBox(
        height: size.height * 0.08,
      ),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.all(15),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("Cancel"),
          ))
    ],
  );
}
