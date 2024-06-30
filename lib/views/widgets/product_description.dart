import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  String productName;
  String productDescriptionn;
  ProductDescription({super.key,required this.productName,required this.productDescriptionn});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$productName',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
          
          SizedBox(height: 20,),
          
          Text('$productDescriptionn',style: TextStyle(color: Colors.grey,fontSize: 20),)
        ],
      ),
    );
  }
}
