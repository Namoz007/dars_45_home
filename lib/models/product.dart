class Product {
  int id;
  String title;
  double price;
  List<String> imgs;
  double rating;
  String description;
  bool isFavorite = false;
  String status;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imgs,
    required this.rating,
    required this.description,
    required this.status,
  });
}
