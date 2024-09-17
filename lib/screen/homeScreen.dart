// Placeholder screens for each tab
import 'package:bangalishop/widgets/productsGrid.dart';
import 'package:bangalishop/widgets/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bangali Shop'),backgroundColor: Colors.cyan ,),
      body: SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(
                height: 50,
                child: InkWell(onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
                },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(height: 50,width: double.infinity,color: Colors.cyan[50], child: 
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: 
                    [Text('Search products',),Icon(Icons.search)],),),
                  ),
                ),
              ),
          SizedBox(height: 600, child: ProductsGridPage()),
            ],
          ),
      ),
    );
  }
}