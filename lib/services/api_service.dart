import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://697dc13797386252a268fa62.mockapi.io/api/v1/oksa';

  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<Product> createProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.toJson()),
      );
      if (response.statusCode == 201) {
        return Product.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create product: $e');
    }
  }

  Future<Product> updateProduct(Product product) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${product.id}'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.toJson()),
      );
      if (response.statusCode == 200) {
        return Product.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      if (response.statusCode != 200) {
        throw Exception('Failed to delete product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }
}
