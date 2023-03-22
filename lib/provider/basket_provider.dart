import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sa_kofe/services/remote_service/remote_basket_service.dart';
import 'package:sa_kofe/view/model/product_model.dart';

class BasketProvider with ChangeNotifier {
  late List productData = [];
  List<ProductModel> basketProductList =
      List<ProductModel>.empty(growable: true);

  Future<dynamic> addBasket(int productId) async {
    int t = 0;

    for (var i = 0; i < productData.length; i++) {
      if (productData[i]['productId'] == productId) {
        productData[i]['productQuantity']++;
        t = 1;
      }
    }
    if (t == 0) {
      Map<String, int> product = {'productId': productId, 'productQuantity': 1};
      productData.add(product);
    }

    var result = await RemoteBasketService().get(productData);
    if (result != null) basketProductList = productListFromJson(result);
    notifyListeners();
  }

  Future<dynamic> basketProducts() async {
    var result = await RemoteBasketService().get(productData);
    if (result != null) basketProductList = productListFromJson(result);
    return basketProductList;
  }

  void incrementProduct(int index) async {
    productData[index]['productQuantity']++;
  }

  void decrementProduct(int index) async {
    if (productData[index]['productQuantity'] > 1) {
      productData[index]['productQuantity']--;
    }
  }

  Future<double> totalPrice() async {
    double totalPriceProduct = 0;
    for (var i = 0; i < basketProductList.length; i++) {
      totalPriceProduct += int.parse(basketProductList[i].priceMax) *
          productData[i]['productQuantity'];
    }
    return totalPriceProduct;
  }

  void removeAll() {
    productData.clear();
    basketProductList.clear();
    notifyListeners();
  }

  void removeAt(int id) {
    productData.removeAt(id);
    basketProductList.removeAt(id);
    notifyListeners();
  }

  Future<int> readTime() async {
    var time = 0;
    for (var element in basketProductList) {
      if (time < int.parse(element.readyTimeMax)) {
        time = int.parse(element.readyTimeMax);
      }
    }
    return time;
  }

  void mySetState() async {
    notifyListeners();
  }
}
