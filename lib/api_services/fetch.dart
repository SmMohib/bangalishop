import 'dart:convert';
import 'package:bangalishop/model/products.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> fetchProducts() async {
  final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((product) => Product.fromJson(product)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}

Future<List<String>> fetchCategories() async {
  final response = await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));

  if (response.statusCode == 200) {
    List<String> categories = List<String>.from(json.decode(response.body));
    return categories;
  } else {
    throw Exception('Failed to load categories');
  }
}
Future<List<Product>> fetchProductsByCategory(String category) async {
  final response = await http.get(Uri.parse('https://fakestoreapi.com/products/category/$category'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((product) => Product.fromJson(product)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}
