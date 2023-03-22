import 'package:flutter/material.dart';
import 'package:sa_kofe/view/model/subcategory_model.dart';

class SubcategoryButton extends StatefulWidget {
  final List<SubcategoryModel> subcategories;
  const SubcategoryButton({super.key, required this.subcategories});

  @override
  State<SubcategoryButton> createState() => _SubcategoryButtonState();
}

class _SubcategoryButtonState extends State<SubcategoryButton> {
  int? activeButtonId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.15,
      width: MediaQuery.of(context).size.width * 0.18,
      child: ListView.builder(
        itemCount: widget.subcategories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () async {
                setState(() {
                  activeButtonId != widget.subcategories[index].id
                      ? activeButtonId = widget.subcategories[index].id
                      : activeButtonId = null;
                });
                // final provider =
                //     Provider.of<MenuProvider>(context, listen: false);
                // final subcategories =
                //     await provider.getSubcategoryProducts(activeButtonId!);
              },
              child: Container(
                alignment: Alignment.center,
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                    color: widget.subcategories[index].id == activeButtonId
                        ? Colors.brown
                        : Colors.white,
                    border: Border.all(color: Colors.brown),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  widget.subcategories[index].name,
                  style: TextStyle(
                    fontSize: 22,
                    color: widget.subcategories[index].id != activeButtonId
                        ? Colors.brown
                        : Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
