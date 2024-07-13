import 'package:dars_45_home/controllers/cart_controller.dart';
import 'package:dars_45_home/views/screens/ordered_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutCart extends StatefulWidget {
  const CheckOutCart({super.key});

  @override
  State<CheckOutCart> createState() => _CheckOutCartState();
}

class _CheckOutCartState extends State<CheckOutCart> {
  @override
  Widget build(BuildContext context) {
    double price = 0;
    final cartController = Provider.of<CartController>(context);
    for (int i = 0; i < cartController.getCart().length; i++)
      price += cartController.getCart()[i].amount *
          cartController.getCart()[i].product.price;
    return Scaffold(
      appBar: AppBar(
        title: Text("Checked Products"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          cartController.getCart().length == 0
              ? Center(
                  child: Text("Savat bo'sh"),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: cartController.getCart().length,
                    itemBuilder: (ctx, index) {
                      price += cartController.getCart()[index].product.price *
                          cartController.getCart()[index].amount;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          width: double.infinity,
                          height: 170,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${cartController.getCart()[index].product.title}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 110,
                                    width: 110,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: NetworkImage(cartController
                                                .getCart()[index]
                                                .product
                                                .imgs![0]))),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Product Amount: ${cartController.getCart()[index].amount}"),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          "Products Price \$${cartController.getCart()[index].product.price}"),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          "Products total Price \$${cartController.getCart()[index].product.price * cartController.getCart()[index].amount}"),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
      bottomNavigationBar: cartController.getCart().length == 0 ? SizedBox() : Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: InkWell(
          onTap: (){
            cartController.addOrderProducts();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderedProducts()));
          },
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(25),
            ),
            alignment: Alignment.center,
            child: Text(
              "Total Price \$${price}",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
