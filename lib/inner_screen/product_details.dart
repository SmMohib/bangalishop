import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/products.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool('favorite_${widget.product.id}') ?? false;
    });
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = !isFavorite;
      prefs.setBool('favorite_${widget.product.id}', isFavorite);
    });
  }

  void _addToCart() {
    // Logic to add product to the cart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.product.title} added to cart')),
    );
  }

  void _buyNow() {
    // Logic to handle the purchase action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Purchased ${widget.product.title}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the cart page
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(widget.product.image, height: 300, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.product.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                  color: isFavorite ? Colors.red : Colors.grey,
                  onPressed: _toggleFavorite,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text('\$${widget.product.price.toString()}', style: TextStyle(fontSize: 20, color: Colors.green)),
            SizedBox(height: 16),
            Text('Product Description', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text(
              widget.product.description,
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _buyNow,
                    child: Text('Buy Now'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: _addToCart,
                  tooltip: 'Add to Cart',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
