import 'package:bookstore/components/booktile.dart';
import 'package:bookstore/controller/bookcontroller.dart';
import 'package:bookstore/pages/bookdetailspage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryPage extends StatefulWidget {
  final String category;
  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Map<String, dynamic>> _searchList = [];
  BookController bookController = Get.put(BookController());
  
@override
  void initState() {
    _searchList = [];
    _runFilter();
    super.initState();
  }


  void _runFilter() async{
    List<Map<String, dynamic>> result = [];
    final books = bookController.books.toList();
    final categ = widget.category;
      if (true) {
        result = books
          .where((book) => book["Genre"]
              .toString()
              .startsWith(categ))
          .toList();
      // Filter books based on keyword
      }

    // Update the state with the filtered result
    setState(() {
      _searchList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.category),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: (_searchList.length / 2).ceil(), // Use half of the length
                itemBuilder: (context, index) {
                  // Calculate the indices for the two items in this row
                  final int firstIndex = index * 2;
                  final int secondIndex = index * 2 + 1;
                  
                  // Check if the second index exceeds the list length
                  final bool hasSecondItem = secondIndex < _searchList.length;

                  return Row(
                    mainAxisAlignment: _searchList.length > 1 ?  MainAxisAlignment.spaceAround : MainAxisAlignment.start,
                    children: [
                      BookTile(
                              book: _searchList[firstIndex],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookDetails(
                                        book: _searchList[firstIndex],
                                      ),
                                    ));
                              },
                            ),
                      if (hasSecondItem)
                        BookTile(
                              book: _searchList[secondIndex],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookDetails(
                                        book: _searchList[secondIndex],
                                      ),
                                    ));
                              },
                            ),
                    ],
                  );
                },
              ),
            ),
        ],
      )
    );
  }
}
