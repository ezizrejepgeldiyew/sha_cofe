import 'package:flutter/material.dart';
import 'package:sa_kofe/view/home/components/product/product_card.dart';
import 'package:sa_kofe/view/model/product_model.dart';

class Product extends StatelessWidget {
  final List<ProductModel> products;
  const Product({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 312,
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) =>  Padding(
            padding:const  EdgeInsets.all(8.0),
            child:  ProductCard(product: products[index]),
          ),
        ));
  }
}
