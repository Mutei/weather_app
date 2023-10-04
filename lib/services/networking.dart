import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  late String url;

  NetworkHelper({required this.url});

  Future getData() async {
    final String apiUrl = url;

    Uri uri = Uri.parse(apiUrl); // Create a Uri object from the string URL

    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);

      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
