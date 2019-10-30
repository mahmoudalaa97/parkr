// To parse this JSON data, do
//
//     final reportDetails = reportDetailsFromJson(jsonString);

import 'dart:convert';

class ReportDetails {
  final int currentPage;
  final List<Datum> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final dynamic nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;

  ReportDetails({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory ReportDetails.fromJson(String str) => ReportDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReportDetails.fromMap(Map<String, dynamic> json) => ReportDetails(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
    from: json["from"] == null ? null : json["from"],
    lastPage: json["last_page"] == null ? null : json["last_page"],
    lastPageUrl: json["last_page_url"] == null ? null : json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"] == null ? null : json["path"],
    perPage: json["per_page"] == null ? null : json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"] == null ? null : json["to"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage == null ? null : currentPage,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
    "first_page_url": firstPageUrl == null ? null : firstPageUrl,
    "from": from == null ? null : from,
    "last_page": lastPage == null ? null : lastPage,
    "last_page_url": lastPageUrl == null ? null : lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path == null ? null : path,
    "per_page": perPage == null ? null : perPage,
    "prev_page_url": prevPageUrl,
    "to": to == null ? null : to,
    "total": total == null ? null : total,
  };
}

class Datum {
  final String memberName;
  final String memberEmail;
  final int memberMobileNo;
  final DateTime reqDate;
  final DateTime reqStartTime;
  final DateTime reqEndTime;
  final String reqStatus;
  final dynamic reqCheckInTime;
  final dynamic reqCheckOutTime;
  final dynamic reqAllocatedSlot;
  final DateTime reqDatetime;
  final String bookingId;
  final String reqPaymentStatus;
  final int vehicleTypeId;
  final int id;
  final String locationName;
  final int locationId;
  final String reqRegNo;

  Datum({
    this.memberName,
    this.memberEmail,
    this.memberMobileNo,
    this.reqDate,
    this.reqStartTime,
    this.reqEndTime,
    this.reqStatus,
    this.reqCheckInTime,
    this.reqCheckOutTime,
    this.reqAllocatedSlot,
    this.reqDatetime,
    this.bookingId,
    this.reqPaymentStatus,
    this.vehicleTypeId,
    this.id,
    this.locationName,
    this.locationId,
    this.reqRegNo,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    memberName: json["member_name"] == null ? null : json["member_name"],
    memberEmail: json["member_email"] == null ? null : json["member_email"],
    memberMobileNo: json["member_mobile_no"] == null ? null : json["member_mobile_no"],
    reqDate: json["req_date"] == null ? null : DateTime.parse(json["req_date"]),
    reqStartTime: json["req_start_time"] == null ? null : DateTime.parse(json["req_start_time"]),
    reqEndTime: json["req_end_time"] == null ? null : DateTime.parse(json["req_end_time"]),
    reqStatus: json["req_status"] == null ? null : json["req_status"],
    reqCheckInTime: json["req_check_in_time"],
    reqCheckOutTime: json["req_check_out_time"],
    reqAllocatedSlot: json["req_allocated_slot"],
    reqDatetime: json["req_datetime"] == null ? null : DateTime.parse(json["req_datetime"]),
    bookingId: json["booking_id"] == null ? null : json["booking_id"],
    reqPaymentStatus: json["req_payment_status"] == null ? null : json["req_payment_status"],
    vehicleTypeId: json["vehicle_type_id"] == null ? null : json["vehicle_type_id"],
    id: json["id"] == null ? null : json["id"],
    locationName: json["location_name"] == null ? null : json["location_name"],
    locationId: json["location_id"] == null ? null : json["location_id"],
    reqRegNo: json["req_reg_no"] == null ? null : json["req_reg_no"],
  );

  Map<String, dynamic> toMap() => {
    "member_name": memberName == null ? null : memberName,
    "member_email": memberEmail == null ? null : memberEmail,
    "member_mobile_no": memberMobileNo == null ? null : memberMobileNo,
    "req_date": reqDate == null ? null : "${reqDate.year.toString().padLeft(4, '0')}-${reqDate.month.toString().padLeft(2, '0')}-${reqDate.day.toString().padLeft(2, '0')}",
    "req_start_time": reqStartTime == null ? null : reqStartTime.toIso8601String(),
    "req_end_time": reqEndTime == null ? null : reqEndTime.toIso8601String(),
    "req_status": reqStatus == null ? null : reqStatus,
    "req_check_in_time": reqCheckInTime,
    "req_check_out_time": reqCheckOutTime,
    "req_allocated_slot": reqAllocatedSlot,
    "req_datetime": reqDatetime == null ? null : reqDatetime.toIso8601String(),
    "booking_id": bookingId == null ? null : bookingId,
    "req_payment_status": reqPaymentStatus == null ? null : reqPaymentStatus,
    "vehicle_type_id": vehicleTypeId == null ? null : vehicleTypeId,
    "id": id == null ? null : id,
    "location_name": locationName == null ? null : locationName,
    "location_id": locationId == null ? null : locationId,
    "req_reg_no": reqRegNo == null ? null : reqRegNo,
  };
}
