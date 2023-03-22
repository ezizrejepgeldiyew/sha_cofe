import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sa_kofe/const.dart';
import 'package:sa_kofe/view/model/product_model.dart';

class SubcategoryProductCart extends StatelessWidget {
  final ProductModel products;
  const SubcategoryProductCart({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: '$baseUrl/${products.image}',
          imageBuilder: (context, imageProvider) => Material(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            child: Container(
              height: MediaQuery.of(context).size.width * 0.53,
              width: MediaQuery.of(context).size.width * 0.48,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width * 0.30,
          width: MediaQuery.of(context).size.width * 0.48,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(products.name,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(
                  products.categoryName,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(products.priceMax,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.brown,
                            fontWeight: FontWeight.bold)),
                    const Text(
                      'TMT',
                      style: TextStyle(fontSize: 18, color: Colors.brown),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.brown,
                      ),
                      height: 32,
                      width: 32,
                      child: const InkWell(
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
