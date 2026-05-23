import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/constants/api_constants.dart';
import '../models/product.dart';

class ProductService {
  final String _endpoint = ApiConstants.productsEndpoint;

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(_endpoint));

    if (response.statusCode == 200) {
      if (response.body.isEmpty) return [];
      final decoded = jsonDecode(response.body);
      if (decoded is! List) {
        throw Exception('Bad response from server');
      }
      return decoded
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    throw Exception('GET failed: ${response.statusCode}');
  }

  Future<Product> createProduct(Product product) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 201) {
      return Product.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }
    throw Exception('POST failed: ${response.statusCode}');
  }

  Future<void> updateProduct(Product product) async {
    if (product.id == null) {
      throw Exception('No product id');
    }
    final response = await http.put(
      Uri.parse('$_endpoint/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('PUT failed: ${response.statusCode}');
    }
  }

  Future<void> deleteProduct(String id) async {
    final response = await http.delete(Uri.parse('$_endpoint/$id'));

    if (response.statusCode != 200) {
      throw Exception('DELETE failed: ${response.statusCode}');
    }
  }
}
