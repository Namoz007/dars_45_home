import 'package:dars_45_home/models/cart.dart';
import 'package:dars_45_home/models/product.dart';
import 'package:flutter/cupertino.dart';

class CartController extends ChangeNotifier{
  List<Cart> _carts = [];
  List<List<Cart>> _ordered = [];

  List<List<Cart>> getOrderedCart(){
    return [..._ordered];
  }

  void addOrderProducts(){
    _ordered.add(_carts);
    print(_ordered);
    _carts = [];
    notifyListeners();
  }

  List<Cart> getCart(){
    return [..._carts];
  }

  void minusProduct(int id){
    for(int i = 0;i < _carts.length;i++)
      if(_carts[i].product.id == id)
        if(_carts[i].amount == 1){
          _carts.removeAt(i);
        }
        else{
          _carts[i].amount--;
        }

    notifyListeners();
  }

  double totalPrice(){
    double price = 0;
    for(int i = 0;i < _carts.length;i++){
      price+= _carts[i].product.price * _carts[i].amount;
    }

    return price;
  }

  void addProductAmount(int id){
    for(int i = 0;i < _carts.length;i++)
      if(_carts[i].product.id == id)
        _carts[i].amount++;

    notifyListeners();
  }

  void addProductToCart(Product product){
    bool isFind = false;
    for(int i = 0;i < _carts.length;i++)
      if(_carts[i].product.id == product.id){
        isFind = true;
        _carts[i].amount++;
      }
    if(!isFind)
      _carts.add(Cart(product: product, amount: 1));

    notifyListeners();
  }
}