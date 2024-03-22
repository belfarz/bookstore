import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {

  final String category;
  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.category),
      ),
      body: Center(
        child: Text(widget.category),
      ),
    );
  }
}