import 'dart:convert';

import 'package:http/http.dart';
import 'package:suitmedia/storage/storage.dart';

class Api {
  Client client = Client();
  final secureStorage = SecureStorage();

  Future getGuests() async {
    final apiURL = Uri.parse('http://www.mocky.io/v2/596dec7f0f000023032b8017');
    var apiResult = await client.get(apiURL);
    if (apiResult.statusCode == 200) {
      var jsonObject = json.decode(apiResult.body);
      print(jsonObject);
      return jsonObject;
    }
    return apiResult.statusCode;
  }
}
