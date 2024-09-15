import 'package:bangalishop/screen/category.dart';
import 'package:bangalishop/screen/homeScreen.dart';
import 'package:bangalishop/screen/ptofile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CommerceApp());
}

class CommerceApp extends StatelessWidget {
  const CommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of widgets to display in each tab
  // ignore: prefer_final_fields
  static List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
     CategoriesGridPage(),
  
    const CartScreen(), ProductsGridPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ), BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
       unselectedItemColor: const Color.fromARGB(255, 45, 48, 51),
        backgroundColor: Color.fromARGB(122, 208, 236, 252),
        onTap: _onItemTapped,
      ),
    );
  }
}



class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Categories Screen: Different product categories'),
    );
  }
}



class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Cart Screen: Display items added to the cart'),
    );
  }
}
