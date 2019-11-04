import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkr/model/ReportDetails.dart';
import 'package:parkr/service/SharedPref.dart';
import 'package:http/http.dart' as http;
import 'ticket_details_screen.dart';
// ignore: must_be_immutable
class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  double maxWidth;

  SharedPref sharedPref = SharedPref();

 StreamController<http.Response> streamController=StreamController<http.Response>();

  void getReportDetails(int input) async {
    String token = await sharedPref.readToken();
    print(token);
    var response;
    response = http.get("http://api.staging.parkr.in/agents/bookings",
        headers: {
          "Authorization": "$token",
          "page":"$input",
        });
   streamController.add(await response);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReportDetails(1);
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamController.close();
  }
  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;
    return StreamBuilder(
      stream: streamController.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          http.Response response = snapshot.data;
          if (response.statusCode == 200) {
            ReportDetails reportDetails = ReportDetails.fromJson(response.body);
            return Container(
              margin: EdgeInsets.only(top: 11),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        itemCount: reportDetails.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(left: 18, right: 18, bottom: 11),
                            padding: EdgeInsets.only(left: 20, top: 8, bottom: 7),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: InkWell(
                              onTap: () {
                                print("card{$index}");
                                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>TicketDetailsScreen(bookingId: reportDetails.data[index].bookingId,)));
                              },
                              child: Column(
                                children: <Widget>[
                                  rowText(title: "Name:", content: reportDetails.data[index].memberName),
                                  rowText(
                                      title: "Booking id :",
                                      content: reportDetails.data[index].bookingId),
                                  rowText(title: "Reg. No. :", content: reportDetails.data[index].reqRegNo),
                                  rowText(
                                      title: "Time :",
                                      content: "${DateFormat("hh:mm a").format(reportDetails.data[index].reqStartTime)} to ${DateFormat("hh:mm a").format(reportDetails.data[index].reqEndTime)}"),
                                  rowText(
                                      title: "Booked on :", content: "${DateFormat("yyyy-M-d").format(reportDetails.data[index].reqDate)}"),
                                  rowText(
                                      title: "Status :", content: reportDetails.data[index].reqStatus),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Opacity(
                            opacity: 1==reportDetails.currentPage?0:1,
                            child: RaisedButton(onPressed: (){
                              getReportDetails(reportDetails.currentPage-1);
                            },child: Text("Previos Page",style: TextStyle(color: Colors.black.withOpacity(0.8)),),color: Color(0xffFAC758),)),
                        Opacity(
                            opacity: reportDetails.currentPage==reportDetails.lastPage?0:1,
                            child: RaisedButton(onPressed: (){
                       getReportDetails(reportDetails.currentPage+1);
                            },child: Text("Next Page",style: TextStyle(color: Colors.black.withOpacity(0.8)),),color: Color(0xffFAC758),)),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  rowText({String title, String content}) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
                color: Color(0x8f000000), fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            content,
            style: TextStyle(
                color: Color(0xff000000), fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
