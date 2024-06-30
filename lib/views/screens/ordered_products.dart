import 'package:dars_45_home/controllers/cart_controller.dart';
import 'package:dars_45_home/models/product.dart';
import 'package:dars_45_home/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderedProducts extends StatefulWidget {
  const OrderedProducts({super.key});

  @override
  State<OrderedProducts> createState() => _OrderedProductsState();
}

class _OrderedProductsState extends State<OrderedProducts> {
  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Ordered Products"),
      ),
      body: cartController.getOrderedCart().length == 0
          ? Center(
              child: Text("Buyurtmalar mavjud emas"),
            )
          : ListView.builder(
            itemCount: cartController.getOrderedCart().length,
            itemBuilder: (ctx, index) {
              double price = 0;
              for(int i = 0;i < cartController.getOrderedCart()[index].length;i++)
                price += cartController.getOrderedCart()[index][i].amount * cartController.getOrderedCart()[index][i].product.price;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ordered products count ~ ${cartController.getOrderedCart()[index].length}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Product name",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          Text("Products count",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                        ],
                      ),
                      for(int i = 0;i < cartController.getOrderedCart()[index].length;i++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${cartController.getOrderedCart()[index][i].product.title}',style: TextStyle(fontSize: 17),),
                            Text('${cartController.getOrderedCart()[index][i].amount}',style: TextStyle(fontSize: 17),)
                          ],
                        ),
                      SizedBox(height: 30,),
                      Center(child: Text("Total price: \$${price}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),)
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
