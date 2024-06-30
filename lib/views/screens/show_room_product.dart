import 'package:dars_45_home/controllers/products_controller.dart';
import 'package:dars_45_home/models/room.dart';
import 'package:dars_45_home/views/widgets/show_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ShowRoomProduct extends StatefulWidget {
  Room room;
  ShowRoomProduct({super.key,required this.room});

  @override
  State<ShowRoomProduct> createState() => _ShowRoomProductState();
}

class _ShowRoomProductState extends State<ShowRoomProduct> {
  @override
  Widget build(BuildContext context) {
    final productsController = Provider.of<ProductsController>(context);
    print(productsController.getProductWithStauts(widget.room.status).length);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("${widget.room.img}"),
                  fit: BoxFit.fill
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back,color: Colors.white,),),
                  Center(child: Text("${widget.room.name}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),)),
                  SizedBox()
                ],
              ),
            ),
            SizedBox(height: 10,),
            Text('Have ${productsController.getProductWithStauts(widget.room.status).length} products',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ShowProducts(products: productsController.getProductWithStauts(widget.room.status)),
            ),
          ],
        ),
      ),
    );
  }
}
