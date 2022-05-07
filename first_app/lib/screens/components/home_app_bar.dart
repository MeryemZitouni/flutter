import 'package:first_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HomeAppBar extends StatelessWidget {
  HomeAppBar({Key? key}) : super(key: key);
  var user = GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Constants.screenWidth * 0.08,
          vertical: Constants.screenHeight * 0.05),
      child: Row(
        children: [
          InkWell(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: CircleAvatar(
              radius: Constants.screenHeight * 0.032,
              backgroundColor: Colors.green,
              child: CircleAvatar(
                radius: Constants.screenHeight * 0.029,
                backgroundImage: NetworkImage("${user['url']}"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.1),
              child: Text('Welcome back ${user['name']}',
                  style: TextStyle(fontSize: Constants.screenWidth * 0.05)),
            ),
          ),
        ],
      ),
    ));
  }
}
