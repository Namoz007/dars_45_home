import 'dart:io';

import 'package:dars_45_home/controllers/products_controller.dart';
import 'package:dars_45_home/models/product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DialogForProducts extends StatefulWidget {
  bool isEdit;
  Product? product;
  DialogForProducts({super.key, required this.isEdit, this.product});

  @override
  State<DialogForProducts> createState() => _DialogForProductsState();
}

class _DialogForProductsState extends State<DialogForProducts> {
  final _formKey = GlobalKey<FormState>();
  final productTitle = TextEditingController();
  final productPrice = TextEditingController();
  List<File> imgs = [];
  final productRating = TextEditingController();
  final productDescription = TextEditingController();
  String productStatus = 'Product Status';
  String? error;
  int count = 0;

  void openGallery() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      requestFullMetadata: false,
    );

    if (pickedImage != null) {
      setState(() {
        imgs.add(File(pickedImage.path));
      });
    }
  }

  void openCamera() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      requestFullMetadata: false,
    );

    if (pickedImage != null) {
      setState(() {
        imgs.add(File(pickedImage.path));
        // imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsController = Provider.of<ProductsController>(context);
    return AlertDialog(
      title: widget.isEdit ? Text("Edit Product") : Text("Add Product"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: error != null
                    ? Text(
                        "$error",
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      )
                    : SizedBox(),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please,return product title";

                  return null;
                },
                controller: productTitle,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: widget.isEdit
                        ? "${widget.product!.title}"
                        : "Product Title"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please, return product price";

                  try {
                    double price = double.parse(value.trim());

                    if (price < 0) {
                      return "Price minimum 0.1";
                    }

                    return null;
                  } catch (e) {
                    return "Product price not number";
                  }
                },
                controller: productPrice,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: widget.isEdit
                        ? "${widget.product!.price}"
                        : "Product price"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please,return enter product rating";

                  try {
                    double rating = double.parse(value.trim());

                    if (rating < 0) return "Product rating min 0.1";
                    return null;
                  } catch (e) {
                    return "Product rating not number";
                  }
                },
                controller: productRating,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: widget.isEdit
                        ? "${widget.product!.rating}"
                        : "Product rating"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please,return enter product description";

                  return null;
                },
                controller: productDescription,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: widget.isEdit
                        ? "${widget.product!.description}"
                        : "Product description"),
              ),
              SizedBox(
                height: 20,
              ),
              ExpansionTile(
                onExpansionChanged: (value) {
                  productStatus = value.toString();
                  setState(() {});
                },
                title: Text("$productStatus"),
                children: [
                  for (int i = 0;
                      i < productsController.getStatus().length;
                      i++)
                    InkWell(
                      onTap: () {
                        setState(() {
                          productStatus = productsController.getStatus()[i];
                        });
                      },
                      child: Text("${productsController.getStatus()[i]}"),
                    )
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: openGallery,
                        icon: Icon(Icons.photo),
                      ),
                      IconButton(
                        onPressed: openCamera,
                        icon: Icon(Icons.camera),
                      ),
                    ],
                  ),
                  Text("Imgs count: ${imgs.length} / 3")
                ],
              )
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        imgs.length == 3
            ? ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (productStatus != "Poduct Status") {
                      error = null;
                      productsController.addProductInFirebase(
                        Product(
                            globalId: '',
                            id: 1,
                            title: productTitle.text,
                            price: double.parse(productPrice.text),
                            imgs: [],
                            isFavorite: false,
                            rating: double.parse(productRating.text),
                            description: productDescription.text,
                            status: productStatus),
                        imgs,
                      );
                    } else {
                      setState(() {
                        error = "Please,retunr choose product status";
                      });
                    }
                  }
                },
                child: Text("Save"),
              )
            : SizedBox()
      ],
    );
  }
}
