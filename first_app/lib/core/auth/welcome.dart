import 'package:first_app/core/auth/loginRec.dart';
import 'package:first_app/core/auth/login_page.dart';
import 'package:first_app/core/home/recruteur/added.dart';
import 'package:first_app/core/search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:test/core/auth/Conducteur.dart';
//import 'package:test/core/auth/login_page_passager.dart';
//import 'package:test/core/auth/login_page_conducteur.dart';

class welcomepage extends StatelessWidget {
  const welcomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        // leading: Icon(Icons.logout_rounded),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        // title: Center(
        //  child: const Text('Smart Taxi',style: TextStyle(fontSize: 20),),

        //  ),
        toolbarHeight: 100,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(children: [
            Image.asset('assets/images/stage.jpg'),
            // Decoration:BoxDecoration(
            // Image:DecorationImage(image: AssetImage("image/Backg.jpg"))
            // ),
            // Image.asset(
            // 'image/Backg.jpg',
            ////width: 600,
            //  ),
            //  Text(
            //  'Lets',
            //style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            // ),
//
            SizedBox(
              height: 10,
            ),

            ////  Text(
            // 'Never a better',
            ////style: TextStyle(
            // fontWeight: FontWeight.bold,
            // fontSize: 14,
            // color: Colors.white),
            //  ),
            SizedBox(
              height: 80,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      CupertinoPageRoute(builder: (context) => LoginScreen()));
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 219, 199, 239)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 175, 143, 219)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24))),
                ),
                child: Padding(
                    padding: EdgeInsets.all(14),
                    child: Text(
                      'Etudiant',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            //bouton 2
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => LoginRecScreen()));
                },
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24))),
                ),
                child: Padding(
                    padding: EdgeInsets.all(14),
                    child: Text(
                      'Recruteur',
                      style: TextStyle(fontSize: 20),
                    )),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
