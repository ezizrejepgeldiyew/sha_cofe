import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryLoadingCard extends StatelessWidget {
  const CategoryLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
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
        const Text("category name",
            style: TextStyle(color: Colors.grey, fontSize: 18))
      ],
    );
  }
}
