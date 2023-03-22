import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sa_kofe/provider/basket_provider.dart';
import 'package:sa_kofe/services/remote_service/remote_order_service.dart';
import 'package:sa_kofe/view/model/place_model.dart';

List<PlaceModel> placeList = List<PlaceModel>.empty(growable: true);

String _phoneNumber = '';
DateTime _dataTime = DateTime.now();
String? _placeName;
Map<String, dynamic>? orderData;

class OrderProvider with ChangeNotifier {
  Future<dynamic> getPlace() async {
    var result = await RemoteOrderService().getPlace();
    if (result != null) placeList = placeListFromJson(result);
    return placeList;
  }

  Future<dynamic> postOrder(
    String servicesTypeName,
    String delivery,
    String paymentTypeName,
    String name,
    String notes,
    List productData
  ) async {
    orderData = {
      "servicesTypeName": servicesTypeName,
      "placeName": _placeName,
      "serviceDate": _dataTime.toString(),
      "delivery": delivery,
      "paymentType": paymentTypeName,
      "name": name,
      "phoneNumber": _phoneNumber,
      "notes": notes,
      "productData" : productData
    };
    
    var result = await RemoteOrderService().postOrder(orderData);
    log('$result');
  }

  void phoneNumber(String phoneNumber) async {
    _phoneNumber = phoneNumber;
  }

  void dateTime(DateTime dateTime) {
    _dataTime = dateTime;
  }

  void placeName(String placeName) {
    _placeName = placeName;
  }

  void mySetState() async {
    notifyListeners();
  }
}
