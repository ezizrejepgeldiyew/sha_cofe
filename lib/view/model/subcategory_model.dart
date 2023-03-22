import 'dart:convert';

List<SubcategoryModel> subcategoryListFromJson(String value) =>
    List<SubcategoryModel>.from(json.decode(value)['subcategory'].map(
        (subcategory) => SubcategoryModel.subcategoryFromJson(subcategory)));

class SubcategoryModel {
  final int id;
  final String name;

  SubcategoryModel({required this.id, required this.name});

  factory SubcategoryModel.subcategoryFromJson(Map<String, dynamic> data) =>
      SubcategoryModel(id: data['id'], name: data['name']);
}
