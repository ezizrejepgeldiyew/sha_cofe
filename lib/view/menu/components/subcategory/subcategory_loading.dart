import 'package:flutter/material.dart';
import 'package:sa_kofe/view/menu/components/subcategory/subcategory_button_loading.dart';
import 'package:sa_kofe/view/menu/components/subcategory/subcategory_product_loading_cart.dart';

class SubcategoryLoading extends StatelessWidget {
  final String title;
  const SubcategoryLoading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
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
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                  child: SubcategoryButtonLoading(),
                ),
                Wrap(
                  children: [
                    for (int i = 0; i < 5; i++)
                      const Padding(
                        padding: EdgeInsets.only(left: 5, right: 3, top: 5),
                        child: InkWell(
                          child: SubcategoryProductLoadingCart(),
                        ),
                      )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
