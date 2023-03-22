import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sa_kofe/provider/main_provider.dart';
import 'package:sa_kofe/provider/menu_provider.dart';
import 'package:sa_kofe/view/dashboard_screen.dart';
import 'package:sa_kofe/view/home/components/bron/bron.dart';
import 'package:sa_kofe/view/home/components/carousel_slider/carousel_loading.dart';
import 'package:sa_kofe/view/home/components/carousel_slider/carousel_slider_view.dart';
import 'package:sa_kofe/view/home/components/product/product.dart';
import 'package:sa_kofe/view/home/components/product/product_loading.dart';
import 'package:sa_kofe/view/home/recommended_all.dart';
import 'package:sa_kofe/view/menu/components/subcategory/subcategory.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future getBanners() async {
      final prov = Provider.of<MainProvider>(context, listen: true);
      final banners = await prov.banner();
      return banners;
    }

    Future getPopularProducts() async {
      final prov = Provider.of<MainProvider>(context, listen: true);
      final popularProducts = await prov.popularProducts();
      return popularProducts;
    }

    Future getRecommendedProducts() async {
      final prov = Provider.of<MainProvider>(context, listen: true);
      final recommendedProducts = await prov.recommendedProducts();
      return recommendedProducts;
    }

    Future getCategory() async {
      final provider = Provider.of<MenuProvider>(context);
      final category = await provider.getCategory();
      return category;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.brown,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.place)),
        centerTitle: true,
        title: SvgPicture.asset('assets/shacoffee-light.svg',
            width: 50, height: 50, color: Colors.white),
        actions: [
          IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () {
                null;
              }),
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                null;
              }),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          FutureBuilder(
              future: getBanners(),
              builder: (context, snap) {
                if (snap.data != null) {
                  return CarouselSliderView(bannerList: snap.data);
                } else {
                  return const CarouselLoading();
                }
              }),

          //buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardScreen(index: 1),
                      ));
                },
                child: const HomePageButton(
                    iconButton: Icons.menu, titleButton: "Menyu", hor: 40),
              ),
              MaterialButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Bron(),
                        ));
                  },
                  child: const HomePageButton(
                      iconButton: Icons.calendar_month,
                      titleButton: "Bron etmek",
                      hor: 30)),
            ],
          ),

          //popular products
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  "Köp satylanlar",
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          FutureBuilder(
              future: getPopularProducts(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Product(products: snapshot.data);
                } else {
                  return const ProductLoading();
                }
              }),

          //recommended products
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: textButton(context, "Size maslahat berilyar", null),
              ),
              allPageButton(context, "Size maslahat berilyar", null),
            ],
          ),
          FutureBuilder(
              future: getRecommendedProducts(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Product(products: snapshot.data);
                } else {
                  return const ProductLoading();
                }
              }),

          //category products
          FutureBuilder(
              future: getCategory(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Column(
                    children: [
                      for (int i = 0; i < snapshot.data.length; i++)
                        CategoryProducts(
                          title: snapshot.data[i].name,
                          categoryId: snapshot.data[i].id,
                        )
                    ],
                  );
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }

  }

class CategoryProducts extends StatelessWidget {
  final String title;
  final int categoryId;
  const CategoryProducts(
      {super.key, required this.title, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    Future getCategoryProducts() async {
      final provider = Provider.of<MainProvider>(context, listen: true);
      final categoryProducts = await provider.categoryProducts(categoryId);
      return categoryProducts;
    }

    return FutureBuilder(
        future: getCategoryProducts(),
        builder: (context, items) {
          if (items.data != null) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: textButton(context, title, categoryId)
                    ),
                    allPageButton(context, title, categoryId)
                  ],
                ),
                Product(products: items.data)
              ],
            );
          } else {
            return Container();
          }
        });
  }
}

class HomePageButton extends StatelessWidget {
  final IconData iconButton;
  final String titleButton;
  final int hor;
  const HomePageButton(
      {Key? key,
      required this.iconButton,
      required this.titleButton,
      required this.hor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: hor.toDouble()),
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.grey,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconButton,
            color: Colors.brown,
          ),
          const SizedBox(width: 5),
          Text(
            titleButton,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

MaterialButton allPageButton(BuildContext context, String title, int? id) {
  return MaterialButton(
    onPressed: () {
      Navigator.push(
        context,
        id != null
            ? MaterialPageRoute(
                builder: (context) => Subcategory(title: title, categoryId: id),
              )
            : MaterialPageRoute(
                builder: (context) => RecommendedAll(
                  title: title,
                ),
              ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.grey,
            )),
        child: Row(
          children: [
            Text(
              'Hemmesi',
              style: TextStyle(color: Colors.grey[600]),
            ),
            Icon(
              Icons.chevron_right_outlined,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    ),
  );
}

TextButton textButton(BuildContext context, String title, int? id) {
    return TextButton(
      onPressed: () => Navigator.push(
        context,
        id != null
            ? MaterialPageRoute(
                builder: (context) => Subcategory(title: title, categoryId: id),
              )
            : MaterialPageRoute(
                builder: (context) => RecommendedAll(
                  title: title,
                ),
              ),
      ),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.grey[700], fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
