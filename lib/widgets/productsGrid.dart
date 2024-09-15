import 'package:bangalishop/api_services/fetch.dart';
import 'package:bangalishop/inner_screen/product_details.dart';
import 'package:bangalishop/model/products.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductsGridPage extends StatefulWidget {
  @override
  _ProductsGridPageState createState() => _ProductsGridPageState();
}

class _ProductsGridPageState extends State<ProductsGridPage> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = _loadOrFetchProducts();
  }

  Future<List<Product>> _loadOrFetchProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? productsJson = prefs.getString('cachedProducts');

    if (productsJson != null) {
      List<Product> cachedProducts = (json.decode(productsJson) as List)
          .map((data) => Product.fromJson(data))
          .toList();
      return cachedProducts;
    } else {
      return fetchProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
     
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
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
                    child: Image.network(product.image, fit: BoxFit.cover),
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(product.title, overflow: TextOverflow.ellipsis),
                      subtitle: Text('\$${product.price.toString()}'),
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

