import 'package:bookstore/components/booktile.dart';
import 'package:bookstore/components/catelog.dart';
import 'package:bookstore/components/searchtile.dart';
import 'package:bookstore/controller/bookcontroller.dart';
import 'package:bookstore/pages/bookdetailspage.dart';
import 'package:bookstore/pages/categorypage.dart';
import 'package:bookstore/themes/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookstore/model/data.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  List<Map<String, dynamic>> _searchList = [];
  BookController bookController = Get.put(BookController());

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _searchList = bookController.books.toList();
    super.initState();
  }

  void _runFilter(String keyword) {
    List<Map<String, dynamic>> result = [];
    final books = bookController.books.toList();
   

    if (keyword.isEmpty) {
      result = []; // If keyword is empty, return all books
    } else {
      result = books
          .where((book) => book["Name"]
              .toString()
              .toLowerCase()
              .startsWith(keyword.toLowerCase()))
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
    final books = bookController.books;
     List<dynamic> newArrivval = books.reversed.toList();
    bool isSearchTextNotEmpty = false;

    return Scaffold(
        // backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            },
            icon: Icon(Icons.person), // Wrap Icons.person with Icon widget
          ),
          title: const Text(
            "BookShop",
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/cartPage");
                },
                icon: const Icon(Icons.shopping_cart)),
            IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                color: primaryColor,
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print(bookController.books);
                          },
                          child: const Text(
                            "welcome✌️",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                        const Text(
                          " user",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Time to read book and enhance your knowledge",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          IconButton(
                            onPressed: () {
                              // Implement your search functionality here
                            },
                            icon: const Icon(Icons.search),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              onChanged: (value) => _runFilter(value),
                              controller: searchController,
                              decoration: const InputDecoration(
                                hintText: "Search here . .",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        Text(
                          "Topics",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categoryData
                            .map(
                              (e) => CategoryWidget(
                                  iconPath: e["icon"]!,
                                   btnName: e["lebel"]!,
                                   onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CategoryPage(
                                          category: e["lebel"].toString(),
                                        ),
                                      ));
                                },
                                   ),
                            )
                            .toList(),
                      ),
                    ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _searchList
                            .map(
                              (e) => BookTile(
                                book: e,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BookDetails(
                                          book: e,
                                        ),
                                      ));
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "New Arrival",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         height: 500,
              //         child: ListView.builder(
              //           scrollDirection: Axis.horizontal,
              //           itemCount: books.length,
              //           itemBuilder: (context, index) => FoodTile(
              //             book : books[index],
              //             onTap: (){

              //             },
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: newArrivval
                          .map(
                            (e) => BookTile(
                              book: e,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookDetails(
                                        book: e,
                                      ),
                                    ));
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),

                   const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Best Sellers",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),

              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(
                    () => Row(
                      children: books
                          .map(
                            (e) => BookTile(
                              book: e,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookDetails(
                                        book: e,
                                      ),
                                    ));
                              },
                            ),
                          )
                          .toList(),
                    ),
                  )
                  ),
            ],
          ),
        ));
  }
}
