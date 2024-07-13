
import 'dart:ffi';

class Product {
  String globalId;
  int id;
  String title;
  double price;
  List<String>? imgs;
  double rating;
  String description;
  bool isFavorite;
  String status;

  Product({
    required this.globalId,
    required this.id,
    required this.title,
    required this.price,
    required this.imgs,
    required this.rating,
    required this.description,
    required this.isFavorite,
    required this.status,
  });


  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      globalId: json['globalId'],
      id: json['id'],
      title: json['title'],
      price: double.parse(json['price'].toString()),
      imgs: json['imgs'] != null ? List<String>.from(json['imgs']) : null,
      rating: double.parse(json['rating'].toString()),
      description: json['description'],
      isFavorite: bool.parse(json['isFavorite'].toString()) ?? false,
      status: json['status'],
    );
  }


}
