import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/Requirement.dart';
import 'job_detail.dart';
import 'job_item.dart';

class JobsList extends StatefulWidget {
  const JobsList({Key? key}) : super(key: key);

  @override
  _JobsListState createState() => _JobsListState();
}

class _JobsListState extends State<JobsList> {
  TextEditingController _searchController = TextEditingController();
  bool searching = false;
  String valueSearch = "";
  var user = GetStorage().read("user");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(() {
      onSearchChanged();
    });
  }

  onSearchChanged() {
    searchResult();
  }

  searchResult() {
    var showResultList = [];
    if (_searchController.text != "") {
      for (var data in filtredList) {
        var requirement =
            Requirement.fromJson(data.data() as Map<String, dynamic>);
        if (requirement.profile!
            .contains(_searchController.text.toLowerCase())) {
          showResultList.add(data);
        }
      }
    } else {
      showResultList = List.from(filtredList);
    }
    setState(() {
      resultsList = showResultList;
    });
  }

  List resultsList = [];
  List filtredList = [];
  getData() async {
    var data = await FirebaseFirestore.instance
        .collection("requirement")
        .where("deadline", isGreaterThanOrEqualTo: DateTime.now())
        .get();
    setState(() {
      filtredList = data.docs;
    });
    searchResult();
    return " data.docs";
  }

//filtered all
  late Future resultLoaded;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    resultLoaded = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            controller: _searchController,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
                contentPadding: EdgeInsets.zero,
                prefixIcon: Container(
                  padding: EdgeInsets.all(15),
                  child: Image.asset(
                    'assets/images/search.png',
                    width: 20,
                  ),
                )),
          ),
          Expanded(
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 25),
                itemBuilder: (context, index) {
                  var listOfdata = resultsList;
                  List<Requirement> listOfrequirements = [];
                  for (var data in listOfdata) {
                    listOfrequirements.add(Requirement.fromJson(
                        data.data() as Map<String, dynamic>));
                  }
                  return GestureDetector(
                      onTap: () async {
                        var req = await FirebaseFirestore.instance
                            .collection("application")
                            .where("requirementId",
                                isEqualTo:
                                    "${listOfrequirements[index].requirementId}")
                            .where("studentId", isEqualTo: "${user['id']}")
                            .get();
                        bool able = req.docs.toList().isEmpty;
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) =>
                                JobDetail(listOfrequirements[index], able));
                      },
                      child: JobItem(
                        requirement: listOfrequirements[index],
                      ));
                },
                separatorBuilder: (_, index) => SizedBox(
                      width: 15,
                    ),
                itemCount: resultsList.length),
          ),
        ],
      ),
    );
  }
}
