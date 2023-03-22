import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sa_kofe/const.dart';
import 'package:sa_kofe/view/menu/components/subcategory/subcategory.dart';
import 'package:sa_kofe/view/model/product_model.dart';
import 'package:sa_kofe/view/widgets/search.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool _current = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const SearchWidget(),
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                child: Column(
                  children: [
                    SizedBox(
                      height: 320,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl: '$baseUrl/${widget.product.image}',
                            imageBuilder: (context, imageProvider) => Material(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: 200,
                                width: 380,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              widget.product.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                color: Colors.grey[700],
                              ),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                setState(() {
                                  _current == false
                                      ? _current = true
                                      : _current = false;
                                });
                              },
                              child: Icon(
                                Icons.favorite,
                                size: 35,
                                color:
                                    _current == true ? Colors.red : Colors.grey,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Subcategory(
                                              title:
                                                  widget.product.categoryName,
                                              categoryId:
                                                  widget.product.categoryId),
                                        ));
                                  },
                                  child: CardTextWidget(
                                      title: widget.product.categoryName),
                                ),
                                const CardTextWidget(title: ' > '),
                                InkWell(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Subcategory(
                                              title:
                                                  widget.product.categoryName,
                                              categoryId:
                                                  widget.product.categoryId,
                                              subcategoryId:
                                                  widget.product.subcategoryId),
                                        ));
                                  },
                                  child: CardTextWidget(
                                      title: widget.product.subcategoryName),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 15),
                            child: SizedBox(
                              child: Row(
                                children: [
                                  const CardTextWidget(
                                    title: "Duzumi:",
                                  ),
                                  CardTextWidget(
                                      title: " ${widget.product.composition}")
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.product.priceMin != null)
              PriceCard(
                  price: "${widget.product.priceMin}",
                  time: "${widget.product.readyTimeMin}",
                  title: "Kici"),
            PriceCard(
                price: widget.product.priceMax,
                time: widget.product.readyTimeMax,
                title: "Uly"),

            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Card(
                child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/profilPage');
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.login_rounded,
                        color: Colors.brown,
                      ),
                      title: CardTextWidget(title: "Hasabyma gir"),
                    )),
              ),
            ),
            const SizedBox(height: 15),
            // const Categores(scrollId: 0, title: "Menzesler"),
            const SizedBox(height: 15),
            // const Categores(scrollId: 0, title: "Yakynda gorlenler"),
          ],
        ),
      ),
    );
  }
}

class PriceCard extends StatefulWidget {
  final String price;
  final String title;
  final String time;
  const PriceCard({
    Key? key,
    required this.price,
    required this.title,
    required this.time,
  }) : super(key: key);

  @override
  State<PriceCard> createState() => _PriceCardState();
}

class _PriceCardState extends State<PriceCard> {
  bool _currentPrice = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 12,
      ),
      child: Card(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 60,
          child: ListTile(
            leading: Text(
              "${widget.price} TMT",
              style: const TextStyle(color: Colors.brown, fontSize: 20),
            ),
            title:
                CardTextWidget(title: "${widget.title} . ${widget.time} min"),
            trailing: SizedBox(
              width: 30,
              height: 30,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _currentPrice = true;
                  });
                },
                child: _currentPrice == false
                    ? const Icon(
                        Icons.add_circle,
                        color: Colors.brown,
                        size: 33,
                      )
                    : const Icon(
                        Icons.check_circle_sharp,
                        color: Colors.green,
                        size: 33,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardTextWidget extends StatelessWidget {
  final String title;
  const CardTextWidget({Key? key, required this.title})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: Colors.grey[700], fontSize: 17),
    );
  }
}
