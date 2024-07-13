import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_45_home/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class ProductServices {
  final _productApi = FirebaseFirestore.instance.collection("products");
  final _carsImageStorage = FirebaseStorage.instance.ref();

  Future<void> removeProduct(String globalid) async{
    await _productApi.doc(globalid).delete();
  }

  Stream<QuerySnapshot> getProducts() async* {
    yield* _productApi.snapshots();
  }

  Future<void> likeProduct(String globalId,bool like) async{
    await _productApi.doc(globalId).update({
      "isFavorite": !like
    });
  }

  Future<void> editProduct(Product product) async{
    _productApi.doc(product.globalId).update(
      {
        "globalId": product.globalId,
        "id": product.id,
        "price": product.price,
        "imgs": product.imgs,
        "rating": product.rating,
        "description": product.description,
        "isFavorite": product.isFavorite,
        "status": product.status,
        "title":product.title
      }
    );
  }

  Future<void> addProduct(Product product, List<File> imgs) async {
    final imageReference = _carsImageStorage.child("products");
    for (int i = 0; i < imgs.length; i++) {
      final uploadTask = imageReference
          .child("${product.title}${Random().nextInt(100000)}")
          .putFile(imgs[i]);

      final taskSnapshot = await uploadTask;
      final downloadURL = await taskSnapshot.ref.getDownloadURL();
      String url = downloadURL.toString();
      product.imgs!.add(url);
    }
    final response = await _productApi.add({
      "globalId": "",
      "id": product.id,
      "price": product.price,
      "imgs": product.imgs,
      "rating": product.rating,
      "description": product.description,
      "isFavorite": product.isFavorite,
      "status": product.status,
      "title":product.title
    });
    await _productApi.doc("${response.id}").update({
      "globalId":response.id
    });
  }
}
