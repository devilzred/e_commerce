import 'dart:convert';
import 'package:e_commerce/models/product_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static var client = http.Client();

  static Future<List<Product>?> fetchProducts() async {
    var response = await client.get(Uri.parse('https://fake-store-api.mock.beeceptor.com/api/products'));

    // // Debugging: Print the response status and body
    // print("Status Code: ${response.statusCode}");
    // print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var jsonString = response.body;
      Iterable jsonList = json.decode(jsonString);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      print("Error fetching data: ${response.statusCode}");
      return null;
    }
  }
}
