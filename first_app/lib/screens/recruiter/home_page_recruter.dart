import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/Requirement.dart';
import 'package:first_app/screens/auth/components/remember_controller.dart';
import 'package:first_app/screens/recruiter/components/candidates.dart';
import 'package:first_app/screens/recruiter/components/edit_requirement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../constants/constants.dart';
import '../../widgets/icon_text.dart';
import '../components/home_app_bar.dart';

class HomepageRecruter extends StatefulWidget {
  const HomepageRecruter({Key? key}) : super(key: key);

  @override
  State<HomepageRecruter> createState() => _HomepageState();
}

class _HomepageState extends State<HomepageRecruter> {
  var user = GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: buildDrawer(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed("/add_job");
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            HomeAppBar(),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("requirement")
                  .where("companyName", isEqualTo: user['name'])
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.length != 0) {
                    return ListView.builder(
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs.toList();
                          List<Requirement> requirements = [];
                          for (var document in data) {
                            requirements.add(Requirement.fromJson(
                                document.data() as Map<String, dynamic>));
                          }
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              secondaryActions: [
                                IconSlideAction(
                                  onTap: () {
                                    Slidable.of(context)?.renderingMode ==
                                            SlidableRenderingMode.none
                                        ? Slidable.of(context)?.open()
                                        : Slidable.of(context)?.close();
                                  },
                                  caption: "Cancel",
                                  icon: Icons.close,
                                  color: Colors.green,
                                ),
                                IconSlideAction(
                                  caption: "Delete",
                                  icon: Icons.delete,
                                  color: Colors.red,
                                  onTap: () {
                                    snapshot.data!.docs[index].reference
                                        .delete();
                                  },
                                ),
                                IconSlideAction(
                                  caption: "Edit",
                                  icon: Icons.edit,
                                  color: Colors.blueAccent,
                                  onTap: () {
                                    Get.to(EditJob(
                                        requirement: requirements[index]));
                                  },
                                )
                              ],
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(Candidates(
                                    requirement: requirements[index],
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: Constants.screenHeight * 0.3,
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 40,
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.grey
                                                          .withOpacity(0.1),
                                                    ),
                                                    child: Image.network(
                                                        "${requirements[index].logoUrl}"),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "${requirements[index].companyName}",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          Text(
                                            "${requirements[index].profile}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconText(
                                                  Icons.location_on_outlined,
                                                  "${requirements[index].location}"),
                                              IconText(
                                                  Icons.access_time_outlined,
                                                  "${requirements[index].periode} Months ")
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: IconText(
                                                Icons.access_time_sharp,
                                                "Deadline : ${DateFormat("yyyy-MM-dd").format(requirements[index].deadline!)}"),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: Text("No requirement yet"),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    RememberController rememberController = RememberController();
    var user = GetStorage().read("user");
    return Drawer(
      elevation: 36.0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.indigo,
                Colors.blueGrey,
              ]),
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              height: Constants.screenHeight,
              child: ListView(padding: EdgeInsets.zero, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: Constants.screenHeight * 0.1,
                          backgroundImage: NetworkImage("${user['url']}"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Company Name : ${user['name']}",
                          style: TextStyle(
                              fontSize: Constants.screenHeight * 0.02,
                              color: Colors.white,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Deconnecter',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(Icons.logout, color: Colors.white),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Are you sure you wanna log out ?"),
                            actions: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Non"))),
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blueAccent,
                                  ),
                                  child: TextButton(
                                      onPressed: () {
                                        rememberController.Logout();
                                      },
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(color: Colors.white),
                                      ))),
                            ],
                          );
                        });
                  },
                ),
              ]),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
