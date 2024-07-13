import 'dart:math';

import 'package:dars_45_home/controllers/products_controller.dart';
import 'package:dars_45_home/models/product.dart';
import 'package:dars_45_home/views/widgets/bottom_navigation_elements.dart';
import 'package:dars_45_home/views/widgets/product_description.dart';
import 'package:dars_45_home/views/widgets/rating.dart';
import 'package:dars_45_home/views/widgets/show_img.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowProduct extends StatefulWidget {
  Product product;
  ShowProduct({super.key,required this.product});

  @override
  State<ShowProduct> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ShowProduct> {
  int selectImg = 0;
  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductsController>(context);
    // print(product.title);
    // final controlerProduct = productController.getProducts().where((element) => element.id == widget.product.id);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        actions: [
          Icon(
            Icons.share,
            color: Colors.grey,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: ShowImg(imgUrl: widget.product.imgs![0]),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Text(
                                "${widget.product.title}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Text(
                            'Price',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          // SizedBox(height: 10,),
                          Text(
                            '\$${widget.product.price}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.greenAccent),
                          ),

                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Choose img!",
                            style: TextStyle(fontSize: 16),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              for (int i = 0; i < widget.product.imgs!.length; i++)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectImg = i;
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              Random().nextInt(255),
                                              Random().nextInt(255),
                                              Random().nextInt(255),
                                              100),
                                          shape: BoxShape.circle),
                                    ),
                                  ),
                                )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Rating(),
              SizedBox(
                height: 30,
              ),
              ProductDescription(
                  productName: widget.product.title,
                  productDescriptionn: widget.product.description),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: widget.product.isFavorite ? Colors.green : Colors.grey.shade300,
                      shape: BoxShape.circle
                    ),
                    child: IconButton(
                      onPressed: () async{
                        productController.likeProduct(widget.product.globalId, widget.product.isFavorite);
                      },
                      icon: 
                          widget.product.isFavorite ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                        size: 40,
                            )
                          : Icon(Icons.favorite,color: Colors.white,size: 40,),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: BottomNavigationElements(product: widget.product,)
      ),
    );
  }
}
