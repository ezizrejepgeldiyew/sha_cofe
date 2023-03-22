import 'package:flutter/material.dart';
import 'package:sa_kofe/view/menu/components/category/category_loading_card.dart';

class CategoryLoading extends StatelessWidget {
  const CategoryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 730,
      child: ListView(
        children: [
          Wrap(
            children: [
              for(int i=0; i<10; i++) const Padding(
                padding:  EdgeInsets.only(left: 5, right: 3, top: 5),
                child:  CategoryLoadingCard(),
              )
            ],
          )
        ],
      ),
    );
  }
}