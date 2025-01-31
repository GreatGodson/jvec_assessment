class DriversResponseModel {
  final List<Driver>? drivers;

  DriversResponseModel({
    this.drivers,
  });

  factory DriversResponseModel.fromJson(Map<String, dynamic> json) =>
      DriversResponseModel(
        drivers: json["drivers"] == null
            ? []
            : List<Driver>.from(
                json["drivers"]!.map((x) => Driver.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "drivers": drivers == null
            ? []
            : List<dynamic>.from(drivers!.map((x) => x.toJson())),
      };
}

class Driver {
  final String? name;
  final String? type;
  final String? rating;
  final String? price;
  final String? phone;
  final String? plateNo;
  final String? pickup;
  final String? dropOff;
  final String? comments;
  final String? status;
  final String? date;

  Driver({
    this.name,
    this.type,
    this.rating,
    this.price,
    this.phone,
    this.plateNo,
    this.pickup,
    this.dropOff,
    this.comments,
    this.status,
    this.date,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        name: json["name"],
        type: json["type"],
        rating: json["rating"],
        price: json["price"],
        phone: json["phone"],
        plateNo: json["plate"],
        pickup: json["pickup"],
        dropOff: json["dropoff"],
        comments: json["comments"],
        status: json["status"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "rating": rating,
        "price": price,
        "phone": phone,
        "plate": plateNo,
        "pickup": pickup,
        "dropoff": dropOff,
        "comments": comments,
        "status": status,
        "date": date,
      };
}
