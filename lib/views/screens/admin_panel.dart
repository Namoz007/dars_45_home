import 'package:dars_45_home/controllers/products_controller.dart';
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
          IconButton(onPressed: (){
            showDialog(context: context, builder: (ctx) => DialogForProducts(isEdit: false));
          }, icon: Icon(Icons.add),)
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ShowProducts(products: productsController.getProducts(),isEdit: true,),
            ),
          ],
        ),
      ),
    );
  }
}
