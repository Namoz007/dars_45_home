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
    // final products = productsController.getProducts();
    final cartController = Provider.of<CartController>(context);
    // productsController.getProducts();


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

              StreamBuilder(
                stream: productsController.getProducts,
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(color: Colors.red,),);
                  }

                  if(snapshot.hasError){
                    return Center(child: Text("Malumot olishda hatolik yuzaga keldi",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red),),);
                  }

                  final response = snapshot.data!.docs;
                  List<Product> products = [];
                  if(snapshot != null){
                    products = snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return Product.fromJson(data);
                    }).toList();
                  }
                  return response == null ? Center(child: Text("Hozircha ma'lumotlar yo'q"),) : ShowProducts(products: products);
                },
              )
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
