import 'package:dars_45_home/controllers/cart_controller.dart';
import 'package:dars_45_home/controllers/products_controller.dart';
import 'package:dars_45_home/controllers/rooms_controller.dart';
import 'package:dars_45_home/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx){
            return RoomsController();
          },
        ),
        ChangeNotifierProvider(
          create: (ctx){
            return ProductsController();
          },
        ),
        ChangeNotifierProvider(
          create: (ctx){
            return CartController();
          },
        )
      ],
      builder: (context,child){
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomeScreen()
        );
      },
    );
  }
}
