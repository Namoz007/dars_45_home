import 'package:flutter/material.dart';

class ShowCategories extends StatelessWidget {
  const ShowCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.green
          ),
          alignment: Alignment.center,
          child: Text('Popular',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
        ),

        SizedBox(width: 20,),

        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Text('New',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey),),
              SizedBox(width: 20,),

              Text('Best Stiling',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey),),
              SizedBox(width: 20,),

              Text('Formans',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey),),

            ],
          ),
        )

      ],
    );
  }
}
