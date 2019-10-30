import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:parkr/comman/CustomDialog.dart';
import 'package:parkr/service/API.dart';
import 'package:parkr/view/scan_qr_code_screen.dart';
import 'package:spring_button/spring_button.dart';
import '../model/ParkingDetails.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _vehicleTag = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  Api api = Api();
  TextEditingController _textFiledNumber1 = TextEditingController();
  TextEditingController _textFiledNumber2 = TextEditingController();
  TextEditingController _textFiledNumber3 = TextEditingController();
  TextEditingController _textFiledNumber4 = TextEditingController();
  TextEditingController _textFiledNumber5 = TextEditingController();
  TextEditingController _textFiledNumber6 = TextEditingController();
  GlobalKey<FormState> formStateOTPKey = GlobalKey<FormState>();
  bool autoValidatedOTP = false;
  bool isValidaOTP = true;
  FocusNode nodeNumber1 = FocusNode();
  FocusNode nodeNumber2 = FocusNode();
  FocusNode nodeNumber3 = FocusNode();
  FocusNode nodeNumber4 = FocusNode();
  FocusNode nodeNumber5 = FocusNode();
  FocusNode nodeNumber6 = FocusNode();
  int totalPark;
  int freeParking;
  int occupiedParking;
  StreamController<http.Response> streamController =
      StreamController<http.Response>();

  void loadingAlert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Loading"),
            ],
          ),
        );
      },
    );
  }

  void add() async {
    streamController.sink.add(await api.getDetails('in'));
  }

  void remove() async {
    streamController.sink.add(await api.getDetails('out'));
  }

  void initValue() async {
    streamController.sink.add(await api.getDetails("details"));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initValue();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldStateKey,
      backgroundColor: Color(0xff363636),
      body: StreamBuilder(
          stream: streamController.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              http.Response response = snapshot.data;
              print(response.body);
              if (response.statusCode == 200) {
                ParkingDetail parkingDetail =
                    ParkingDetail.fromJson(jsonDecode(response.body));
                totalPark = parkingDetail.data.totalParkingSlot;
                occupiedParking = parkingDetail.data.occupiedParkingSlots;
                freeParking = parkingDetail.data.freeParkingSlots;
                print("$totalPark  ==  $occupiedParking  ==  $freeParking");
                return Container(
                  margin:
                      EdgeInsets.only(top: 10, right: 18, left: 18, bottom: 5),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color(0xff363636),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xbfED2F2F), blurRadius: 5)
                              ]),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(15),
                            padding: EdgeInsets.all(15),
                            color: Color(0xffFAC758),
                            dashPattern: [6],
                            strokeWidth: 2,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              clipBehavior: Clip.antiAlias,
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "${parkingDetail.data.totalParkingSlot}",
                                      style: TextStyle(
                                          color: Color(0xefffffff),
                                          fontSize: 55,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Total Spots",
                                      style: TextStyle(
                                          color: Color(0x6fFAC758),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 255,
                                  decoration: BoxDecoration(
                                      color: Color(0xff292929),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0x7f0C2610),
                                            blurRadius: 5,
                                            spreadRadius: 1)
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                                "${parkingDetail.data.occupiedParkingSlots}",
                                                style: TextStyle(
                                                    color: Color(0xefffffff),
                                                    fontSize: 65,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            Container(
                                              alignment: Alignment.topRight,
                                              margin:
                                                  EdgeInsets.only(right: 35),
                                              child: Text("Occupied",
                                                  style: TextStyle(
                                                      color: Color(0x9f0ABC25),
                                                      fontSize: 21,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: SpringButton(
                                          SpringButtonType.OnlyScale,
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xff283425),
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20))),
                                            alignment: Alignment.center,
                                            child: Center(
                                              child: Icon(
                                                Icons.add,
                                                color: Color(0xff0ABC25),
                                                size: 70,
                                              ),
                                            ),
                                          ),
                                          onTap: () async {
                                            setState(() {
                                              if (occupiedParking >=
                                                  totalPark) {
                                                initValue();
                                                scaffoldStateKey.currentState
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "No parking place free"),
                                                  backgroundColor: Colors.red,
                                                  duration: Duration(
                                                      milliseconds: 800),
                                                ));
                                              } else {
                                                add();
                                              }
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Container(
                                  height: 255,
                                  decoration: BoxDecoration(
                                      color: Color(0xff292929),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0x5f480A0A),
                                            blurRadius: 5,
                                            spreadRadius: 1)
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                                "${parkingDetail.data.freeParkingSlots}",
                                                style: TextStyle(
                                                    color: Color(0xefffffff),
                                                    fontSize: 65,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            Container(
                                              alignment: Alignment.topRight,
                                              margin:
                                                  EdgeInsets.only(right: 35),
                                              child: Text("Free",
                                                  style: TextStyle(
                                                      color: Color(0x9fFF3B00),
                                                      fontSize: 21,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: SpringButton(
                                          SpringButtonType.WithOpacity,
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xff261E1E),
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20))),
                                            alignment: Alignment.center,
                                            child: Center(
                                              child: Icon(
                                                Icons.remove,
                                                color: Color(0xdfFF3B00),
                                                size: 70,
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                             remove();
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 25,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xffE85900),
                                    Color(0xffFAC758),
                                  ],
                                  begin: Alignment(1, 6),
                                  end: Alignment(-1, -5)),
                              borderRadius: BorderRadius.circular(30)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              dialogEnterMobile();
                              _phoneNumber.clear();
                              _vehicleTag.clear();
                              _textFiledNumber1.clear();
                              _textFiledNumber2.clear();
                              _textFiledNumber3.clear();
                              _textFiledNumber4.clear();
                              _textFiledNumber5.clear();
                              _textFiledNumber6.clear();
                              setState(() {
                               remove();
                              });
                            },
                            child: Center(
                                child: Text(
                              "₹ Create New User",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 18),
                            )),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 18,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xff0012E8),
                                    Color(0xff9058FA),
                                  ],
                                  begin: Alignment(1, 6),
                                  end: Alignment(-1, -5)),
                              borderRadius: BorderRadius.circular(30)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ScanQRCodeScreen()));
                            },
                            child: Center(
                                child: Text(
                              "Scan QR Code",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 17),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  dialogEnterMobile() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Center(
        child: CustomDialog(
          title: "Enter Mobile No.",
          subTitle: "Please enter customer Mobile No. Bellow",
          content: TextFormField(
            controller: _phoneNumber,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            decoration: InputDecoration(
                hintText: "enter your phone No",
                hintStyle: TextStyle(fontSize: 15)),
          ),
          onTapButton: () {
            if (_phoneNumber.text.isNotEmpty &&
                _phoneNumber.text.length >= 10) {
              Navigator.pop(context);
              dialogEnterVehicle();
            }
          },
          onTapText: () {
            print("Having issue?");
          },
        ),
      ),
    );
  }

  dialogEnterVehicle() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Center(
        child: CustomDialog(
          title: "Enter Vehicle No.",
          subTitle: "Please enter customer car/bike no.",
          content: TextFormField(
            controller: _vehicleTag,
            decoration: InputDecoration(hintText: "Enter car/bike no."),
          ),
          onTapButton: () {
            if (_vehicleTag.text.isNotEmpty) {
              print(_vehicleTag.text);
              print(_phoneNumber.text);
              Navigator.pop(context);
              dialogSendOTP();
            }
          },
          customLeft: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                  dialogEnterMobile();
                },
                color: Color(0xffFAC758),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19)),
                child: Text(
                  "Back",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              InkWell(
                  onTap: () {},
                  child: Text(
                    "Having issue?",
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.7), fontSize: 12),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  dialogSendOTP() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Center(
        child: CustomDialog(
          title: "Send OTP",
          subTitle: "Send OTP to confirm with customer",
          content: Column(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                color: Colors.green,
                size: 66,
              ),
              Text(
                "!New Customer click send OTP",
                style: TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          ),
          textButton: "Send OTP",
          onTapButton: () {
            print("Send OTP");
            print(_vehicleTag.text + _phoneNumber.text);
            api
                .registerUser(_phoneNumber.text, _vehicleTag.text)
                .then((responses) {
              http.Response response = responses;
              if (response.statusCode == 200) {
                print("succes");
                print(response.body);
                Navigator.pop(context);
                dialogVerifyOTP();
              } else {}
            });
          },
          customLeft: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                  dialogEnterVehicle();
                },
                color: Color(0xffFAC758),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19)),
                child: Text(
                  "Back",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                  onTap: () {},
                  child: Text(
                    "Having issue?",
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.7), fontSize: 12),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  dialogVerifyOTP() {
    _textFiledNumber1.clear();
    _textFiledNumber2.clear();
    _textFiledNumber3.clear();
    _textFiledNumber4.clear();
    _textFiledNumber5.clear();
    _textFiledNumber6.clear();
    String number1;
    String number2;
    String number3;
    String number4;
    String number5;
    String number6;
    var padding = const EdgeInsets.all(1.5);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          StatefulBuilder(builder: (context, setStateLocal) {
        return CustomDialog(
          title: "Verify OTP",
          subTitle: "Please enter the OTP Bellow for Verification",
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: formStateOTPKey,
                autovalidate: autoValidatedOTP,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: padding,
                        child: TextFormField(
                          focusNode: nodeNumber1,
                          controller: _textFiledNumber1,
                          style: TextStyle(fontSize: 25),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              counterText: "",
                              contentPadding: EdgeInsets.all(15)),
                          onFieldSubmitted: (term) {
                            if (term.isNotEmpty) {
                              setState(() {
                                FocusScope.of(context)
                                    .requestFocus(nodeNumber2);
                              });
                            }
                          },
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              FocusScope.of(context).requestFocus(nodeNumber2);
                              _textFiledNumber2.clear();
                            }
                          },
                          onSaved: (value) {
                            setState(() {
                              number1 = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) return "*";

                            return null;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: padding,
                        child: TextFormField(
                          focusNode: nodeNumber2,
                          controller: _textFiledNumber2,
                          style: TextStyle(fontSize: 25),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              counterText: "",
                              contentPadding: EdgeInsets.all(15)),
                          onFieldSubmitted: (term) {
                            if (term.isNotEmpty)
                              FocusScope.of(context).requestFocus(nodeNumber3);
                          },
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              FocusScope.of(context).requestFocus(nodeNumber3);
                              _textFiledNumber3.clear();
                            }
                          },
                          onSaved: (value) {
                            setState(() {
                              number2 = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) return "*";

                            return null;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: padding,
                        child: TextFormField(
                          focusNode: nodeNumber3,
                          controller: _textFiledNumber3,
                          style: TextStyle(fontSize: 25),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              counterText: "",
                              contentPadding: EdgeInsets.all(15)),
                          onFieldSubmitted: (term) {
                            if (term.isNotEmpty)
                              FocusScope.of(context).requestFocus(nodeNumber4);
                          },
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              FocusScope.of(context).requestFocus(nodeNumber4);
                              _textFiledNumber4.clear();
                            }
                          },
                          onSaved: (value) {
                            setState(() {
                              number3 = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) return "*";

                            return null;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: padding,
                        child: TextFormField(
                          focusNode: nodeNumber4,
                          controller: _textFiledNumber4,
                          style: TextStyle(fontSize: 25),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              counterText: "",
                              contentPadding: EdgeInsets.all(15)),
                          onFieldSubmitted: (term) {
                            if (term.isNotEmpty)
                              FocusScope.of(context).requestFocus(nodeNumber5);
                          },
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              FocusScope.of(context).requestFocus(nodeNumber5);
                              _textFiledNumber5.clear();
                            }
                          },
                          onSaved: (value) {
                            setState(() {
                              number4 = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) return "*";

                            return null;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: padding,
                        child: TextFormField(
                          focusNode: nodeNumber5,
                          controller: _textFiledNumber5,
                          style: TextStyle(fontSize: 25),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              counterText: "",
                              contentPadding: EdgeInsets.all(15)),
                          onFieldSubmitted: (term) {
                            if (term.isNotEmpty)
                              FocusScope.of(context).requestFocus(nodeNumber6);
                          },
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              FocusScope.of(context).requestFocus(nodeNumber6);
                              _textFiledNumber6.clear();
                            }
                          },
                          onSaved: (value) {
                            setState(() {
                              number5 = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) return "*";

                            return null;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: padding,
                        child: TextFormField(
                          focusNode: nodeNumber6,
                          controller: _textFiledNumber6,
                          style: TextStyle(fontSize: 25),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              counterText: "",
                              contentPadding: EdgeInsets.all(15)),
                          onFieldSubmitted: (term) {},
                          onSaved: (value) {
                            setState(() {
                              number6 = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) return "*";

                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTapButton: () {
            if (formStateOTPKey.currentState.validate()) {
              formStateOTPKey.currentState.save();
              String otp = "$number1$number2$number3$number4$number5$number6";
              api.verify(_phoneNumber.text, otp).then((responses) {
                http.Response response = responses;
                if (response.statusCode == 200) {
                  String status = json.decode(response.body)["status"];
                  String message = json.decode(response.body)["message"];
                  if (status == "success") {
                    dialogSuccess();
                  } else {
                    setStateLocal(() {
                      isValidaOTP = false;
                      print(isValidaOTP);
                    });
                  }
                  print(status);
                }
              });
            } else {
              setState(() {
                autoValidatedOTP = true;
              });
            }
          },
          textButton: "Submit",
          colorButton: Color(0xcf0ABC25),
          colorTextButton: Colors.white.withOpacity(0.8),
          customLeft: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                  dialogEnterVehicle();
                },
                color: Color(0xffFAC758),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19)),
                child: Text(
                  "Back",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                  onTap: () {},
                  child: Text(
                    "Having issue?",
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.7), fontSize: 12),
                  )),
              Visibility(
                visible: !isValidaOTP,
                child: FlatButton(
                  padding: EdgeInsets.all(1),
                  onPressed: () {
                    setStateLocal(() {
                      isValidaOTP = true;
                    });
                    api
                        .registerUser(_phoneNumber.text, _vehicleTag.text)
                        .then((responses) {
                      http.Response response = responses;
                      if (response.statusCode == 200) {
                        print("succes");
                        print(response.body);
                        Navigator.pop(context);
                        dialogVerifyOTP();
                      } else {}
                    });
                  },
                  child: Text(
                    "Resend OTP",
                    style: TextStyle(
                        color: Colors.orange.withOpacity(0.7),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  dialogSuccess() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => Center(
        child: CustomDialog(
          title: "Success",
          subTitle: "User added ",
          content: Icon(
            Icons.done,
            color: Colors.green,
            size: 100,
          ),
          onTapButton: () {
            Navigator.pop(context);
          },
          colorButton: Color(0xdfFF3B00),
          textButton: "Close",
          colorTextButton: Colors.white,
          customLeft: Container(),
        ),
      ),
    );
  }
}
