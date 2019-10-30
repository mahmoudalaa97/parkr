import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view/login_screen.dart';
import 'view/main_screen.dart';
enum SignIn{Authorized,NotAuthorized}
void main() {

  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SignIn signIn;
  checkAuthorized() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token=prefs.getString("token");
    setState(() {
      if(token==null){
        signIn=SignIn.NotAuthorized;
      }else{
        signIn=SignIn.Authorized;
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    checkAuthorized();
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: signIn==SignIn.NotAuthorized?LoginScreen():MainScreen(),
    );
  }
}
