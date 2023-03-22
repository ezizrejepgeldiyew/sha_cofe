import 'package:http/http.dart' as http;
import 'package:sa_kofe/const.dart';
class RemoteProductService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/product';

  Future<dynamic> get() async{
    var response = await client.get(Uri.parse(remoteUrl));
    return response.body;
  }
}