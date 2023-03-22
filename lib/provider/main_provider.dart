import 'package:flutter/cupertino.dart';
import 'package:sa_kofe/services/remote_service/remote_banner_service.dart';
import 'package:sa_kofe/services/remote_service/remote_category_service.dart';
import 'package:sa_kofe/services/remote_service/remote_popular_product_service.dart';
import 'package:sa_kofe/services/remote_service/remote_recommended_product_service.dart';
import 'package:sa_kofe/view/model/ad_banner.dart';
import 'package:sa_kofe/view/model/product_model.dart';

class MainProvider with ChangeNotifier {
  List<AdBanner> banners = List<AdBanner>.empty(growable: true);
  List<ProductModel> popularProductList = List<ProductModel>.empty(growable: true);
  List<ProductModel> recommendedProductList = List<ProductModel>.empty(growable: true);
  List<ProductModel> categoryProductList = List<ProductModel>.empty(growable: true);

  Future<dynamic> banner() async {
    var result = await RemoteBannerService().get();
    banners = adBannerListFromJson(result);
    return banners;
  }

  Future<dynamic> popularProducts() async {
    var result = await RemotePopularProductService().get();
    popularProductList = productListFromJson(result);
    return popularProductList;
  }

  Future<dynamic> recommendedProducts() async {
    var result = await RemoteRecommendedProductService().get();
    recommendedProductList = productListFromJson(result);
    return recommendedProductList;
  }

  Future<dynamic> categoryProducts(int categoryId) async {
    var result = await RemoteCategoryService().getProducts(categoryId);
    categoryProductList = productListFromJson(result);
    return categoryProductList;
  }

  void mySetState() async {
    notifyListeners();
  }
}
