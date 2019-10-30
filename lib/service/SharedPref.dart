import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  String userKey = "user";
  String tokenKey = "token";

  readToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  saveToken(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(tokenKey, value);
  }

  Future<bool> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
   return prefs.remove(tokenKey);
  }

  readUser() async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(userKey));
  }

  saveUser(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(userKey, value);
  }

 Future<bool> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
   return prefs.remove(userKey);
  }
}
