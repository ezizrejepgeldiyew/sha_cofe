import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_kofe/provider/menu_provider.dart';
import 'package:sa_kofe/view/menu/components/subcategory/subcategory_button_loading.dart';
import 'package:sa_kofe/view/menu/components/subcategory/subcategory_product_cart.dart';
import 'package:sa_kofe/view/menu/components/subcategory/subcategory_product_loading_cart.dart';

class Subcategory extends StatefulWidget {
  final String title;
  final int categoryId;
  final int? subcategoryId;
  const Subcategory(
      {super.key,
      required this.title,
      required this.categoryId,
      this.subcategoryId});

  @override
  State<Subcategory> createState() => _SubcategoryState();
}

class _SubcategoryState extends State<Subcategory> {
  int? activeButtonId;
  @override
  Widget build(BuildContext context) {
    Future getCategoryProducts() async {
      if (widget.subcategoryId != null) activeButtonId = widget.subcategoryId;
      final provider = Provider.of<MenuProvider>(context);
      final products =
          await provider.getCategoryProducts(widget.categoryId, activeButtonId);
      return products;
    }

    Future getSubcategories() async {
      final provider = Provider.of<MenuProvider>(context, listen: false);
      final subcategories = await provider.getSubcategory(widget.categoryId);
      return subcategories;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(widget.title),
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
            //subcategoryButton
            FutureBuilder(
              future: getSubcategories(),
              builder: ((context, snapshot) {
                if (snapshot.data != null) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * 0.15,
                      width: MediaQuery.of(context).size.width * 0.18,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  activeButtonId != snapshot.data[index].id
                                      ? activeButtonId = snapshot.data[index].id
                                      : activeButtonId = null;
                                });
                                final provider = Provider.of<MenuProvider>(
                                    context,
                                    listen: false);
                                await provider.getCategoryProducts(
                                    widget.categoryId, activeButtonId);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: snapshot.data[index].id ==
                                            activeButtonId
                                        ? Colors.brown
                                        : Colors.white,
                                    border: Border.all(color: Colors.brown),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  snapshot.data[index].name,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: snapshot.data[index].id !=
                                            activeButtonId
                                        ? Colors.brown
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return const Padding(
                      padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                      child: SubcategoryButtonLoading());
                }
              }),
            ),

            //productCart
            FutureBuilder(
              future: getCategoryProducts(),
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
