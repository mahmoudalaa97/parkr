class ParkingDetail {
  int status;
  String message;
  Data data;

  ParkingDetail({this.status, this.message, this.data});

  ParkingDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['parking_details'] != null
        ? new Data.fromJson(json['parking_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['parking_details'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  int locationId;
  int vehicleTypeId;
  int totalParkingSlot;
  int freeParkingSlots;
  int occupiedParkingSlots;
  int chargesPerHour;
  int chargesPerDay;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.locationId,
        this.vehicleTypeId,
        this.totalParkingSlot,
        this.freeParkingSlots,
        this.occupiedParkingSlots,
        this.chargesPerHour,
        this.chargesPerDay,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationId = json['location_id'];
    vehicleTypeId = json['vehicle_type_id'];
    totalParkingSlot = json['total_parking_slot'];
    freeParkingSlots = json['free_parking_slots'];
    occupiedParkingSlots = json['occupied_parking_slots'];
    chargesPerHour = json['charges_per_hour'];
    chargesPerDay = json['charges_per_day'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location_id'] = this.locationId;
    data['vehicle_type_id'] = this.vehicleTypeId;
    data['total_parking_slot'] = this.totalParkingSlot;
    data['free_parking_slots'] = this.freeParkingSlots;
    data['occupied_parking_slots'] = this.occupiedParkingSlots;
    data['charges_per_hour'] = this.chargesPerHour;
    data['charges_per_day'] = this.chargesPerDay;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
