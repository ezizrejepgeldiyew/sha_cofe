import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sa_kofe/const.dart';

class RemoteBasketService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/basket';
  Future<dynamic> get(List $productData) async {
    var response = await http.post(Uri.parse(remoteUrl),
        body: {"productData": jsonEncode($productData)});
    return response.body;
  }
}
