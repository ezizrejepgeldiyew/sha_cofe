import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_kofe/const.dart';
import 'package:sa_kofe/provider/basket_provider.dart';
import 'package:sa_kofe/view/model/product_model.dart';
import 'package:sa_kofe/view/product_screen.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Function addBasket = Provider.of<BasketProvider>(context).addBasket;
    List basketProductIdList =
        Provider.of<BasketProvider>(context).productData;

    return Column(
      children: [
        InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(product: product),
                ));
          },
          child: CachedNetworkImage(
            imageUrl: '$baseUrl/${product.image}',
            imageBuilder: ((context, imageProvider) => Column(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 160,
                        width: 240,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover)),
                      ),
                    ),
                  ],
                )),
            placeholder: (context, url) => Material(
              elevation: 8,
              shadowColor: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.53,
                  width: MediaQuery.of(context).size.width * 0.48,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Material(
              elevation: 8,
              shadowColor: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.53,
                  width: MediaQuery.of(context).size.width * 0.48,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 120,
          width: 240,
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
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/productPage');
                  },
                  child: Text(product.name,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/subcategoryPage');
                  },
                  child: Text(
                    product.subcategoryName,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(product.priceMax,
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
                        color: basketProductIdList
                                .any((element) => element['productId'] == product.id)
                            ? Colors.green
                            : Colors.brown,
                      ),
                      height: 32,
                      width: 32,
                      child: InkWell(
                        onTap: () {
                          addBasket(product.id);
                        },
                        child: Icon(
                            basketProductIdList
                                    .any((element) => element['productId'] == product.id)
                                ? Icons.check_rounded
                                : Icons.add,
                            color: Colors.white),
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
