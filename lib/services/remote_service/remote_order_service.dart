import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sa_kofe/const.dart';

class RemoteOrderService {
  var client = http.Client();
  var remotePlaceUrl = '$baseUrl/api/order/place';
  var remoteOrderUrl = '$baseUrl/api/order';
  Future<dynamic> getPlace() async {
    var response = await http.get(Uri.parse(remotePlaceUrl));
    return response.body;
  }

  Future<dynamic> postOrder(Map<String, dynamic>? orderData) async {
    log('$orderData');
    var response = await http.post(Uri.parse(remoteOrderUrl),
        body: {'orderData': jsonEncode(orderData)});
    return response.body;
  }
}
