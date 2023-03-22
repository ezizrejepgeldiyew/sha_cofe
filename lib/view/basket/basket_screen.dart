import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_kofe/const.dart';
import 'package:sa_kofe/provider/basket_provider.dart';
import 'package:sa_kofe/view/basket/order_screen.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double sp = MediaQuery.of(context).textScaleFactor;
    Future basketProduct() async {
      final provider = Provider.of<BasketProvider>(context, listen: false);
      final basketProduct = await provider.basketProducts();
      return basketProduct;
    }

    List basketProductCount = Provider.of<BasketProvider>(context).productData;
    Function incrementProduct =
        Provider.of<BasketProvider>(context).incrementProduct;
    Function decrementProduct =
        Provider.of<BasketProvider>(context).decrementProduct;
    Function removeAll =
        Provider.of<BasketProvider>(context, listen: false).removeAll;
    Function removeAt =
        Provider.of<BasketProvider>(context, listen: false).removeAt;
    Future<double> totalPrice() async {
      var total = await Provider.of<BasketProvider>(context).totalPrice();
      return total;
    }

    Future<int> readyTime() async {
      var time = await Provider.of<BasketProvider>(context).readTime();
      return time;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Sebedim"),
        actions: [
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                removeAll();
              },
              icon: const Icon(Icons.delete_sharp),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                      future: basketProduct(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return Column(
                            children: [
                              for (int i = 0; i < snapshot.data.length; i++)
                                Card(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CachedNetworkImage(
                                            imageUrl:
                                                '$baseUrl/${snapshot.data[i].image}',
                                            imageBuilder:
                                                (context, imageProvider) {
                                              return Container(
                                                width: w * 0.36,
                                                height: h * 0.15,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover)),
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  onTap: () {
                                                    Navigator.pushNamed(context,
                                                        '/productPage');
                                                  },
                                                ),
                                              );
                                            }),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/productPage');
                                            },
                                            child: Row(
                                              children: [
                                                Text(snapshot.data[i].name,
                                                    style: TextStyle(
                                                        color: Colors.grey[700],
                                                        fontSize: sp * 20)),
                                                if (snapshot.data[i].priceMin !=
                                                    null)
                                                  Text("(Uly)",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: sp * 20)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: h * 0.01),
                                          InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, '/categoryPage');
                                              },
                                              child: Text(
                                                  snapshot
                                                      .data[i].subcategoryName,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: sp * 18))),
                                          SizedBox(height: h * 0.01),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                    '${int.parse(snapshot.data[i].priceMax) * (basketProductCount[i]['productQuantity'])} ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.brown,
                                                        fontSize: sp * 20)),
                                                Text('TMT',
                                                    style: TextStyle(
                                                        color: Colors.brown,
                                                        fontSize: sp * 20)),
                                                SizedBox(width: h * 0.01),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.white,
                                                  ),
                                                  child: IconButton(
                                                      onPressed: () {
                                                        removeAt(i);
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.grey,
                                                      )),
                                                ),
                                              ]),
                                        ],
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  incrementProduct(i);
                                                });
                                              },
                                              icon: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: const Icon(
                                                  Icons.arrow_upward_sharp,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '${basketProductCount[i]['productQuantity']}',
                                              style: TextStyle(
                                                  color: Colors.brown,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: sp * 20),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  decrementProduct(i);
                                                });
                                              },
                                              icon: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: const Icon(
                                                  Icons.arrow_downward,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          );
                        } else {
                          return const Text("Uppps");
                        }
                      }),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderScreen(),
                    ));
              },
              child: Container(
                width: double.maxFinite,
                height: h * 0.13,
                color: Colors.brown,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder(
                              future: totalPrice(),
                              builder: (context, total) {
                                return ActionWidgets(
                                    price: '${total.data}',
                                    time: "TMT",
                                    title: "Jemi");
                              }),
                          FutureBuilder(
                              future: readyTime(),
                              builder: (context, time) {
                                return ActionWidgets(
                                    price: "~${time.data}",
                                    time: "min",
                                    title: "Wagty");
                              }),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text(
                        "Sargyt et >",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActionWidgets extends StatelessWidget {
  final String title;
  final String price;
  final String time;
  const ActionWidgets(
      {Key? key, required this.price, required this.time, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sp = MediaQuery.of(context).textScaleFactor;
    return Row(
      children: [
        Text(
          '$title: ',
          style: TextStyle(color: Colors.white, fontSize: sp * 18),
        ),
        Text(
          "$price ",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: sp * 20),
        ),
        Text(
          '$time ',
          style: TextStyle(color: Colors.white, fontSize: sp * 18),
        ),
      ],
    );
  }
}
