import 'package:first_app/models/Requirement.dart';
import 'package:first_app/widgets/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JobItem extends StatelessWidget {
  Requirement requirement;

  JobItem({required this.requirement});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 270,
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
                      child: Image.network(requirement.logoUrl!),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      requirement.companyName!,
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
              requirement.profile!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconText(Icons.location_on_outlined, requirement.location!),
                IconText(Icons.access_time_outlined,
                    "${requirement.periode!} Months")
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconText(Icons.access_time_sharp,
                  "Deadline : ${DateFormat("yyyy-MM-dd").format(requirement.deadline!)}"),
            ),
          ],
        ));
  }
}
