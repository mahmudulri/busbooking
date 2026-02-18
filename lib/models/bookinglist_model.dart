import 'dart:convert';

BookingListModel bookingListModelFromJson(String str) =>
    BookingListModel.fromJson(json.decode(str));

String bookingListModelToJson(BookingListModel data) =>
    json.encode(data.toJson());

class BookingListModel {
  final String? status;
  final int? statusCode;
  final bool? success;
  final Body? body;

  BookingListModel({this.status, this.statusCode, this.success, this.body});

  factory BookingListModel.fromJson(Map<String, dynamic> json) =>
      BookingListModel(
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
  final String? code;
  final int? ticketCount;
  final String? totalPrice;
  final String? penaltyAmount;
  final String? remainingAmount;
  final bool? isPartialPayment;
  final String? status;
  final dynamic disbursementAt;
  final int? childCount;
  final DateTime? createdAt;
  final DateTime? updateAt;
  final User? user;
  final Vendor? vendor;
  final dynamic branch;
  final dynamic agent;
  final Trip? trip;
  final List<Ticket>? tickets;
  final String? downloadTickets;

  Item({
    this.id,
    this.code,
    this.ticketCount,
    this.totalPrice,
    this.penaltyAmount,
    this.remainingAmount,
    this.isPartialPayment,
    this.status,
    this.disbursementAt,
    this.childCount,
    this.createdAt,
    this.updateAt,
    this.user,
    this.vendor,
    this.branch,
    this.agent,
    this.trip,
    this.tickets,
    this.downloadTickets,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"] == null ? null : json["id"],
    code: json["code"] == null ? null : json["code"],
    ticketCount: json["ticket_count"] == null ? null : json["ticket_count"],
    totalPrice: json["total_price"] == null ? null : json["total_price"],
    penaltyAmount: json["penalty_amount"] == null
        ? null
        : json["penalty_amount"],
    remainingAmount: json["remaining_amount"] == null
        ? null
        : json["remaining_amount"],
    isPartialPayment: json["is_partial_payment"] == null
        ? null
        : json["is_partial_payment"],
    status: json["status"] == null ? null : json["status"],
    disbursementAt: json["disbursement_at"] == null
        ? null
        : json["disbursement_at"],
    childCount: json["child_count"] == null ? null : json["child_count"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updateAt: json["update_at"] == null
        ? null
        : DateTime.parse(json["update_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
    branch: json["branch"] == null ? null : json["branch"],
    agent: json["agent"] == null ? null : json["agent"],
    trip: json["trip"] == null ? null : Trip.fromJson(json["trip"]),
    tickets: json["tickets"] == null
        ? null
        : List<Ticket>.from(json["tickets"].map((x) => Ticket.fromJson(x))),
    downloadTickets: json["download_tickets"] == null
        ? null
        : json["download_tickets"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "ticket_count": ticketCount,
    "total_price": totalPrice,
    "penalty_amount": penaltyAmount,
    "remaining_amount": remainingAmount,
    "is_partial_payment": isPartialPayment,
    "status": status,
    "disbursement_at": disbursementAt,
    "child_count": childCount,
    "created_at": createdAt!.toIso8601String(),
    "update_at": updateAt!.toIso8601String(),
    "user": user!.toJson(),
    "vendor": vendor!.toJson(),
    "branch": branch,
    "agent": agent,
    "trip": trip!.toJson(),
    "tickets": List<dynamic>.from(tickets!.map((x) => x.toJson())),
    "download_tickets": downloadTickets,
  };
}

class Ticket {
  final int? id;
  final int? tripSeatPriceId;
  final int? passengerId;
  final String? price;
  final int? seatNumber;
  final bool? isChild;
  final String? status;
  final Passenger? passenger;

  Ticket({
    this.id,
    this.tripSeatPriceId,
    this.passengerId,
    this.price,
    this.seatNumber,
    this.isChild,
    this.status,
    this.passenger,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json["id"] == null ? null : json["id"],
    tripSeatPriceId: json["trip_seat_price_id"] == null
        ? null
        : json["trip_seat_price_id"],
    passengerId: json["passenger_id"] == null ? null : json["passenger_id"],
    price: json["price"] == null ? null : json["price"],
    seatNumber: json["seat_number"] == null ? null : json["seat_number"],
    isChild: json["is_child"] == null ? null : json["is_child"],
    status: json["status"] == null ? null : json["status"],
    passenger: json["passenger"] == null
        ? null
        : Passenger.fromJson(json["passenger"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trip_seat_price_id": tripSeatPriceId,
    "passenger_id": passengerId,
    "price": price,
    "seat_number": seatNumber,
    "is_child": isChild,
    "status": status,
    "passenger": passenger!.toJson(),
  };
}

class Passenger {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? nationalId;
  final dynamic birthday;
  final String? gender;

  Passenger({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.nationalId,
    this.birthday,
    this.gender,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
    id: json["id"] == null ? null : json["id"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    nationalId: json["national_id"] == null ? null : json["national_id"],
    birthday: json["birthday"] == null ? null : json["birthday"],
    gender: json["gender"] == null ? null : json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "national_id": nationalId,
    "birthday": birthday,
    "gender": gender,
  };
}

class Trip {
  final int? id;
  final DateTime? departureTime;
  final DateTime? arrivalTime;
  final String? tripTime;
  final Route? route;
  final Bus? bus;

  Trip({
    this.id,
    this.departureTime,
    this.arrivalTime,
    this.tripTime,
    this.route,
    this.bus,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
    id: json["id"] == null ? null : json["id"],
    departureTime: json["departure_time"] == null
        ? null
        : DateTime.parse(json["departure_time"]),
    arrivalTime: json["arrival_time"] == null
        ? null
        : DateTime.parse(json["arrival_time"]),
    tripTime: json["trip_time"] == null ? null : json["trip_time"],
    route: json["route"] == null ? null : Route.fromJson(json["route"]),
    bus: json["bus"] == null ? null : Bus.fromJson(json["bus"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "departure_time": departureTime!.toIso8601String(),
    "arrival_time": arrivalTime!.toIso8601String(),
    "trip_time": tripTime,
    "route": route!.toJson(),
    "bus": bus!.toJson(),
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
  final DestinationCityName? name;
  final DestinationCityCode? code;
  final int? sort;
  final Country? country;
  final Country? province;

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
    name: json["name"] == null
        ? null
        : destinationCityNameValues.map[json["name"]],
    code: json["code"] == null
        ? null
        : destinationCityCodeValues.map[json["code"]],
    sort: json["sort"] == null ? null : json["sort"],
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
    province: json["province"] == null
        ? null
        : Country.fromJson(json["province"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": destinationCityNameValues.reverse[name],
    "code": destinationCityCodeValues.reverse[code],
    "sort": sort,
    "country": country!.toJson(),
    "province": province!.toJson(),
  };
}

enum DestinationCityCode { KABUL, TALOQAN }

final destinationCityCodeValues = EnumValues({
  "kabul": DestinationCityCode.KABUL,
  "taloqan": DestinationCityCode.TALOQAN,
});

class Country {
  final int? id;
  final CountryName? name;
  final CountryCode? code;

  Country({this.id, this.name, this.code});

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : countryNameValues.map[json["name"]],
    code: json["code"] == null ? null : countryCodeValues.map[json["code"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": countryNameValues.reverse[name],
    "code": countryCodeValues.reverse[code],
  };
}

enum CountryCode { AF, KABUL, TAKHAR }

final countryCodeValues = EnumValues({
  "af": CountryCode.AF,
  "kabul": CountryCode.KABUL,
  "takhar": CountryCode.TAKHAR,
});

enum CountryName { AFGHANISTAN, EMPTY, NAME }

final countryNameValues = EnumValues({
  "afghanistan": CountryName.AFGHANISTAN,
  "کابل": CountryName.EMPTY,
  "تخار": CountryName.NAME,
});

enum DestinationCityName { KABUL, TALOQAN }

final destinationCityNameValues = EnumValues({
  "kabul": DestinationCityName.KABUL,
  "Taloqan": DestinationCityName.TALOQAN,
});

class NStation {
  final int? id;
  final DestinationStationName? name;

  NStation({this.id, this.name});

  factory NStation.fromJson(Map<String, dynamic> json) => NStation(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null
        ? null
        : destinationStationNameValues.map[json["name"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": destinationStationNameValues.reverse[name],
  };
}

enum DestinationStationName { EMPTY, NAME }

final destinationStationNameValues = EnumValues({
  "ترمنال لوای بابه جان": DestinationStationName.EMPTY,
  "ترمینال گولایی": DestinationStationName.NAME,
});

class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobile;
  final String? role;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    email: json["email"] == null ? null : json["email"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    role: json["role"] == null ? null : json["role"],
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
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "mobile": mobile,
    "role": role,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class Vendor {
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

  Vendor({
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

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
