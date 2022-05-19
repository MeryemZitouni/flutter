// ignore_for_file: prefer_const_constructors

import 'package:first_app/Services/StudentServices.dart';
import 'package:first_app/models/ApplicationModel.dart';
import 'package:first_app/models/Requirement.dart';
import 'package:first_app/widgets/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

class JobDetail extends StatefulWidget {
  final bool able;
  Requirement requirement;
  JobDetail(this.requirement, this.able);

  @override
  _State createState() => _State();
}

class _State extends State<JobDetail> {
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var user = GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      height: 550,
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 5,
            width: 60,
            color: Colors.grey.withOpacity(0.3),
          ),
          SizedBox(height: 30),
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
                    child: Image.network(widget.requirement.logoUrl!),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.requirement.companyName!,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            widget.requirement.profile!,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconText(
                  Icons.location_on_outlined, widget.requirement.location!),
              IconText(Icons.access_time_outlined,
                  "${widget.requirement.periode!} Months")
            ],
          ),
          SizedBox(height: 30),
          Text(
            'Requirement',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${widget.requirement.requirement}',
            style: TextStyle(),
          ),
          loading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  margin: EdgeInsets.symmetric(vertical: 25),
                  height: 45,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: widget.able
                        ? () async {
                            setState(() {
                              loading = true;
                            });

                            bool check = await StudentServices()
                                .applyToRequirement(ApplicationModel(
                                    studentId: user['id'],
                                    requirementId:
                                        widget.requirement.requirementId,
                                    meetUrl: ""));
                            if (check) {
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                setState(() {
                                  loading = false;
                                });
                                Fluttertoast.showToast(
                                    msg: "You have been successfully applied ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Navigator.pop(context);
                              });
                            } else {
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                setState(() {
                                  loading = false;
                                });
                                Fluttertoast.showToast(
                                    msg: "Error has been occured ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Navigator.pop(context);
                              });
                            }
                          }
                        : null,
                    child: widget.able
                        ? Text('Apply Now')
                        : Text('You have allready applied'),
                  ),
                )
        ],
      )),
    );
  }
}
