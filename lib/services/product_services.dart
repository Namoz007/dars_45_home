import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_45_home/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class ProductServices{
  final _productApi = FirebaseFirestore.instance.collection("products");
  final _carsImageStorage = FirebaseStorage.instance.ref();

  Stream<QuerySnapshot> getProducts() async*{
    yield* _productApi.snapshots();
  }


  Future<void> addProduct(Product product,List<File> imgs) async {
    final imageReference = _carsImageStorage
        .child("products");

    for (int i = 0; i < imgs.length; i++) {
      final uploadTask = imageReference.child("${UniqueKey()}").putFile(
        imgs[i],
      );

      uploadTask.whenComplete(() {
        final data = imageReference.getDownloadURL();
        print(data);
      });


      // product.imgs!.add(data);
    }

    final uploadTask = await imageReference.child("${imgs[0]}").putFile(
      imgs[0],
    );

    final data = await imageReference.getDownloadURL();
    product.imgs!.add(data);

    final response = await _productApi.add({
      "globalid":"",
      "id": product.id,
      "price":product.price,
      "imgs": product.imgs,
      "rating": product.rating,
      "description": product.description,
      "isFavorite": product.isFavorite,
      "status": product.status,
    });


    print("qaytgan malumot ${response.id}");
  }

}