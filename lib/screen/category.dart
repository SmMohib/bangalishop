import 'dart:convert';
import 'package:bangalishop/api_services/fetch.dart';
import 'package:bangalishop/inner_screen/product_details.dart';
import 'package:bangalishop/model/products.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


Future<List<String>> fetchCategories() async {
  final response = await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));

  if (response.statusCode == 200) {
    List<String> categories = List<String>.from(json.decode(response.body));
    return categories;
  } else {
    throw Exception('Failed to load categories');
  }
}

class CategoriesGridPage extends StatefulWidget {
  @override
  _CategoriesGridPageState createState() => _CategoriesGridPageState();
}

class _CategoriesGridPageState extends State<CategoriesGridPage> {
  late Future<List<String>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: FutureBuilder<List<String>>(
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String category = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductsByCategoryPage(category: category),
                      ),
                    );
                  },
                  child: GridTile(
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXLQx04dy4nCp6kNbhhT57dwoE5cuf9Ue9Hg&s',
                      fit: BoxFit.cover,
                    ),
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(category, textAlign: TextAlign.center),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class Product {
  final int id;
  final String title;
  final String imageUrl;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image'],
      price: json['price'].toDouble(),
    );
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

class ProductsByCategoryPage extends StatelessWidget {
  final String category;

  ProductsByCategoryPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProductsByCategory(category),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Product product = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                  child: GridTile(
                    child: Image.network(product.imageUrl, fit: BoxFit.cover),
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(product.title, textAlign: TextAlign.center),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(product.imageUrl, height: 300, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            Text(product.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('\$${product.price.toString()}', style: TextStyle(fontSize: 20, color: Colors.green)),
            SizedBox(height: 16),
            Text('Product Description', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text(
              'This is where the product description would go. You can fetch additional details about the product if available.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
