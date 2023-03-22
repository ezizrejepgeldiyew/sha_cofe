import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_kofe/provider/menu_provider.dart';
import 'package:sa_kofe/view/menu/components/category/category.dart';
import 'package:sa_kofe/view/menu/components/category/category_loading.dart';
import 'package:sa_kofe/view/widgets/search.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future getCategories() async {
      final provider = Provider.of<MenuProvider>(context, listen: true);
      final categories = await provider.getCategory();
      return categories;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const SearchWidget(),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                FutureBuilder(
                  future: getCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Category(categories: snapshot.data);
                    } else {
                      return const CategoryLoading();
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
