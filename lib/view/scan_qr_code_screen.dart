import 'dart:async';
import 'dart:convert';

import 'package:parkr/comman/CardBookingDetails.dart';
import 'package:parkr/model/TicketDetails.dart';
import 'package:parkr/service/API.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../service/SharedPref.dart';
import 'package:intl/intl.dart';

import 'main_screen.dart';
import '../model/ParkingDetails.dart';

class ScanQRCodeScreen extends StatefulWidget {
  @override
  _ScanQRCodeScreenState createState() => _ScanQRCodeScreenState();
}

class _ScanQRCodeScreenState extends State<ScanQRCodeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  var qrText = "";
  SharedPref sharedPref = SharedPref();
  QRViewController controller;
  TextEditingController bookingId = TextEditingController();
  Api api = Api();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldStateKey,
      backgroundColor: Color(0xff363636),
      appBar: AppBar(
        backgroundColor: Color(0xff363636),
        centerTitle: true,
        title: Text("Scan QR"),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 300,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.flash_on,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            controller.toggleFlash();
                          }),
                      Text(
                        "Flash",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  width: 300,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white54)),
                  child: QRView(
                    key: qrKey,
                    overlay: RoundedRectangleBorder(),
                    onQRViewCreated: _onQRViewCreated,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: 300,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: bookingId,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter Booking Id Munaualy ",
                          labelText: "Booking_ID",
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 18,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xff0012E8),
                              Color(0xff9058FA),
                            ], begin: Alignment(1, 6), end: Alignment(-1, -5)),
                            borderRadius: BorderRadius.circular(30)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: _checkIn,
                          child: Center(
                              child: Text(
                            "Check In",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 17),
                          )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _checkIn() async {
    if (bookingId.text.isNotEmpty) {
      http.Response response = await api.checkIn(bookingId.text);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        var message = json.decode(response.body)["message"];
        var currentStatus = json.decode(response.body)["current_status"];
        if (currentStatus == "system-rejected") {
          scaffoldStateKey.currentState.showSnackBar(SnackBar(
            content: Text(
              "$message",
            ),
            backgroundColor: Colors.red,
          ));
        } else if (currentStatus == "check-in") {    http.Response responseDetails = await api.getDetails("in");
        print(responseDetails.body);
        String messagePark = json.decode(responseDetails.body)["message"];
        int statusPark = json.decode(responseDetails.body)["status"];
          if (statusPark != 404) {
            scaffoldStateKey.currentState.showSnackBar(SnackBar(
              content: Text(
                "$message",
              ),
              backgroundColor: Colors.green,
            ));
            Timer(Duration(seconds: 1), () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => MainScreen()));
            });
          } else {
            scaffoldStateKey.currentState.showSnackBar(SnackBar(
              content: Text(
                "$messagePark",
              ),
              backgroundColor: Colors.red,
            ));
          }
        }
      } else if (response.statusCode == 422) {
        var message = json.decode(response.body)["message"];
        scaffoldStateKey.currentState.showSnackBar(SnackBar(
          content: Text(
            "$message",
          ),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      scaffoldStateKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "plase enter booking id or scan QR",
        ),
      ));
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      bookingId.text = scanData;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
