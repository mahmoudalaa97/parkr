// To parse this JSON data, do
//
//     final ticketDetails = ticketDetailsFromJson(jsonString);

import 'dart:convert';

class TicketDetails {
  final Data data;

  TicketDetails({
    this.data,
  });

  factory TicketDetails.fromJson(String str) => TicketDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketDetails.fromMap(Map<String, dynamic> json) => TicketDetails(
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : data.toMap(),
  };
}

class Data {
  final Member member;
  final BookingRequest bookingRequest;
  final String currentStatus;
  final int payableAmount;
  final int paidAmount;
  final String extraTime;
  final int extraAmount;

  Data({
    this.member,
    this.bookingRequest,
    this.currentStatus,
    this.payableAmount,
    this.paidAmount,
    this.extraTime,
    this.extraAmount,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    member: json["member"] == null ? null : Member.fromMap(json["member"]),
    bookingRequest: json["booking_request"] == null ? null : BookingRequest.fromMap(json["booking_request"]),
    currentStatus: json["current_status"] == null ? null : json["current_status"],
    payableAmount: json["payableAmount"] == null ? null : json["payableAmount"],
    paidAmount: json["paid_amount"] == null ? null : json["paid_amount"],
    extraTime: json["extra_time"] == null ? null : json["extra_time"],
    extraAmount: json["extra_amount"] == null ? null : json["extra_amount"],
  );

  Map<String, dynamic> toMap() => {
    "member": member == null ? null : member.toMap(),
    "booking_request": bookingRequest == null ? null : bookingRequest.toMap(),
    "current_status": currentStatus == null ? null : currentStatus,
    "payableAmount": payableAmount == null ? null : payableAmount,
    "paid_amount": paidAmount == null ? null : paidAmount,
    "extra_time": extraTime == null ? null : extraTime,
    "extra_amount": extraAmount == null ? null : extraAmount,
  };
}

class BookingRequest {
  final String bookingId;
  final DateTime reqDate;
  final DateTime reqStartTime;
  final DateTime reqEndTime;
  final String paymentStatus;
  final String status;
  final List<PaymentInfo> paymentInfo;

  BookingRequest({
    this.bookingId,
    this.reqDate,
    this.reqStartTime,
    this.reqEndTime,
    this.paymentStatus,
    this.status,
    this.paymentInfo,
  });

  factory BookingRequest.fromJson(String str) => BookingRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookingRequest.fromMap(Map<String, dynamic> json) => BookingRequest(
    bookingId: json["booking_id"] == null ? null : json["booking_id"],
    reqDate: json["req_date"] == null ? null : DateTime.parse(json["req_date"]),
    reqStartTime: json["req_start_time"] == null ? null : DateTime.parse(json["req_start_time"]),
    reqEndTime: json["req_end_time"] == null ? null : DateTime.parse(json["req_end_time"]),
    paymentStatus: json["payment_status"] == null ? null : json["payment_status"],
    status: json["status"] == null ? null : json["status"],
    paymentInfo: json["payment_info"] == null ? null : List<PaymentInfo>.from(json["payment_info"].map((x) => PaymentInfo.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "booking_id": bookingId == null ? null : bookingId,
    "req_date": reqDate == null ? null : "${reqDate.year.toString().padLeft(4, '0')}-${reqDate.month.toString().padLeft(2, '0')}-${reqDate.day.toString().padLeft(2, '0')}",
    "req_start_time": reqStartTime == null ? null : reqStartTime.toIso8601String(),
    "req_end_time": reqEndTime == null ? null : reqEndTime.toIso8601String(),
    "payment_status": paymentStatus == null ? null : paymentStatus,
    "status": status == null ? null : status,
    "payment_info": paymentInfo == null ? null : List<dynamic>.from(paymentInfo.map((x) => x.toMap())),
  };
}

class PaymentInfo {
  final String paymentStatus;
  final String paymentMode;
  final int amount;
  final DateTime paymentDate;
  final String status;

  PaymentInfo({
    this.paymentStatus,
    this.paymentMode,
    this.amount,
    this.paymentDate,
    this.status,
  });

  factory PaymentInfo.fromJson(String str) => PaymentInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentInfo.fromMap(Map<String, dynamic> json) => PaymentInfo(
    paymentStatus: json["payment_status"] == null ? null : json["payment_status"],
    paymentMode: json["payment_mode"] == null ? null : json["payment_mode"],
    amount: json["amount"] == null ? null : json["amount"],
    paymentDate: json["payment_date"] == null ? null : DateTime.parse(json["payment_date"]),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toMap() => {
    "payment_status": paymentStatus == null ? null : paymentStatus,
    "payment_mode": paymentMode == null ? null : paymentMode,
    "amount": amount == null ? null : amount,
    "payment_date": paymentDate == null ? null : paymentDate.toIso8601String(),
    "status": status == null ? null : status,
  };
}

class Member {
  final String memberName;
  final String memberEmail;
  final int memberMobileNo;
  final String vehicleType;
  final String reqRegNo;
  final OutstandingInfo outstandingInfo;

  Member({
    this.memberName,
    this.memberEmail,
    this.memberMobileNo,
    this.vehicleType,
    this.reqRegNo,
    this.outstandingInfo,
  });

  factory Member.fromJson(String str) => Member.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Member.fromMap(Map<String, dynamic> json) => Member(
    memberName: json["member_name"] == null ? null : json["member_name"],
    memberEmail: json["member_email"] == null ? null : json["member_email"],
    memberMobileNo: json["member_mobile_no"] == null ? null : json["member_mobile_no"],
    vehicleType: json["vehicle_type"] == null ? null : json["vehicle_type"],
    reqRegNo: json["req_reg_no"] == null ? null : json["req_reg_no"],
    outstandingInfo: json["outstanding_info"] == null ? null : OutstandingInfo.fromMap(json["outstanding_info"]),
  );

  Map<String, dynamic> toMap() => {
    "member_name": memberName == null ? null : memberName,
    "member_email": memberEmail == null ? null : memberEmail,
    "member_mobile_no": memberMobileNo == null ? null : memberMobileNo,
    "vehicle_type": vehicleType == null ? null : vehicleType,
    "req_reg_no": reqRegNo == null ? null : reqRegNo,
    "outstanding_info": outstandingInfo == null ? null : outstandingInfo.toMap(),
  };
}

class OutstandingInfo {
  OutstandingInfo();

  factory OutstandingInfo.fromJson(String str) => OutstandingInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OutstandingInfo.fromMap(Map<String, dynamic> json) => OutstandingInfo(
  );

  Map<String, dynamic> toMap() => {
  };
}
