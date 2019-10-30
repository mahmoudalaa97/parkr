import 'dart:io';

import 'package:parkr/model/user.dart';

import 'SharedPref.dart';
import 'package:http/http.dart' as http;
class Api{
  SharedPref sharedPref = SharedPref();

  Future<http.Response> login(String _email,String _password) async {

    var response = await http.post("https://api.parkr.in/login", body: {
      "email": _email,
      "password": _password,
      "device_token":
      "crZdmJykKNI:APA91bFr2UTKavOnyzTUZicnTXW1spINA8MOQs5-pYIvpt0TN66jFBHWgeg13_sax4MM1HysMXsas_vaNIIOVh3GJaEnZ18ZRVRj8jaq2x6JGIJ4S591BZPoxvG2ndB-IMPSVsDI_ggJ"
    }, headers: {
      "deviceType": Platform.isAndroid?"android":Platform.isIOS?"ios":"",
      "deviceId": "parkerDevice${DateTime.now().millisecondsSinceEpoch}",
      "Content-Type": "application/x-www-form-urlencoded"
    });
    return response;
  }
  Future<http.Response> getDetails(String input) async {
    String token = await sharedPref.readToken();
    return await http.post("https://api.parkr.in/locations/parking-details", body: {
      "flag": "$input",
    }, headers: {
      "Authorization": "$token",
      "Content-Type": "application/x-www-form-urlencoded"
    });

  }

  Future<dynamic> registerUser(String mobileNo, String vehicleNo) async {
    String token = await sharedPref.readToken();
    var response;

    response = http.post("http://api.staging.parkr.in/guest/register",
        body: {
          "mobile_no": "$mobileNo",
          "vehicle_no": "$vehicleNo"
        },
        headers: {
          "Authorization": "$token",
          "Content-Type": "application/x-www-form-urlencoded"
        });
    return response;
  }

  Future<dynamic> verify(String mobileNo, String otp) async {
    User  user=User.fromJson(await sharedPref.readUser());
    print("User location=${user.data.placeName}");
    String token = await sharedPref.readToken();
    var response;

    response = http.post(
        "http://api.staging.parkr.in/guest/verify?mobile_no=$mobileNo&location_id=${user.data.placeName}&otp=$otp",
        headers: {
          "Authorization": "$token",
        });
    return response;
  }

  Future<http.Response> getTicketDetails(String input) async {
    String token = await sharedPref.readToken();
    print(token);
    var response;
    response = http.get("https://api.parkr.in/agents/bookings/$input",
        headers: {
          "Authorization": "$token",
          "Content-Type": "application/x-www-form-urlencoded"
        });
    return response;
  }

  Future<http.Response> checkOut(String bookingID, String paymentState) async {
    String token = await sharedPref.readToken();
    print(token);
    Future<http.Response> response;
    response = http.post("https://api.parkr.in/agents/checkout", body: {
      "booking_id": "$bookingID",
      "payment_status": "$paymentState"
    }, headers: {
      "Authorization": "$token",
      "Content-Type": "application/x-www-form-urlencoded"
    });
    return response;
  }
  Future<http.Response> checkIn(String bookingID) async {
    String token = await sharedPref.readToken();
    print(token);
    Future<http.Response> response;
    response = http.post("https://api.parkr.in/agents/check-in", body: {
      "booking_id": "$bookingID",
    }, headers: {
      "Authorization": "$token",
      "Content-Type": "application/x-www-form-urlencoded"
    });
    return response;
  }
}