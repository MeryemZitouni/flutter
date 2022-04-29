import 'package:first_app/core/home/recruteur/Input.dart';
import 'package:flutter/material.dart';

class addBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 25,
        right: 25,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor, shape: BoxShape.circle),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, right: 10),
              child: Stack(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => recInput()));
                      },
                      icon: Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.grey,
                      )),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
