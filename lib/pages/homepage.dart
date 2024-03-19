import 'package:bookstore/components/booktile.dart';
import 'package:bookstore/components/catelog.dart';
import 'package:bookstore/controller/bookcontroller.dart';
import 'package:bookstore/pages/bookdetailspage.dart';
import 'package:bookstore/themes/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookstore/model/data.dart';
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

  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());
    final books = bookController.books;

    return Scaffold(
        // backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          leading: const Icon(
            Icons.menu,
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
                          InkWell(
                            onTap: () {
                              // bookController.getAllBooks();
                            },
                            child: const Icon(Icons.search),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
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
                                  iconPath: e["icon"]!, btnName: e["lebel"]!),
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
                  )),
            ],
          ),
        ));
  }
}
