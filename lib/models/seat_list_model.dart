import 'dart:convert';

SeatListModel seatListModelFromJson(String str) =>
    SeatListModel.fromJson(json.decode(str));

String seatListModelToJson(SeatListModel data) => json.encode(data.toJson());

class SeatListModel {
  final String? status;
  final int? statusCode;
  final bool? success;
  final Body? body;

  SeatListModel({this.status, this.statusCode, this.success, this.body});

  factory SeatListModel.fromJson(Map<String, dynamic> json) => SeatListModel(
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
  final Item? item;

  Body({this.item});

  factory Body.fromJson(Map<String, dynamic> json) =>
      Body(item: Item.fromJson(json["item"]));

  Map<String, dynamic> toJson() => {"item": item!.toJson()};
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
  final Branch? vendor;
  final Branch? branch;
  final Bus? bus;
  final Route? route;
  final List<dynamic>? seatPrices;

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
    this.seatPrices,
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
    vendor: json["vendor"] == null ? null : Branch.fromJson(json["vendor"]),
    branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
    bus: json["bus"] == null ? null : Bus.fromJson(json["bus"]),
    route: json["route"] == null ? null : Route.fromJson(json["route"]),
    seatPrices: json["seat_prices"] == null
        ? null
        : List<dynamic>.from(json["seat_prices"].map((x) => x)),
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
    "seat_prices": List<dynamic>.from(seatPrices!.map((x) => x)),
  };
}

class Branch {
  Branch();

  factory Branch.fromJson(Map<String, dynamic> json) => Branch();

  Map<String, dynamic> toJson() => {};
}

class Bus {
  final int? id;
  final int? vendorId;
  final int? driverId;
  final dynamic vendorBranchId;
  final String? name;
  final String? busNumber;
  final String? image;
  final String? facilities;
  final String? rating;
  final String? ticketPrice;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final BusVendor? vendor;
  final Branch? driver;
  final Seats? seats;
  final BusBranch? branch;

  Bus({
    this.id,
    this.vendorId,
    this.driverId,
    this.vendorBranchId,
    this.name,
    this.busNumber,
    this.image,
    this.facilities,
    this.rating,
    this.ticketPrice,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.vendor,
    this.driver,
    this.seats,
    this.branch,
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
    image: json["image"] == null ? null : json["image"],
    facilities: json["facilities"] == null ? null : json["facilities"],
    rating: json["rating"] == null ? null : json["rating"],
    ticketPrice: json["ticket_price"] == null ? null : json["ticket_price"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    vendor: json["vendor"] == null ? null : BusVendor.fromJson(json["vendor"]),
    driver: json["driver"] == null ? null : Branch.fromJson(json["driver"]),
    seats: json["seats"] == null ? null : Seats.fromJson(json["seats"]),
    branch: json["branch"] == null ? null : BusBranch.fromJson(json["branch"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "driver_id": driverId,
    "vendor_branch_id": vendorBranchId,
    "name": name,
    "bus_number": busNumber,
    "image": image,
    "facilities": facilities,
    "rating": rating,
    "ticket_price": ticketPrice,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "vendor": vendor!.toJson(),
    "driver": driver!.toJson(),
    "seats": seats!.toJson(),
    "branch": branch,
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

class Province {
  final int? id;
  final String? name;
  final String? code;

  Province({this.id, this.name, this.code});

  factory Province.fromJson(Map<String, dynamic> json) =>
      Province(id: json["id"], name: json["name"], code: json["code"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "code": code};
}

class BusBranch {
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
  final BranchVendor? vendor;
  final Province? province;

  BusBranch({
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
    this.vendor,
    this.province,
  });

  factory BusBranch.fromJson(Map<String, dynamic> json) => BusBranch(
    id: json["id"],
    vendorId: json["vendor_id"],
    provinceId: json["province_id"],
    name: json["name"],
    address: json["address"],
    representativeName: json["representative_name"],
    representativePhone: json["representative_phone"],
    representativeEmail: json["representative_email"],
    representativeNid: json["representative_nid"],
    representativePosition: json["representative_position"],
    vendorCommissionAmount: json["vendor_commission_amount"],
    vendorCommissionType: json["vendor_commission_type"],
    status: json["status"],
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
    "vendor": vendor!.toJson(),
    "province": province!.toJson(),
  };
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

class Driver {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobile;

  Driver({this.id, this.firstName, this.lastName, this.email, this.mobile});

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json["id"] == null ? null : json["id"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    email: json["email"] == null ? null : json["email"],
    mobile: json["mobile"] == null ? null : json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "mobile": mobile,
  };
}

class Seats {
  final int? id;
  final int? busId;
  final int? rows;
  final int? columns;
  final List<Seat>? seats;
  final String? berthType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Seats({
    this.id,
    this.busId,
    this.rows,
    this.columns,
    this.seats,
    this.berthType,
    this.createdAt,
    this.updatedAt,
  });

  factory Seats.fromJson(Map<String, dynamic> json) => Seats(
    id: json["id"] == null ? null : json["id"],
    busId: json["bus_id"] == null ? null : json["bus_id"],
    rows: json["rows"] == null ? null : json["rows"],
    columns: json["columns"] == null ? null : json["columns"],
    seats: json["seats"] == null
        ? null
        : List<Seat>.from(json["seats"].map((x) => Seat.fromJson(x))),
    berthType: json["berth_type"] == null ? null : json["berth_type"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bus_id": busId,
    "rows": rows,
    "columns": columns,
    "seats": List<dynamic>.from(seats!.map((x) => x.toJson())),
    "berth_type": berthType,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class BusVendor {
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

  BusVendor({
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

  factory BusVendor.fromJson(Map<String, dynamic> json) => BusVendor(
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

class Seat {
  final int? row;
  final int? price;
  final int? column;
  final String? seatType;
  final int? isSleeper;
  final String? seatClass;
  final int? isRecliner;
  final int? seatNumber;

  Seat({
    this.row,
    this.price,
    this.column,
    this.seatType,
    this.isSleeper,
    this.seatClass,
    this.isRecliner,
    this.seatNumber,
  });

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
    row: json["row"] == null ? null : json["row"],
    price: json["price"] == null ? null : json["price"],
    column: json["column"] == null ? null : json["column"],
    seatType: json["seat_type"] == null ? null : json["seat_type"],
    isSleeper: json["is_sleeper"] == null ? null : json["is_sleeper"],
    seatClass: json["seat_class"] == null ? null : json["seat_class"],
    isRecliner: json["is_recliner"] == null ? null : json["is_recliner"],
    seatNumber: json["seat_number"] == null ? null : json["seat_number"],
  );

  Map<String, dynamic> toJson() => {
    "row": row,
    "price": price,
    "column": column,
    "seat_type": seatType,
    "is_sleeper": isSleeper,
    "seat_class": seatClass,
    "is_recliner": isRecliner,
    "seat_number": seatNumber,
  };
}

class SeatPrice {
  final int? id;
  final int? tripId;
  final int? seatNumber;
  final String? ticketPrice;
  final int? payblePrice;
  final String? totalDiscountAmount;
  final String? discountAmount;
  final Type? discountType;
  final dynamic saleStartDate;
  final dynamic saleEndDate;
  final bool? isAvaiable;

  SeatPrice({
    this.id,
    this.tripId,
    this.seatNumber,
    this.ticketPrice,
    this.payblePrice,
    this.totalDiscountAmount,
    this.discountAmount,
    this.discountType,
    this.saleStartDate,
    this.saleEndDate,
    this.isAvaiable,
  });

  factory SeatPrice.fromJson(Map<String, dynamic> json) => SeatPrice(
    id: json["id"] == null ? null : json["id"],
    tripId: json["trip_id"] == null ? null : json["trip_id"],
    seatNumber: json["seat_number"] == null ? null : json["seat_number"],
    ticketPrice: json["ticket_price"] == null ? null : json["ticket_price"],
    payblePrice: json["payble_price"] == null ? null : json["payble_price"],
    totalDiscountAmount: json["total_discount_amount"] == null
        ? null
        : json["total_discount_amount"],
    discountAmount: json["discount_amount"] == null
        ? null
        : json["discount_amount"],
    discountType: json["discount_type"] == null ? null : json["discount_type"],
    saleStartDate: json["sale_start_date"] == null
        ? null
        : json["sale_start_date"],
    saleEndDate: json["sale_end_date"] == null ? null : json["sale_end_date"],
    isAvaiable: json["is_avaiable"] == null ? null : json["is_avaiable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trip_id": tripId,
    "seat_number": seatNumber,
    "ticket_price": ticketPrice,
    "payble_price": payblePrice,
    "total_discount_amount": totalDiscountAmount,
    "discount_amount": discountAmount,
    "discount_type": discountType,
    "sale_start_date": saleStartDate,
    "sale_end_date": saleEndDate,
    "is_avaiable": isAvaiable,
  };
}
