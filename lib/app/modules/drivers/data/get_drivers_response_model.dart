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

  Driver({
    this.name,
    this.type,
    this.rating,
    this.price,
    this.phone,
    this.plateNo,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        name: json["name"],
        type: json["type"],
        rating: json["rating"],
        price: json["price"],
        phone: json["phone"],
        plateNo: json["plate"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "rating": rating,
        "price": price,
        "phone": phone,
        "plate": plateNo,
      };
}
