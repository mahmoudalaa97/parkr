import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkr/comman/CardBookingDetails.dart';
import 'package:parkr/model/TicketDetails.dart';
import 'package:parkr/service/API.dart';
import 'package:http/http.dart'as http;

class TicketDetailsScreen extends StatefulWidget {
  final String bookingId;

  const TicketDetailsScreen({Key key, this.bookingId}) : super(key: key);
  @override
  _TicketDetailsScreenState createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  GlobalKey<ScaffoldState> scaffoldStateKey=GlobalKey<ScaffoldState>();
  Api api =Api();
  String paymentState = "paid";
  int selectedPaymentState=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldStateKey,
      backgroundColor: Color(0xff363636),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              top: 40,
              bottom: 0,
              child: FutureBuilder(
                future: api.getTicketDetails(widget.bookingId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    http.Response response = snapshot.data;
                    if (response.statusCode == 200) {
                      TicketDetails ticketDetails = TicketDetails.fromJson(response.body);
                      return ListView(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Stack(
                                fit: StackFit.passthrough,
                                children: <Widget>[
                                  Container(
                                    height: 730,
                                  ),
                                  Container(
                                    height: 360,
                                    decoration: BoxDecoration(
                                        color: Color(0xff291527),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(21),
                                            bottomRight: Radius.circular(21))),
                                  ),
                                  CardBookingDetails(
                                    ticketDetails: ticketDetails,
                                  ),
                                  Positioned(
                                    top: 375,
                                    left: 20,
                                    right: 20,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      padding: EdgeInsets.only(
                                          left: 25, right: 25, top: 25),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          rowItem(
                                              title: "Booking Amount",
                                              content:
                                              "₹ ${ticketDetails.data.payableAmount}"),
                                          rowItem(
                                              title: "Exceed Amount",
                                              content:
                                              "₹ ${ticketDetails.data.extraAmount}"),
                                          rowItem(
                                              title: "Payment Date",
                                              content:
                                              "${ticketDetails.data.bookingRequest.paymentInfo.length>0?DateFormat("yyyy-MM-dd").format(ticketDetails.data.bookingRequest.paymentInfo[0].paymentDate):""}"),
                                          rowItem(
                                              title: "Grand Total",
                                              content:
                                              "₹ ${(ticketDetails.data.payableAmount + ticketDetails.data.extraAmount)}"),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 341,
                                    left: 40,
                                    right:40,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xff0ABC25),
                                          borderRadius:
                                          BorderRadius.circular(25)),
                                      height: 45,
                                      padding:
                                      EdgeInsets.only(left: 20, right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Member",
                                            style: TextStyle(
                                                color: Color(0xef3E3E3E),
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            "${ticketDetails.data.member.memberName}",
                                            style: TextStyle(
                                                color: Color(0xbf000000),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,left: 20,right: 20
                                    ,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            InkWell(
                                              borderRadius: BorderRadius.circular(20),
                                              onTap:(){
                                                setState(() {
                                                  selectedPaymentState=0;
                                                  paymentState="paid";
                                                });
                                              },
                                              child: Container(
                                                width: 110,
                                                height: selectedPaymentState==0?40:38,

                                                decoration: selectedPaymentState==0?BoxDecoration(
                                                    color: Color(0xffFF5421),
                                                    borderRadius:
                                                    BorderRadius.circular(20)):BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(20),
                                                    border: Border.all(
                                                        color: Colors.grey, width: 3)),
                                                child: Center(
                                                  child: Text(
                                                    "Cash Recevied",
                                                    style: selectedPaymentState==0?TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w600):TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            InkWell(
                                              borderRadius: BorderRadius.circular(20),
                                              onTap:null,
                                              child: Container(
                                                width: 110,
                                                height: selectedPaymentState==1?40:38,
                                                decoration: selectedPaymentState==0?BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(20),
                                                    border: Border.all(
                                                        color: Colors.grey, width: 3)):BoxDecoration(
                                                    color: Color(0xffFF5421),
                                                    borderRadius:
                                                    BorderRadius.circular(20)),
                                                child: Center(
                                                  child: Text(
                                                    "Pay Later",
                                                    style: selectedPaymentState==0?TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.w600):TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: RaisedButton(
                                            onPressed: ticketDetails.data.bookingRequest.status=="booked"||ticketDetails.data.bookingRequest.status=="check-in"?() {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text('Sure to checkout?'),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                            onPressed: () {
                                                             Navigator.pop(context);
                                                            },
                                                            child: Text('Close')),
                                                        FlatButton(
                                                          onPressed: () {
                                                            api.checkOut(
                                                                ticketDetails.data.bookingRequest
                                                                    .bookingId,
                                                                paymentState)
                                                                .then((responses) {
                                                                  Navigator.pop(context);
                                                                  if(responses.statusCode==200){
                                                                    String message=json.decode(responses.body)["message"];
                                                                    api.getDetails("out");
//                                                                    String current_status=json.decode(responses.body)["current_status"];
                                                                    showDialogAlert(message, Colors.green);
                                                                  }
                                                              if(responses.statusCode==422){
                                                                String message=json.decode(responses.body)["message"];
                                                                int status=json.decode(responses.body)["status"];
                                                                print(message);
                                                                print(status.toString());
//                                                                scaffoldStateKey.currentState.showSnackBar(SnackBar(content: Text("$message",style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,),
//                                                              );
                                                              showDialogAlert(message, Colors.red);
                                                              }

                                                            });
                                                          },
                                                          child: Text('Yes'),
                                                        )
                                                      ],
                                                    );
                                                  });

                                            }:null,
                                            color: Color(0xffFAC758),
                                            child: Text(
                                              "Click to Check Out",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(25)),
                                            padding: EdgeInsets.all(12),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            "Please Try agin",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      );
                    }
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
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
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 28,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10, bottom: 5),
                          child: Text(
                            "Ticket Details",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
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
            ),
          ],
        ),
      ),
    );
  }

void showDialogAlert(String message,Color color){
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content:Text("$message",style: TextStyle(color: color),),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close')),
          ],
        );
      });
}
  rowItem({String title, String content}) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "$title",
              style: TextStyle(
                  color: Color(0x9f000000), fontWeight: FontWeight.w700),
            ),
            Text(
              "$content",
              style: TextStyle(
                  color: Color(0xff000000), fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Divider(
          height: 28,
          color: Color(0xff707070),
        ),
      ],
    );
  }
}
