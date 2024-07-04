import 'package:dars_45_home/controllers/products_controller.dart';
import 'package:dars_45_home/models/product.dart';
import 'package:dars_45_home/views/screens/show_product.dart';
import 'package:dars_45_home/views/widgets/dialog_for_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowProducts extends StatefulWidget {
  bool isEdit;
  List<Product> products;
  ShowProducts({super.key, required this.products, this.isEdit = false});

  @override
  State<ShowProducts> createState() => _ShowProductsState();
}

class _ShowProductsState extends State<ShowProducts> {
  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductsController>(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        Product productForShow = widget.products[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShowProduct(
                  product: productForShow,
                ),
              ),
            );
          },
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage("${productForShow.imgs![0]}"),
                      fit: BoxFit.fill),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.isEdit
                          ? Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    productController
                                        .removeProduct(productForShow.id);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return DialogForProducts(
                                            isEdit: true,
                                            product: productForShow,
                                          );
                                        });
                                  },
                                  child: Icon(Icons.edit),
                                ),
                              ],
                            )
                          : SizedBox(),
                      Row(
                        children: [
                          Text(
                            '${productForShow.rating}',
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          productForShow.rating != 0
                              ? Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                )
                              : SizedBox()
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${productForShow.title}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${productForShow.price}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                            InkWell(
                              onTap: () {
                                productController.favorite(productForShow.id);
                              },
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: productForShow.isFavorite
                                          ? Colors.green
                                          : Colors.greenAccent,
                                      shape: BoxShape.circle),
                                  child: productForShow.isFavorite
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : Icon(Icons.favorite_border)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
