import 'dart:io';
import 'package:dars_45_home/models/product.dart';
import 'package:dars_45_home/services/product_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsController extends ChangeNotifier {
  final _productServices = ProductServices();
  List<String> _status = [
    "kitchen",
    "living room",
    "bathroom"
  ];
  List<Product> _products = [];

  Future<void> addProductInFirebase(Product product,List<File> imgs) async{
    _productServices.addProduct(product, imgs);
  }

  List<String> getStatus(){
    return [..._status];
  }

  Stream<QuerySnapshot> get getProducts async*{
    yield* _productServices.getProducts();
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
