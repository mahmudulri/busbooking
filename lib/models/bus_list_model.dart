import 'dart:convert';

BusListModel busListModelFromJson(String str) =>
    BusListModel.fromJson(json.decode(str));

String busListModelToJson(BusListModel data) => json.encode(data.toJson());

class BusListModel {
  final String? status;
  final int? statusCode;
  final bool? success;
  final Body? body;

  BusListModel({this.status, this.statusCode, this.success, this.body});

  factory BusListModel.fromJson(Map<String, dynamic> json) => BusListModel(
    status: json["status"],
    statusCode: json["status_code"],
    success: json["success"],
    body: Body.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_code": statusCode,
    "success": success,
    "body": body!.toJson(),
  };
}

class Body {
  final List<Item>? items;
  final Data? data;

  Body({this.items, this.data});

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "data": data!.toJson(),
  };
}

class Data {
  final int? currentPage;
  final int? lastPage;
  final int? total;

  Data({this.currentPage, this.lastPage, this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "last_page": lastPage,
    "total": total,
  };
}

class Item {
  final int? id;
  final int? totalSeats;
  final int? availableSeats;
  final String? ticketPrice;
  final int? allowPartialPayment;
  final String? minPartialPayment;
  final String? partialPaymentType;
  final DateTime? departureTime;
  final DateTime? arrivalTime;
  final DateTime? bookingDeadline;
  final String? status;
  final String? tripTime;
  final ItemVendor? vendor;
  final Branch? branch;
  final Bus? bus;
  final Route? route;

  Item({
    this.id,
    this.totalSeats,
    this.availableSeats,
    this.ticketPrice,
    this.allowPartialPayment,
    this.minPartialPayment,
    this.partialPaymentType,
    this.departureTime,
    this.arrivalTime,
    this.bookingDeadline,
    this.status,
    this.tripTime,
    this.vendor,
    this.branch,
    this.bus,
    this.route,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"] == null ? null : json["id"],
    totalSeats: json["total_seats"] == null ? null : json["total_seats"],
    availableSeats: json["available_seats"] == null
        ? null
        : json["available_seats"],
    ticketPrice: json["ticket_price"] == null ? null : json["ticket_price"],
    allowPartialPayment: json["allow_partial_payment"] == null
        ? null
        : json["allow_partial_payment"],
    minPartialPayment: json["min_partial_payment"] == null
        ? null
        : json["min_partial_payment"],
    partialPaymentType: json["partial_payment_type"] == null
        ? null
        : json["partial_payment_type"],
    departureTime: json["departure_time"] == null
        ? null
        : DateTime.parse(json["departure_time"]),
    arrivalTime: json["arrival_time"] == null
        ? null
        : DateTime.parse(json["arrival_time"]),
    bookingDeadline: json["booking_deadline"] == null
        ? null
        : DateTime.parse(json["booking_deadline"]),
    status: json["status"] == null ? null : json["status"],
    tripTime: json["trip_time"] == null ? null : json["trip_time"],
    vendor: json["vendor"] == null ? null : ItemVendor.fromJson(json["vendor"]),
    branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
    bus: json["bus"] == null ? null : Bus.fromJson(json["bus"]),
    route: json["route"] == null ? null : Route.fromJson(json["route"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "total_seats": totalSeats,
    "available_seats": availableSeats,
    "ticket_price": ticketPrice,
    "allow_partial_payment": allowPartialPayment,
    "min_partial_payment": minPartialPayment,
    "partial_payment_type": partialPaymentType,
    "departure_time": departureTime!.toIso8601String(),
    "arrival_time": arrivalTime!.toIso8601String(),
    "booking_deadline": bookingDeadline!.toIso8601String(),
    "status": status,
    "trip_time": tripTime,
    "vendor": vendor!.toJson(),
    "branch": branch!.toJson(),
    "bus": bus!.toJson(),
    "route": route!.toJson(),
  };
}

class Branch {
  final int? id;
  final int? vendorId;
  final int? provinceId;
  final String? name;
  final String? address;
  final String? representativeName;
  final String? representativePhone;
  final String? representativeEmail;
  final String? representativeNid;
  final String? representativePosition;
  final String? vendorCommissionAmount;
  final String? vendorCommissionType;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final BranchVendor? vendor;
  final Province? province;

  Branch({
    this.id,
    this.vendorId,
    this.provinceId,
    this.name,
    this.address,
    this.representativeName,
    this.representativePhone,
    this.representativeEmail,
    this.representativeNid,
    this.representativePosition,
    this.vendorCommissionAmount,
    this.vendorCommissionType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.vendor,
    this.province,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json["id"] == null ? null : json["id"],
    vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
    provinceId: json["province_id"] == null ? null : json["province_id"],
    name: json["name"] == null ? null : json["name"],
    address: json["address"] == null ? null : json["address"],
    representativeName: json["representative_name"] == null
        ? null
        : json["representative_name"],
    representativePhone: json["representative_phone"] == null
        ? null
        : json["representative_phone"],
    representativeEmail: json["representative_email"] == null
        ? null
        : json["representative_email"],
    representativeNid: json["representative_nid"] == null
        ? null
        : json["representative_nid"],
    representativePosition: json["representative_position"] == null
        ? null
        : json["representative_position"],
    vendorCommissionAmount: json["vendor_commission_amount"] == null
        ? null
        : json["vendor_commission_amount"],
    vendorCommissionType: json["vendor_commission_type"] == null
        ? null
        : json["vendor_commission_type"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    vendor: json["vendor"] == null
        ? null
        : BranchVendor.fromJson(json["vendor"]),
    province: json["province"] == null
        ? null
        : Province.fromJson(json["province"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "province_id": provinceId,
    "name": name,
    "address": address,
    "representative_name": representativeName,
    "representative_phone": representativePhone,
    "representative_email": representativeEmail,
    "representative_nid": representativeNid,
    "representative_position": representativePosition,
    "vendor_commission_amount": vendorCommissionAmount,
    "vendor_commission_type": vendorCommissionType,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "vendor": vendor!.toJson(),
    "province": province!.toJson(),
  };
}

class Province {
  final int? id;
  final String? name;
  final String? code;

  Province({this.id, this.name, this.code});

  factory Province.fromJson(Map<String, dynamic> json) =>
      Province(id: json["id"], name: json["name"], code: json["code"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "code": code};
}

class BranchVendor {
  final int? id;
  final String? shortName;
  final String? longName;
  final String? rating;
  final String? logo;

  BranchVendor({
    this.id,
    this.shortName,
    this.longName,
    this.rating,
    this.logo,
  });

  factory BranchVendor.fromJson(Map<String, dynamic> json) => BranchVendor(
    id: json["id"] == null ? null : json["id"],
    shortName: json["short_name"] == null ? null : json["short_name"],
    longName: json["long_name"] == null ? null : json["long_name"],
    rating: json["rating"] == null ? null : json["rating"],
    logo: json["logo"] == null ? null : json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "short_name": shortName,
    "long_name": longName,
    "rating": rating,
    "logo": logo,
  };
}

class Bus {
  final int? id;
  final int? vendorId;
  final int? driverId;
  final dynamic vendorBranchId;
  final String? name;
  final String? busNumber;

  Bus({
    this.id,
    this.vendorId,
    this.driverId,
    this.vendorBranchId,
    this.name,
    this.busNumber,
  });

  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
    id: json["id"] == null ? null : json["id"],
    vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
    driverId: json["driver_id"] == null ? null : json["driver_id"],
    vendorBranchId: json["vendor_branch_id"] == null
        ? null
        : json["vendor_branch_id"],
    name: json["name"] == null ? null : json["name"],
    busNumber: json["bus_number"] == null ? null : json["bus_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "driver_id": driverId,
    "vendor_branch_id": vendorBranchId,
    "name": name,
    "bus_number": busNumber,
  };
}

class Route {
  final int? id;
  final String? name;
  final int? distance;
  final NCity? originCity;
  final NCity? destinationCity;
  final NStation? originStation;
  final NStation? destinationStation;

  Route({
    this.id,
    this.name,
    this.distance,
    this.originCity,
    this.destinationCity,
    this.originStation,
    this.destinationStation,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    distance: json["distance"] == null ? null : json["distance"],
    originCity: json["origin_city"] == null
        ? null
        : NCity.fromJson(json["origin_city"]),
    destinationCity: json["destination_city"] == null
        ? null
        : NCity.fromJson(json["destination_city"]),
    originStation: json["origin_station"] == null
        ? null
        : NStation.fromJson(json["origin_station"]),
    destinationStation: json["destination_station"] == null
        ? null
        : NStation.fromJson(json["destination_station"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "distance": distance,
    "origin_city": originCity!.toJson(),
    "destination_city": destinationCity!.toJson(),
    "origin_station": originStation!.toJson(),
    "destination_station": destinationStation!.toJson(),
  };
}

class NCity {
  final int? id;
  final String? name;
  final String? code;
  final int? sort;
  final Province? country;
  final Province? province;

  NCity({
    this.id,
    this.name,
    this.code,
    this.sort,
    this.country,
    this.province,
  });

  factory NCity.fromJson(Map<String, dynamic> json) => NCity(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    code: json["code"] == null ? null : json["code"],
    sort: json["sort"] == null ? null : json["sort"],
    country: json["country"] == null
        ? null
        : Province.fromJson(json["country"]),
    province: json["province"] == null
        ? null
        : Province.fromJson(json["province"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "sort": sort,
    "country": country!.toJson(),
    "province": province!.toJson(),
  };
}

class NStation {
  final int? id;
  final String? name;

  NStation({this.id, this.name});

  factory NStation.fromJson(Map<String, dynamic> json) => NStation(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class ItemVendor {
  final int? id;
  final String? shortName;
  final String? longName;
  final String? representativeName;
  final String? representativePhone;
  final String? representativeEmail;
  final String? representativeNid;
  final String? representativePosition;
  final String? registrationNumber;
  final String? licenseNumber;
  final String? rating;
  final String? agentComissionAmount;
  final String? agentComissionType;
  final String? adminComissionAmount;
  final String? adminComissionType;
  final String? settlementPeriod;
  final String? description;
  final String? logo;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ItemVendor({
    this.id,
    this.shortName,
    this.longName,
    this.representativeName,
    this.representativePhone,
    this.representativeEmail,
    this.representativeNid,
    this.representativePosition,
    this.registrationNumber,
    this.licenseNumber,
    this.rating,
    this.agentComissionAmount,
    this.agentComissionType,
    this.adminComissionAmount,
    this.adminComissionType,
    this.settlementPeriod,
    this.description,
    this.logo,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ItemVendor.fromJson(Map<String, dynamic> json) => ItemVendor(
    id: json["id"] == null ? null : json["id"],
    shortName: json["short_name"] == null ? null : json["short_name"],
    longName: json["long_name"] == null ? null : json["long_name"],
    representativeName: json["representative_name"] == null
        ? null
        : json["representative_name"],
    representativePhone: json["representative_phone"] == null
        ? null
        : json["representative_phone"],
    representativeEmail: json["representative_email"] == null
        ? null
        : json["representative_email"],
    representativeNid: json["representative_nid"] == null
        ? null
        : json["representative_nid"],
    representativePosition: json["representative_position"] == null
        ? null
        : json["representative_position"],
    registrationNumber: json["registration_number"] == null
        ? null
        : json["registration_number"],
    licenseNumber: json["license_number"] == null
        ? null
        : json["license_number"],
    rating: json["rating"] == null ? null : json["rating"],
    agentComissionAmount: json["agent_comission_amount"] == null
        ? null
        : json["agent_comission_amount"],
    agentComissionType: json["agent_comission_type"] == null
        ? null
        : json["agent_comission_type"],
    adminComissionAmount: json["admin_comission_amount"] == null
        ? null
        : json["admin_comission_amount"],
    adminComissionType: json["admin_comission_type"] == null
        ? null
        : json["admin_comission_type"],
    settlementPeriod: json["settlement_period"] == null
        ? null
        : json["settlement_period"],
    description: json["description"] == null ? null : json["description"],
    logo: json["logo"] == null ? null : json["logo"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "short_name": shortName,
    "long_name": longName,
    "representative_name": representativeName,
    "representative_phone": representativePhone,
    "representative_email": representativeEmail,
    "representative_nid": representativeNid,
    "representative_position": representativePosition,
    "registration_number": registrationNumber,
    "license_number": licenseNumber,
    "rating": rating,
    "agent_comission_amount": agentComissionAmount,
    "agent_comission_type": agentComissionType,
    "admin_comission_amount": adminComissionAmount,
    "admin_comission_type": adminComissionType,
    "settlement_period": settlementPeriod,
    "description": description,
    "logo": logo,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
