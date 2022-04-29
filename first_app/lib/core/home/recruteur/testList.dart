import 'package:first_app/core/home/job_item.dart';
import 'package:first_app/models/job.dart';
import 'package:flutter/material.dart';
import 'package:first_app/core/home/job_detail.dart';

class testList extends StatelessWidget {
  final jobList = Job.generateJobs();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: ListView.separated(
          padding: EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 25,
          ),
          itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => JobDetail(jobList[index]));
              },
              child: JobItem(jobList[index])),
          separatorBuilder: (_, index) => SizedBox(
                height: 20,
              ),
          itemCount: jobList.length),
    );
  }
}
