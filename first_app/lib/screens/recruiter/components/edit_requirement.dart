import 'package:first_app/Services/RecruterServices.dart';
import 'package:first_app/models/Requirement.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class EditJob extends StatefulWidget {
  final Requirement requirement;
  const EditJob({Key? key, required this.requirement}) : super(key: key);

  @override
  State<EditJob> createState() => _recInputState();
}

class _recInputState extends State<EditJob> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController profile = TextEditingController();
  TextEditingController periode = TextEditingController();
  TextEditingController requirement = TextEditingController();
  DateTime deadline = DateTime.now();
  var user = GetStorage().read("user");
  bool loading = false;
  getData() {
    setState(() {
      profile.text = widget.requirement.profile!;
      periode.text = widget.requirement.periode!;
      requirement.text = widget.requirement.requirement!;
      deadline = widget.requirement.deadline!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blueAccent,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Edit  requirement ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextFormField(
                        controller: profile,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter  profile ";
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.person_outline),
                          hintText: "Profile",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: periode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter periode";
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.person_outline),
                          hintText: "Periode in months ",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    //requirement  field
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextFormField(
                        controller: requirement,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter requirement";
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.person_outline),
                          hintText: "requirement",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2023))
                              .then((value) {
                            setState(() {
                              deadline = value!;
                            });
                          });
                        },
                        child: Text(
                            "Deadline : ${DateFormat("yyyy-mm-dd").format(deadline)}")),
                    const SizedBox(
                      height: 30,
                    ),
                    //+add Button

                    loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : MaterialButton(
                            color: Colors.grey,
                            minWidth: double.infinity,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            height: 50,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                bool check = await RecruterSrvices()
                                    .editRequirement(Requirement(
                                        appliers: widget.requirement.appliers,
                                        companyName:
                                            widget.requirement.companyName,
                                        location: widget.requirement.location,
                                        logoUrl: widget.requirement.logoUrl,
                                        periode: periode.text,
                                        deadline: deadline,
                                        requirementId:
                                            widget.requirement.requirementId,
                                        requirement: requirement.text,
                                        profile: profile.text));
                                if (check) {
                                  Fluttertoast.showToast(
                                      msg: "Requirement edited with success",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  Future.delayed(
                                      const Duration(milliseconds: 500), () {
                                    setState(() {
                                      loading = false;
                                    });
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "an error has been occured",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              }
                            },
                            child: const Text(
                              "Edit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
