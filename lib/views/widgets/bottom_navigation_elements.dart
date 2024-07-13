import 'package:dars_45_home/controllers/cart_controller.dart';
import 'package:dars_45_home/models/product.dart';
import 'package:dars_45_home/views/widgets/card_in_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationElements extends StatefulWidget {
  Product product;
  BottomNavigationElements({super.key,required this.product});

  @override
  State<BottomNavigationElements> createState() => _BottomNavigationElementsState();
}

class _BottomNavigationElementsState extends State<BottomNavigationElements> {
  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context,listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: (){
            cartController.addProductToCart(widget.product);
            showModalBottomSheet(context: context, builder: (ctx){
              return CardInProducts();
            });
          },
          child: Container(
            width: 300,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text("ADD TO CART",style: TextStyle(color: Colors.white,fontSize: 20),),
          ),
        ),

        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.lightGreen
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.shopping_cart,color: Colors.white,size: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 10,top: 10),
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black
                  ),
                  alignment: Alignment.center,
                  child: Text("${cartController.getCart().length}",style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
