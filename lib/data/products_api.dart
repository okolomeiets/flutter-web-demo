import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchProducts() async {
  final url = Uri.parse('https://dummyjson.com/products');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['products'];
  } else {
    throw Exception('Failed to load products');
  }
}
