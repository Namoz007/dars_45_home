import 'package:flutter/material.dart';


class ShowImg extends StatelessWidget {
  String imgUrl;
  ShowImg({super.key,required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
        image: DecorationImage(
          image: NetworkImage("$imgUrl"),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
