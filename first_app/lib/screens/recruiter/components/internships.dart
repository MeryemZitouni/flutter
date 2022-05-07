import 'package:first_app/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/icon_text.dart';

class MyInternShips extends StatefulWidget {
  const MyInternShips({Key? key}) : super(key: key);

  @override
  _MyInternShipsState createState() => _MyInternShipsState();
}

class _MyInternShipsState extends State<MyInternShips> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: Constants.screenHeight * 0.2,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            child: Image.asset("assets/images/Bridge.png"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "job.company",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    "  job.title",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconText(Icons.location_on_outlined, "job.location"),
                      if (true) IconText(Icons.access_time_outlined, "job.time")
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
