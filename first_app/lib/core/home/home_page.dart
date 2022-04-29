import 'package:first_app/core/home/job_list.dart';
import 'package:first_app/core/home/search_card.dart';
import 'package:first_app/core/home/tag_list.dart';
import 'package:flutter/material.dart';
import 'package:first_app/core/home/home_app_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
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
                    HomeAppBar(),
                    SearchCard(),
                    TagList(),
                    JobList(),
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
          onPressed: () {},
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Theme.of(context).primaryColor,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(
                    Icons.home,
                    size: 20,
                  )),
              BottomNavigationBarItem(
                label: 'Case',
                icon: Icon(
                  Icons.cases_outlined,
                  size: 20,
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Text(''),
              ),
              BottomNavigationBarItem(
                  label: 'Chat',
                  icon: Icon(
                    Icons.chalet_outlined,
                    size: 20,
                  )),
              BottomNavigationBarItem(
                  label: 'Person',
                  icon: Icon(
                    Icons.person_outlined,
                    size: 20,
                  )),
            ],
          ),
        ));
  }
}
