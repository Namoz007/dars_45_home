import 'dart:async';

import 'package:dars_45_home/controllers/rooms_controller.dart';
import 'package:dars_45_home/models/room.dart';
import 'package:dars_45_home/views/screens/show_room_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowRooms extends StatefulWidget {
  const ShowRooms({super.key});

  @override
  State<ShowRooms> createState() => _ShowRoomsState();
}

class _ShowRoomsState extends State<ShowRooms> {
  int _currentIndex = 0;
  late ScrollController _scrollController;
  late Timer _timer;

  void _scroolToIndex(int index) {
    _scrollController.animateTo(MediaQuery.of(context).size.width - 40,
        duration: const Duration(seconds: 3), curve: Curves.linear);
  }

  late List<Widget> items;

  void initState(){
    super.initState();
    _scrollController = ScrollController();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_currentIndex < items.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
        setState(() {

        });
      }
      _scroolToIndex(_currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final roomsController = Provider.of<RoomsController>(context);
    items = [
      for(int i = 0;i < roomsController.getRooms().length;i++)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ShowRoomProduct(room: roomsController.getRooms()[i])));
            },
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width - 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  // color: Colors.grey
                border: Border.all(color: Colors.grey),
                image: DecorationImage(
                  image: NetworkImage("${roomsController.getRooms()[i].img}"),
                  fit: BoxFit.fill
                ),
              ),
              alignment: Alignment.center,
              child: Text("${roomsController.getRooms()[i].name}",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
            ),
          ),
        )
    ];
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for(int i = 0;i < items.length;i++)
            items[i]
        ],
      ),
    );
  }
}
