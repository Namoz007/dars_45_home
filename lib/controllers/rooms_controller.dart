import 'package:dars_45_home/models/room.dart';
import 'package:flutter/cupertino.dart';

class RoomsController extends ChangeNotifier{
  List<Room> _roms = [
    Room(id: 1, img: 'https://i.pinimg.com/originals/76/e3/13/76e313117f92ca87aaf7ced78ae104a6.jpg', name: 'Living Room', status: 'living room'),
    Room(id: 2, img: 'https://sc02.alicdn.com/kf/HTB17kxkowmTBuNjy1Xbq6yMrVXaE.jpg', name: 'Kitchen', status: 'kitchen'),
    Room(id: 3, img: 'https://cdn10.bigcommerce.com/s-hzhj1uyk/product_images/theme_images/luxury_master_bath.jpg', name: 'Bathroom', status: 'bathroom'),
  ];

  List<Room> getRooms(){
    return [..._roms];
  }

  void addRoom(Room room){
    _roms.add(room);
    notifyListeners();
  }

  void removeRoom(int id){
    _roms.removeWhere((element) => element.id == id);
    notifyListeners();
  }


}