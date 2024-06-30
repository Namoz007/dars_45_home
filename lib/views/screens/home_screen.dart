import 'package:dars_45_home/controllers/cart_controller.dart';
import 'package:dars_45_home/controllers/products_controller.dart';
import 'package:dars_45_home/models/product.dart';
import 'package:dars_45_home/views/screens/check_out_cart.dart';
import 'package:dars_45_home/views/widgets/custom_drawer.dart';
import 'package:dars_45_home/views/widgets/show_categories.dart';
import 'package:dars_45_home/views/widgets/show_products.dart';
import 'package:dars_45_home/views/widgets/show_rooms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final productsController = Provider.of<ProductsController>(context);
    final products = productsController.getProducts();
    final cartController = Provider.of<CartController>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ShowRooms(),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ShowCategories(),
              ),
              SizedBox(height: 20),
              ShowProducts(products: products,)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOutCart()));
        },
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.shopping_cart,color: Colors.white,size: 35,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Text('${cartController.getCart().length}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
