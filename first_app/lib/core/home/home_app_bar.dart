import 'package:first_app/core/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:first_app/services/auth_service.dart';

AuthService _authService = AuthService();

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 25,
          right: 25,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome home',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1),
                Text('Mr Y',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 30, right: 10),
                    child: IconButton(
                      icon: Icon(Icons.door_back_door),
                      onPressed: () {
                        _authService.logout().then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen())));
                      },
                    )),
                SizedBox(width: 20),
                ClipOval(
                  child: Image.asset('assets/images/avatar.jpg', width: 40),
                )
              ],
            )
          ],
        ));
  }
}
