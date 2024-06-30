import 'package:dars_45_home/controllers/cart_controller.dart';
import 'package:dars_45_home/models/cart.dart';
import 'package:dars_45_home/models/product.dart';
import 'package:dars_45_home/views/screens/check_out_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardInProducts extends StatefulWidget {
  const CardInProducts({super.key});

  @override
  State<CardInProducts> createState() => _CardInProductsState();
}

class _CardInProductsState extends State<CardInProducts> {
  double price = 0;

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20,),
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade400,
              ),
            ),
          ),

          Row(
            children: [
              Text('My Cart',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              SizedBox(width: 20,),
              Container(
                // width: 150,
                // height: 40,
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text("Savatdagi mahsulotlar soni ${cartController.getCart().length}",style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartController.getCart().length,
              itemBuilder: (context,index){
                Cart product = cartController.getCart()[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade400
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 80,
                          height: 120,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage("${product.product.imgs[0]}"),
                                  fit: BoxFit.fitHeight
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),
                        ),
                        Column(
                          children: [
                            Text('${product.product.title}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                            Row(
                              children: [
                                IconButton(onPressed: (){
                                  cartController.minusProduct(cartController.getCart()[index].product.id);
                                }, icon: Icon(Icons.remove_circle)),
                                Text('${product.amount}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                IconButton(onPressed: (){
                                  cartController.addProductAmount(cartController.getCart()[index].product.id);
                                }, icon: Icon(Icons.add_circle))
                              ],
                            ),

                            Text('Total price: \$${product.amount * product.product.price}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          Row(
            children: [
              Text('Total: \$${cartController.totalPrice()}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
            ],
          ),

          SizedBox(height: 10,),

          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckOutCart()));
            },
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(15)
              ),
              alignment: Alignment.center,
              child: Text("CHECKOUT CART",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
            ),
          ),

          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
