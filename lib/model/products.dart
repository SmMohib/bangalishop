class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final String image;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
  });

  // Factory method to create a Product object from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      price: json['price'].toDouble(),
    );
  }

  get imageUrl => null;
}
class Productcat {
  final int id;
  final String title;
  final String imageUrl;
  final double price;

  Productcat({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
  });

  factory Productcat.fromJson(Map<String, dynamic> json) {
    return Productcat(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image'],
      price: json['price'].toDouble(),
    );
  }
}