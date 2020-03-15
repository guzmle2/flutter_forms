import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

// ignore: non_constant_identifier_names
String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String id;
  String title;
  double value;
  bool available;
  String photoUrl;

  Product({
    this.id,
    this.title = '',
    this.value = 0.0,
    this.available = true,
    this.photoUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => new Product(
        id: json["id"],
        title: json["title"],
        value: json["value"],
        available: json["available"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
        "available": available,
        "photoUrl": photoUrl,
      };
}
