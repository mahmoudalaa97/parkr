import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:parkr/model/TicketDetails.dart';
class CardBookingDetails extends StatelessWidget {
  final TicketDetails ticketDetails;

  const CardBookingDetails({Key key, this.ticketDetails}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      padding: EdgeInsets.only(
          top: 30, left: 22, right: 22, bottom: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Booking ID",
                    style: TextStyle(
                        color: Colors.white38,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  Text(
                    "${ticketDetails.data.bookingRequest.bookingId}",
                    style: TextStyle(
                        color: Color(0xffFAC758),
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 7,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(5)),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "${DateFormat("d EEE").format(DateTime.now())}",
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.w700,
                                      fontSize: 13),
                                ),
                                Text(
                                  "${DateFormat("MMM d").format(DateTime.now())}",
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: -13,
                          left: 35,
                          right: 4,
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                          ),
                        ),
                        Positioned(
                          top: -13,
                          left: 4,
                          right: 35,
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 50,
                    width: 70,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 0,
                          left: 5,
                          right: 4,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff893D26),
                                borderRadius:
                                BorderRadius.circular(5)),
                            width: 68,
                            height: 40,
                          ),
                        ),
                        Positioned(
                          top: 7,
                          left: 0,
                          right: 0,
                          bottom: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(5)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "${DateFormat("hh:mm").format(DateTime.now())}",
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                  Align(
                                    alignment:
                                    Alignment.centerLeft,
                                    child: Text(
                                      "${DateFormat("a").format(ticketDetails.data.bookingRequest.reqDate)}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight:
                                          FontWeight.w700,
                                          fontSize: 8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DottedBorder(
                    borderType: BorderType.RRect,
                    child: Container(
                      child: Image.asset(
                        "assets/car.png",
                      ),
                    ),
                    color: Colors.grey,
                    radius: Radius.circular(50),
                    padding: EdgeInsets.all(20),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "Reg No: ${ticketDetails.data.member.reqRegNo}",
                    style: TextStyle(
                        color: Color(0xffFAC758),
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                ],
              ),

            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Start",
                    style: TextStyle(
                        color: Color(0x5f0ABC25),
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${DateFormat("hh: mm a").format(ticketDetails.data.bookingRequest.reqStartTime)}",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${DateFormat("dEE MMM yyyy").format(ticketDetails.data.bookingRequest.reqStartTime)}",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.3),
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "₹",
                    style: TextStyle(
                        color: Color(0xffFAC758),
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "${ticketDetails.data.payableAmount}",
                    style: TextStyle(
                        color: Color(0xffFAC758),
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "End",
                    style: TextStyle(
                        color: Color(0x5fFF5421),
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${DateFormat("hh: mm a").format(ticketDetails.data.bookingRequest.reqEndTime)}",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${DateFormat("dEE MMM yyyy").format(ticketDetails.data.bookingRequest.reqEndTime)}",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.3),
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
