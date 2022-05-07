import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/ApplicationModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/constants.dart';

class MyApplications extends StatefulWidget {
  const MyApplications({Key? key}) : super(key: key);

  @override
  _CandidatesState createState() => _CandidatesState();
}

class _CandidatesState extends State<MyApplications>
    with TickerProviderStateMixin {
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
                  ),
                  pendingApplications(
                    status: "accepted",
                  ),
                  pendingApplications(
                    status: "refused",
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

class pendingApplications extends StatelessWidget {
  final String status;
  pendingApplications({
    Key? key,
    required this.status,
  }) : super(key: key);
  var user = GetStorage().read("user");
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('application')
            .where("status", isEqualTo: "${status}")
            .where("studentId", isEqualTo: "${user['id']}")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs != 0) {
              return ListView.builder(
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    var listOfData = snapshot.data!.docs.toList();
                    List<ApplicationModel> listOfApplications = [];
                    for (var data in listOfData) {
                      listOfApplications.add(ApplicationModel.fromJson(
                          data.data() as Map<String, dynamic>));
                    }
                    return GestureDetector(
                      onTap: listOfApplications[index].status != "accepted"
                          ? null
                          : () async {
                              _launchInBrowser(Uri.parse(
                                  listOfApplications[index].meetUrl!));
                            },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20)),
                            height: Constants.screenHeight * 0.15,
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                      "${snapshot.data!.get("logoUrl")}",
                                                    ),
                                                    radius:
                                                        Constants.screenHeight *
                                                            0.04,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            "Compnay name : ${snapshot.data!.get("companyName")}"),
                                                        Text(
                                                            "Post : ${snapshot.data!.get("profile")}"),
                                                        if (listOfApplications[
                                                                    index]
                                                                .status ==
                                                            "accepted") ...[
                                                          Text(
                                                              "Date : ${DateFormat("yyyy-MM-dd-hh-mm").format(listOfApplications[index].date!)}")
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
                                    })
                              ],
                            )),
                      ),
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
