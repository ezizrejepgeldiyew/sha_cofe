import 'package:http/http.dart' as http;
import 'package:sa_kofe/const.dart';

class RemoteSubcategoryService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/subcategory';

  Future<dynamic> get(int categoryId) async {
    var response = await client.get(Uri.parse('$remoteUrl/$categoryId'));
    return response.body;
  }

  Future<dynamic> getProducts(int? id) async {
    var response = await client.get(Uri.parse('$remoteUrl/product/$id'));
    return response.body;
  }
}
