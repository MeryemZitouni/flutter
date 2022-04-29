import 'package:first_app/core/home/job_item.dart';
import 'package:first_app/core/home/job_list.dart';
import 'package:flutter/material.dart';
import 'package:first_app/models/job.dart';

class JobFavoriteWidget extends StatefulWidget {
  const JobFavoriteWidget({Key? key}) : super(key: key);

  @override
  _JobFavoriteWidgetState createState() => _JobFavoriteWidgetState();
}

class _JobFavoriteWidgetState extends State<JobFavoriteWidget> {
  final jobList = Job.generateJobs();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(Icons.arrow_back),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "My applications",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) => JobItem(
                          jobList[index],
                          showTime: true,
                        ),
                    separatorBuilder: (_, index) => SizedBox(height: 20),
                    itemCount: jobList.length))
          ])),
    );
  }
}
