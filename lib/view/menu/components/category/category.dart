import 'package:flutter/material.dart';
import 'package:sa_kofe/view/menu/components/category/category_card.dart';
import 'package:sa_kofe/view/model/category_model.dart';

class Category extends StatelessWidget {
  final List<CategoryModel> categories;
  const Category({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 730,
      child: ListView(
        children: [
          Wrap(
            children: [
              for (int i = 0; i < categories.length; i++)
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 3, top: 5),
                  child: 
                  InkWell(
                    onTap: () {
                    },
                    child: CategoryCard(category: categories[i]),
                  ),
                )
            ],
          )
        ],
      ),
    );
  }
}
