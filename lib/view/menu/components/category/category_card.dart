import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sa_kofe/const.dart';
import 'package:sa_kofe/view/menu/components/subcategory/subcategory.dart';
import 'package:sa_kofe/view/model/category_model.dart';
import 'package:shimmer/shimmer.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '$baseUrl/${category.image}',
      imageBuilder: ((context, imageProvider) => Column(
            children: [
              Material(
                elevation: 8,
                shadowColor: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Subcategory(
                                title: category.name,
                                categoryId: category.id))));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.53,
                    width: MediaQuery.of(context).size.width * 0.48,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(category.name,
                  style: const TextStyle(color: Colors.grey, fontSize: 18))
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
    );
  }
}
