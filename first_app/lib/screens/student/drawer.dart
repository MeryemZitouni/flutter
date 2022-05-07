import 'package:first_app/screens/student/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/constants.dart';
import '../auth/components/remember_controller.dart';

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
                        " Name : ${user['name']}",
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
                  'Profile',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.account_circle, color: Colors.white),
                onTap: () {
                  Navigator.pop(context);
                  Get.to(Profile(
                    uid: "${user['id']}",
                  ));
                },
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
                          title: Text("Êtes-vous sure de déconnecter ?"),
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
                                      "Oui",
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
