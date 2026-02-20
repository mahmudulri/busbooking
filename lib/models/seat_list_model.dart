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
  final Branch? route;
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
    route: json["route"] == null ? null : Branch.fromJson(json["route"]),
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
  final Branch? vendor;
  final Branch? driver;
  final Seats? seats;
  final dynamic branch;

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
    vendor: json["vendor"] == null ? null : Branch.fromJson(json["vendor"]),
    driver: json["driver"] == null ? null : Branch.fromJson(json["driver"]),
    seats: json["seats"] == null ? null : Seats.fromJson(json["seats"]),
    branch: json["branch"] == null ? null : json["branch"],
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

class Seat {
  final int? row;
  final int? price;
  final int? column;
  final SeatType? seatType;
  final int? isSleeper;
  final SeatClass? seatClass;
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
    seatType: json["seat_type"] == null
        ? null
        : seatTypeValues.map[json["seat_type"]],
    isSleeper: json["is_sleeper"] == null ? null : json["is_sleeper"],
    seatClass: json["seat_class"] == null
        ? null
        : seatClassValues.map[json["seat_class"]],
    isRecliner: json["is_recliner"] == null ? null : json["is_recliner"],
    seatNumber: json["seat_number"] == null ? null : json["seat_number"],
  );

  Map<String, dynamic> toJson() => {
    "row": row,
    "price": price,
    "column": column,
    "seat_type": seatTypeValues.reverse[seatType],
    "is_sleeper": isSleeper,
    "seat_class": seatClassValues.reverse[seatClass],
    "is_recliner": isRecliner,
    "seat_number": seatNumber,
  };
}

enum SeatClass { ECONOMIC, VIP }

final seatClassValues = EnumValues({
  "economic": SeatClass.ECONOMIC,
  "vip": SeatClass.VIP,
});

enum SeatType { MIDDLE, WINDOW }

final seatTypeValues = EnumValues({
  "middle": SeatType.MIDDLE,
  "window": SeatType.WINDOW,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
