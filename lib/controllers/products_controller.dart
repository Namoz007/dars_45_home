import 'package:dars_45_home/models/product.dart';
import 'package:flutter/cupertino.dart';

class ProductsController extends ChangeNotifier {
  List<String> _status = [
    "kitchen",
    "living room",
    "bathroom"
  ];
  List<Product> _products = [
    Product(
        id: 1,
        title: 'Desk Lamp',
        price: 100,
        imgs: [
          "https://posturedepot.com/wp-content/uploads/2021/03/LE-Desk-Clamp-LED-Lamp-Main-with-Clamp-LLR-99954-1024x1024.jpg",
          "https://www.tuconsola.com/images/productos/mini-lmpara-138-1-2123.jpeg",
          "https://exmart.com.ua/img/cms/2_5.png",
        ],
        rating: 5,
        description:
            'Enhance your workspace with our sleek and modern desk lamp. This stylish lamp features an adjustable arm and head, allowing you to direct light exactly where you need it. The minimalist design fits perfectly with any decor, while the energy-efficient LED bulb provides bright, clear illumination. Ideal for reading, studying, or adding ambient light to your office, this desk lamp is both functional and elegant. Easy to operate with a simple touch control, it also includes a dimming feature to customize your lighting preference. Perfect for home offices, bedrooms, or living spaces, this desk lamp combines form and function to create a comfortable and productive environment.',
        status: "living room"),
    Product(
        id: 2,
        title: 'Cofe glass',
        price: 15,
        imgs: [
          "https://image.pngaaa.com/596/906596-middle.png",
          "https://cdn141.picsart.com/323571306180211.png",
          "https://www.pngplay.com/wp-content/uploads/7/Cappuccino-Cup-PNG-HD-Quality.png"
        ],
        rating: 4.9,
        description:
            'Enjoy your favorite hot beverages in style with our elegant coffee glass. Crafted from high-quality, heat-resistant borosilicate glass, this cup is designed to withstand high temperatures while maintaining its crystal-clear appearance. The double-walled construction keeps your drink hot for longer while the outer surface remains cool to the touch, providing a comfortable grip. Its sleek and modern design adds a touch of sophistication to your coffee routine, making it perfect for both everyday use and special occasions. Whether you prefer espresso, latte, or cappuccino, this versatile coffee glass will enhance your drinking experience.',
        status: "kitchen"),
    Product(
        id: 3,
        title: "Toothbrush",
        price: 7,
        imgs: [
          "https://www.med-tehnik.ru/upload/iblock/9f9/7w0zakml6pt1qd8z79j0ayclk2tj3ddp/zubnaya_shchetka_revyline_sm6000_duo_2sht_myatnaya_fioletovaya_2.png",
          "https://mdco.com.sa/wp-content/uploads/2020/02/44444-1.png",
          "https://pnggallery.com/wp-content/uploads/toothbrush-02.png"
        ],
        rating: 4.8,
        description:
            'Achieve a superior clean with our premium toothbrush, designed to promote optimal oral hygiene. Featuring soft, rounded bristles, it provides a gentle yet effective clean, reaching deep between teeth and along the gum line without causing irritation. The ergonomic handle offers a comfortable and secure grip, making it easy to maneuver and ensuring thorough brushing. With its sleek and modern design, this toothbrush not only performs exceptionally but also looks great in your bathroom. Ideal for daily use, it helps to maintain healthy teeth and gums, leaving your mouth feeling fresh and clean.',
        status: 'bathroom')
  ];

  List<String> getStatus(){
    return [..._status];
  }

  List<Product> getProducts() {
    return [..._products];
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(int id) {
    _products.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void favorite(int id) {
    for (int i = 0; i < _products.length; i++)
      if (_products[i].id == id)
        _products[i].isFavorite = !_products[i].isFavorite;

    notifyListeners();
  }

  List<Product> getProductWithStauts(String status) {
    return [..._products.where((element) => element.status == status)];
  }

  void editProduct(Product product) {
    for (int i = 0; i < _products.length; i++)
      if (_products[i].id == product.id) {
        _products[i].title = product.title;
        _products[i].price = product.price;
        _products[i].rating = product.rating;
        _products[i].description = product.description;
        _products[i].status = product.status;
      }

    notifyListeners();
  }
}
