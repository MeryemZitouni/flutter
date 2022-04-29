import 'package:first_app/core/home/job_item.dart';
import 'package:first_app/models/job.dart';
import 'package:flutter/material.dart';

class addedList extends StatelessWidget {
  final jobList = Job.generateJobs();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          top: 25,
        ),
        child: ListView.separated(
            padding: EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 25,
            ),
            itemBuilder: (context, index) => JobItem(
                  jobList[index],
                  showTime: true,
                ),
            separatorBuilder: (_, index) => SizedBox(height: 20),
            itemCount: jobList.length));
  }
}
