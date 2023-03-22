import 'package:flutter/cupertino.dart';
import 'package:sa_kofe/services/remote_service/remote_category_service.dart';
import 'package:sa_kofe/services/remote_service/remote_subcategory_service.dart';
import 'package:sa_kofe/view/model/category_model.dart';
import 'package:sa_kofe/view/model/product_model.dart';
import 'package:sa_kofe/view/model/subcategory_model.dart';

List<CategoryModel> categoryList = List<CategoryModel>.empty(growable: true);
List<ProductModel> categoryProductList =
    List<ProductModel>.empty(growable: true);
List<SubcategoryModel> subcategoryList =
    List<SubcategoryModel>.empty(growable: true);
List<ProductModel> subcategoryProductList =
    List<ProductModel>.empty(growable: true);

class MenuProvider with ChangeNotifier {
  Future<dynamic> getCategory() async {
    var result = await RemoteCategoryService().get();
    categoryList = categoryListFromJson(result);
    return categoryList;
  }

  Future<dynamic> getCategoryProducts(int categoryId, int? activeButtonId) async {
    if (activeButtonId != null) {
      var result = await RemoteSubcategoryService().getProducts(activeButtonId);
      categoryProductList = productListFromJson(result);
    } else {
      var result = await RemoteCategoryService().getProducts(categoryId);
      categoryProductList = productListFromJson(result);
    }
    return categoryProductList;
  }
  Future<dynamic> getSubcategory(int categoryId) async {
    var result = await RemoteSubcategoryService().get(categoryId);
    subcategoryList = subcategoryListFromJson(result);
    return subcategoryList;
  }

  void mySetState() async {
    notifyListeners();
  }
}
