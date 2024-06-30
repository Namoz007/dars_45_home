import 'package:dars_45_home/views/screens/admin_panel.dart';
import 'package:dars_45_home/views/screens/home_screen.dart';
import 'package:dars_45_home/views/screens/ordered_products.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 20,),
          ListTile(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            title: Text("Products"),
            trailing: Icon(Icons.navigate_next),
          ),

          SizedBox(height: 10,),

          ListTile(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderedProducts()));
            },
            title: Text("Ordered Products"),
            trailing: Icon(Icons.navigate_next),
          ),

          SizedBox(height: 10,),

          ListTile(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminPanel()));
            },
            title: Text("Admin Panel"),
            trailing: Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}
