import 'package:flutter/material.dart';


class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            for(int i = 0;i < 5;i++)
              Icon(Icons.star,color: Colors.amber,),
            SizedBox(width: 10,),
            Text('5.0',style: TextStyle(color: Colors.amber,fontSize: 18,fontWeight: FontWeight.bold),),
          ],
        ),

        Row(
          children: [
            Text('124 reviews',style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),),

            Icon(Icons.chevron_right_sharp,color: Colors.grey,)
          ],
        )
      ],
    );
  }
}
