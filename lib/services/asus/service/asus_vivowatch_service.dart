import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:number_connection_test/services/asus/model/asus_vivowatch_data.dart';

class ASUSVivowatchService {
  static const endpoint = "http://140.113.151.61/api/v1/asus";
  static const getData = "$endpoint/getASUSLatestData.php";
  var httpClient = http.Client();

  Future<ASUSVivowatchData> fetchData() async {
    try {
      final response = await httpClient.get(Uri.parse(getData));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return ASUSVivowatchData.fromJson(json);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle any errors that occur during the fetch operation
      throw Exception('Failed to load data: $e');
    }
  }
}
