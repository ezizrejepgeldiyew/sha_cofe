import 'package:http/http.dart' as http;
import 'package:sa_kofe/const.dart';

class RemoteCategoryService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/category';

  Future<dynamic> get() async {
    var response = await client.get(Uri.parse(remoteUrl));
    return response.body;
  }

   getProducts(int categoryId) async {
    var response = await client.get(
      Uri.parse('$remoteUrl/product/$categoryId'),
    );
    return response.body;
  }
}
