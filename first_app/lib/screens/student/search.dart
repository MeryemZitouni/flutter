import 'package:first_app/screens/student/drawer.dart';
import 'package:flutter/material.dart';

import '../components/home_app_bar.dart';
import 'jobsList.dart';

class SearchPage extends StatelessWidget {
  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: buildDrawer(context),
        resizeToAvoidBottomInset: false,
        body: Container(
            width: double.infinity,
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeAppBar(),
                  Expanded(child: JobsList()),
                ],
              ),
            )),
      ),
    );
  }
}
