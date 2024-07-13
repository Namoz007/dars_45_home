import 'package:dars_45_home/controllers/products_controller.dart';
import 'package:dars_45_home/models/product.dart';
import 'package:dars_45_home/views/widgets/custom_drawer.dart';
import 'package:dars_45_home/views/widgets/dialog_for_products.dart';
import 'package:dars_45_home/views/widgets/show_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    final productsController = Provider.of<ProductsController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => DialogForProducts(isEdit: false),
                barrierDismissible: false,
              );
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: StreamBuilder(
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
          return response == null ? Center(child: Text("Hozircha ma'lumotlar yo'q"),) : ShowProducts(products: products,isEdit: true,);
        },
      )
    );
  }
}
