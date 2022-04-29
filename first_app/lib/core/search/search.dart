import 'package:first_app/core/home/home_app_bar.dart';
import 'package:first_app/core/home/home_page.dart';
import 'package:first_app/core/home/recruteur/testList.dart';
import 'package:first_app/core/search/widget/search_app_bar.dart';
import 'package:first_app/core/search/widget/search_input.dart';
import 'package:first_app/core/search/widget/SearchList.dart';

import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  int myIndex = 0;
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
                HomeAppBar(),
                SearchInput(),
                //Expanded(child: SearchList()),
                Expanded(child: testList()),
              ],
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
