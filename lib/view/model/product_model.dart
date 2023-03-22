import 'dart:convert';

List<ProductModel> productListFromJson(String value) => List<ProductModel>.from(
      json.decode(value)['product'].map(
            (product) => ProductModel.productFromJson(product),
          ),
    );

class ProductModel {
  final int id;
  final String name;
  final int subcategoryId;
  final String subcategoryName;
  final int categoryId;
  final String categoryName;
  final String image;
  final String image1;
  final String? composition;
  final String priceMax;
  final String readyTimeMax;
  final String? priceMin;
  final String? readyTimeMin;

  ProductModel(
      {required this.id,
      required this.name,
      required this.subcategoryId,
      required this.subcategoryName,
      required this.categoryId,
      required this.categoryName,
      required this.image,
      required this.image1,
      this.composition,
      required this.priceMax,
      required this.readyTimeMax,
      this.priceMin,
      this.readyTimeMin});

  factory ProductModel.productFromJson(Map<String, dynamic> data) => ProductModel(
      id: data['id'],
      name: data['name'],
      subcategoryId: data['subcategory']['id'],
      subcategoryName: data['subcategory']['name'],
      categoryId: data['subcategory']['category']['id'],
      categoryName: data['subcategory']['category']['name'],
      image: data['photo'],
      image1: data['photo1'],
      priceMax: data['price_max'],
      readyTimeMax: data['ready_time_max'],
      priceMin: data['price_min'],
      readyTimeMin: data['ready_time_min'],
      composition: data['compositon']);
}
