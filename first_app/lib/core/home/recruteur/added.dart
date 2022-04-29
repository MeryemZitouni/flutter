import 'package:first_app/core/home/job_list.dart';
import 'package:first_app/core/home/recruteur/addedList.dart';
import 'package:first_app/core/home/recruteur/appBar.dart';
import 'package:first_app/core/home/recruteur/testList.dart';
import 'package:flutter/material.dart';
import 'package:first_app/core/home/job_detail.dart';
import 'package:first_app/core/home/job_item.dart';

import 'package:first_app/models/job.dart';

class added extends StatelessWidget {
  const added({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addBar(),
              Expanded(child: testList()),
            ],
          )
        ],
      ),
    );
  }
}
