import 'package:flutter/material.dart';
import 'package:sa_kofe/view/home/components/product/product_loading_card.dart';

class ProductLoading extends StatelessWidget {
  const ProductLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 312,
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 15,
          itemBuilder: (context, index) => const Padding(
            padding:  EdgeInsets.all(8.0),
            child: ProductLoadingCard(),
          ),
        ));
  }
}
