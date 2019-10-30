import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:parkr/comman/CustomDialog.dart';
import 'package:parkr/model/user.dart';
import 'package:parkr/service/SharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'dart:convert';

import 'report_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> page = [HomeScreen(), ReportScreen()];

  int selected = 0;
  Color colorSelected = Color(0xffFAC758);
  Color colorTextSelected = Colors.black;
  Color colorNotSelected = Colors.white;
  Color colorTextNotSelected = Color(0x8f000000);
  SharedPref sharedPref = SharedPref();


  Future<dynamic> getUser() async {
    return await sharedPref.readUser();
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff363636),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              height: 55,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 14),
                    child: Icon(
                      Icons.person,
                      size: 35,
                      color: Color(0xffFF3B00),
                    ),
                  ),
                  FutureBuilder(
                    future: getUser(),
                    builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                      User  user=User.fromJson(snapshot.data);
                        return Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3, bottom: 4),
                                    child: Text(
                                      user.data.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_on,
                                        size: 15,
                                      ),
                                      Text(user.data.placeName)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(right: 16),
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      "assets/logo.png",
                      width: 70,
                      height: 30,
                    ),
                  ))
                ],
              ),
            ),
            Expanded(
              child: page[selected],
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15))),
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: logOut,
                      child: Container(
                        margin: EdgeInsets.only(left: 21),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color(0x8f000000)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selected = 0;
                        });
                      },
                      child: Container(
                        color: selected == 0 ? colorSelected : colorNotSelected,
                        alignment: Alignment.center,
                        child: Text(
                          "Home",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: selected == 0
                                  ? colorTextSelected
                                  : colorTextNotSelected),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selected = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: selected == 1
                                ? colorSelected
                                : colorNotSelected,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15))),
                        alignment: Alignment.center,
                        child: Text(
                          "Reports",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: selected == 1
                                  ? colorTextSelected
                                  : colorTextNotSelected),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logOut() async {
    if (await sharedPref.removeToken() && await sharedPref.removeUser())
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
  }
}
