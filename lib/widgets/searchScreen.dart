import 'package:bangalishop/inner_screen/product_details.dart';
import 'package:bangalishop/model/products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
  // Assuming the Product model is in this file

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> _searchResults = [];
  TextEditingController _searchController = TextEditingController();

  void searchProducts(String query) async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List productsJson = json.decode(response.body);

      // Parse the JSON data into a list of Product objects
      List<Product> products = productsJson.map((json) => Product.fromJson(json)).toList();

      // Filter products based on the query
      setState(() {
        _searchResults = products.where((product) {
          return product.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Product Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search for products",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                searchProducts(query);  // Trigger search on input change
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  Product product = _searchResults[index];
                  return InkWell(
                    onTap: () {
                      // Navigate to the ProductDetailPage with the Product object
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(product: product),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(product.title),
                      subtitle: Text('\$${product.price}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
