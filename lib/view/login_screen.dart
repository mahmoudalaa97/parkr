import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parkr/service/API.dart';
import 'package:parkr/service/SharedPref.dart';
import 'main_screen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool autoValidate = false;
  GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  String _email;
  String _password;
  Api api = Api();
  SharedPref sharedPref = SharedPref();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldStateKey,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            autovalidate: autoValidate,
            key: formStateKey,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 115),
                  child: Image.asset(
                    "assets/logo.png",
                    width: 155,
                    height: 60,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 87, right: 27, left: 27),
                  child: TextFormField(
                    onSaved: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) return "please enter user ID";

                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter User ID",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xffFF9D00),
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 17, right: 27, left: 27),
                  child: TextFormField(
                    onSaved: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) return "please enter passowrd";

                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter Password",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xffFF3B00),
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 95, right: 67, left: 67),
                  width: MediaQuery.of(context).size.width,
                  height: 43,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xffFAC758),
                        Color(0xffEA3636),
                      ], begin: Alignment.topCenter, end: Alignment(0.1, 4)),
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      login();
                    },
                    child: Center(
                        child: Text(
                      "Login",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 17),
                  child: Center(
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        "Need Help?",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 63),
                    child: Center(
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "V 1.0",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.grey.withOpacity(0.7)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (formStateKey.currentState.validate()) {
      formStateKey.currentState.save();
      http.Response response;
      response = await api.login(_email, _password);
      if (response.statusCode == 200) {
        print(response.body);
        String token = response.headers["authorization"];
        sharedPref.saveToken(token);
        sharedPref.saveUser(response.body);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => MainScreen()));
      } else {
        var message = "Error try again";
        print(response.body);
        switch (json.decode(response.body)["message"]) {
          case "Invalid credentials":
            message = "Invalid credentials";
            break;
          case "Unauthorized":
            message = json.decode(response.body)["error"][0]["errorMessage"];
            break;
        }
        scaffoldStateKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      setState(() {
        autoValidate = true;
      });
    }
  }
}
