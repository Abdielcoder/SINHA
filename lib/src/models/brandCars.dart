import 'dart:convert';

BrandCars BrandCarsFromJson(String str) => BrandCars.fromJson(json.decode(str));

String BrandCarsJson(BrandCars data) => json.encode(data.toJson());

class BrandCars {

  String id;
  String brand;
  String model;
  List<BrandCars> toList = [];

  BrandCars({
    this.id,
    this.brand,
    this.model,
  });

  factory BrandCars.fromJson(Map<String, dynamic> json) => BrandCars(
    id: json["id"] is int ? json["id"].toString() : json['id'],
    brand: json["brand"],
    model: json["model"],

  );

  BrandCars.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      BrandCars product = BrandCars.fromJson(item);
      toList.add(product);
    });
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "brand": brand,
    "model": model,
  };

  static bool isInteger(num value) => value is int || value == value.roundToDouble();

}
