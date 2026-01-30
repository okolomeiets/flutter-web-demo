import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/models/product.dart';

class ProductsApi {
  final http.Client _client;

  ProductsApi({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('https://dummyjson.com/products');
    final res = await _client.get(url);

    if (res.statusCode != 200) {
      throw Exception('Failed to load products: ${res.statusCode}');
    }

    final decoded = jsonDecode(res.body) as Map<String, dynamic>;
    final list = (decoded['products'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>();

    return list.map(Product.fromJson).toList();
  }

  Future<Product> fetchProductById(int id) async {
    final url = Uri.parse('https://dummyjson.com/products/$id');
    final res = await _client.get(url);

    if (res.statusCode != 200) {
      throw Exception('Failed to load product $id: ${res.statusCode}');
    }

    final decoded = jsonDecode(res.body) as Map<String, dynamic>;
    return Product.fromJson(decoded);
  }
}
