import 'package:dars_45_home/controllers/cart_controller.dart';
import 'package:dars_45_home/controllers/products_controller.dart';
import 'package:dars_45_home/controllers/rooms_controller.dart';
import 'package:dars_45_home/firebase_options.dart';
import 'package:dars_45_home/views/screens/home_screen.dart';
import 'package:dars_45_home/views/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "name-here",
      options: DefaultFirebaseOptions.currentPlatform
  );
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
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }

                if (snapshot.hasError)
                  return const Text(
                    "Xatolik kelilb chiqdi",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  );

                print("Bu snapshotdan kelayotgan malumot $snapshot");

                return snapshot.data == null ? const LoginScreen() : const HomeScreen();
              },
            )
        );
      },
    );
  }
}
