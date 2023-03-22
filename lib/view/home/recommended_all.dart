import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_kofe/provider/main_provider.dart';
import 'package:sa_kofe/view/menu/components/subcategory/subcategory_product_cart.dart';
import 'package:sa_kofe/view/menu/components/subcategory/subcategory_product_loading_cart.dart';

class RecommendedAll extends StatelessWidget {
  final String title;
  const RecommendedAll({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    Future getRecommmendedProducts() async {
      final provider = Provider.of<MainProvider>(context);
      final products = await provider.recommendedProducts();
      return products;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(title),
        actions: [
          Container(
            alignment: Alignment.centerRight,
            child: const Icon(Icons.filter_alt_sharp),
          )
        ],
      ),
      body: SizedBox(
        height: 730,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            //productCart
            FutureBuilder(
              future: getRecommmendedProducts(),
              builder: ((context, snapshot) {
                if (snapshot.data != null) {
                  return Wrap(
                    children: [
                      for (int i = 0; i < snapshot.data.length; i++)
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 5, right: 3, top: 5),
                          child: InkWell(
                            child: SubcategoryProductCart(
                                products: snapshot.data[i]),
                          ),
                        )
                    ],
                  );
                } else {
                  return Wrap(
                    children: [
                      for (int i = 0; i < 5; i++)
                        const Padding(
                          padding: EdgeInsets.only(left: 5, right: 3, top: 5),
                          child: InkWell(
                            child: SubcategoryProductLoadingCart(),
                          ),
                        )
                    ],
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
