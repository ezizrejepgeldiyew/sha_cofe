import 'dart:convert';

List<CategoryModel> categoryListFromJson(String value) => List<CategoryModel>.from(
      json.decode(value)['category'].map(
            (category) => CategoryModel.categoryFromJson(category),
          ),
    );

class CategoryModel {
  final int id;
  final String name;
  final String image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryModel.categoryFromJson(Map<String, dynamic> data) =>
      CategoryModel(id: data['id'], name: data['name'], image: data['photo']);
}
