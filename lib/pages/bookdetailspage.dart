import 'dart:ui';

import 'package:bookstore/components/button.dart';
import 'package:bookstore/components/database.dart';
import 'package:bookstore/model/shop.dart';
import 'package:bookstore/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatefulWidget {
  final dynamic book;
  const BookDetails({super.key, required this.book});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  void addToCart() {
    //only add if there is something in the cart
    if (quantityCount > 0) {
      //get access to shop
      final shop = context.read<Shop>();
      //add to cart
      shop.addToCart(widget.book, quantityCount);
      //let the user know
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                backgroundColor: Colors.black,
                content: const Text(
                  "added to cart",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  //okay button
                  IconButton(
                      onPressed: () {
                        //pop once to remove dialog box
                        Navigator.pop(context);
                        //pop again to go prrvious screen
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.done,
                        color: Colors.white,
                      ))
                ],
              ));
    }
  }

  //quantity
  int quantityCount = 0;

  //increment function
  void quantityIncrement() {
    setState(() {
      quantityCount++;
    });
  }

  //decrement funtion
  void quantityDecrement() {
    setState(() {
      if (quantityCount > 0) {
        quantityCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
        ),
        body: Column(
          children: [
//testing efes code----------------------------
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.book["Image"]),
                      fit: BoxFit.cover),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        
                        expandedHeight: 450,
                        flexibleSpace: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Image.network(widget.book["Image"],
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 2),
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: scrollmethod(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            

//-------------------------------------------------
            //add item to cart container
            // Container(
            //   padding: const EdgeInsets.all(25),
            //   color: primaryColor,
            //   child: Column(
            //     children: [
            //       //price + quantity
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           //price
            //           Text(
            //             "\$${widget.book["Price"]}",
            //             style: const TextStyle(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 18),
            //           ),

            //           //quantity
            //           Row(
            //             children: [
            //               //minus button
            //               Container(
            //                 decoration: const BoxDecoration(
            //                     color: Colors.grey, shape: BoxShape.circle),
            //                 child: IconButton(
            //                   icon: const Icon(
            //                     Icons.remove,
            //                     color: Colors.white,
            //                   ),
            //                   onPressed: quantityDecrement,
            //                 ),
            //               ),
            //               //quantity count
            //               SizedBox(
            //                 width: 40,
            //                 child: Center(
            //                   child: Text(
            //                     quantityCount.toString(),
            //                     style: const TextStyle(
            //                         color: Colors.white,
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 18),
            //                   ),
            //                 ),
            //               ),
            //               //plus count
            //               Container(
            //                 decoration: BoxDecoration(
            //                     color: Colors.grey, shape: BoxShape.circle),
            //                 child: IconButton(
            //                   icon: const Icon(
            //                     Icons.add,
            //                     color: Colors.white,
            //                   ),
            //                   onPressed: quantityIncrement,
            //                 ),
            //               )
            //             ],
            //           )
            //         ],
            //       ),
            //       const SizedBox(
            //         height: 25,
            //       ),
            //       //add to cart button
            //       MyButton(text: "Add To Cart", onTap: addToCart)
            //     ],
            //   ),
            // ),
            //---
          ],
        ));
  }

//efes code-----------------------
  Container scrollmethod() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
            top: Radius.elliptical(MediaQuery.of(context).size.width, 50)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, top: 10, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                SizedBox(height: 70),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          Color.fromARGB(255, 218, 218, 218).withOpacity(0.31),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.book["Genre"],
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
            SizedBox(height: 10),
            Text(widget.book["Name"],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(widget.book["Author"],
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45)),
            SizedBox(height: 10),
            Text('\$' + widget.book["Price"],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                5,
                (index) {
                  return Icon(
                    index < widget.book["Rating"]
                        ? Icons.star_rounded
                        : Icons.star_border_rounded,
                    size: 40,
                    color: Colors.amber,
                  );
                },
              ),
            ),
            Text('Book Overview',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
              widget.book["Detail"],
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            SizedBox(
              height: 12,
            ),


            Container(
              padding: const EdgeInsets.all(25),
              
              child: Column(
                children: [
                  //price + quantity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //price
                      Text(
                        widget.book["Price"],
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),

                      //quantity
                      Row(
                        children: [
                          //minus button
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle,
                                ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                              onPressed: quantityDecrement,
                            ),
                          ),
                          //quantity count
                          SizedBox(
                            width: 40,
                            child: Center(
                              child: Text(
                                quantityCount.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          //plus count
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                            child: IconButton(
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onPressed: quantityIncrement,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //add to cart button
                  MyButton(text: "Add To Cart", onTap: addToCart)
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text("Reviews",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 12,
            ),
            ReviewsWidget(bookTitle: widget.book["Name"]),

            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Rate this book:',
            //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //       ),
            //       Row(
            //         children: List.generate(5, (index) {
            //           return IconButton(
            //             icon: Icon(
            //               index < _rating ? Icons.star : Icons.star_border,
            //               color: Colors.amber,
            //             ),
            //             onPressed: () {
            //               setState(() {
            //                 _rating = index + 1;
            //               });
            //             },
            //           );
            //         }),
            //       ),
            //       SizedBox(height: 20),
            //       TextField(
            //         controller: _reviewController,
            //         decoration: InputDecoration(
            //           labelText: 'Write your review...',
            //           border: OutlineInputBorder(),
            //         ),
            //         maxLines: 5,
            //       ),
            //       SizedBox(height: 20),
            //       ElevatedButton(
            //         onPressed: submitReview,
            //         child: Text('Submit Review'),
            //       ),
            //     ],
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
}


//efes code-----------------------


// Sample data for reviews (replace it with data fetched from the database)
List<Review> reviews = [
  Review(
    userName: 'User1',
    rating: 4,
    reviewText: 'Great book! Highly recommended.',
    likes: 10,
  ),
  Review(
    userName: 'User2',
    rating: 5,
    reviewText: 'Amazing book! Must read.',
    likes: 15,
  ),
];

class Review {
  String? userName;
  final int rating;
  final String reviewText;
  int likes; // Updated to store likes

  Review({
    this.userName,
    required this.rating,
    required this.reviewText,
    required this.likes,
  });

  // Method to increment likes
  void like() {
    likes++;
  }
}



class ReviewsWidget extends StatefulWidget {
  final String bookTitle;

  ReviewsWidget({required this.bookTitle});

  @override
  _ReviewsWidgetState createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends State<ReviewsWidget> {
  late Stream<List<Map<String, dynamic>>> _reviewsStream;

  @override
  void initState() {
    super.initState();
    _reviewsStream = _fetchReviewsForBook();
  }

  Stream<List<Map<String, dynamic>>> _fetchReviewsForBook() {
    String? bookTitle = widget.bookTitle;
    if (bookTitle != null) {
      return DatabaseMethods().getReviewsForBook(bookTitle);
    } else {
      return Stream.value([]); // Return empty stream if book not found
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _reviewsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>> reviews = snapshot.data ?? [];
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              // Build your review list tile here
              // You can use the data from reviews[index]
              return ListTile(
                title: Text('User'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Rating: ${reviews[index]['rating']}'),
                    Text(reviews[index]['reviewText'] ?? ''),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.thumb_up),
                          onPressed: () {
                            // Handle like functionality
                            setState(() {
                              reviews[index]['likes']++;
                            });
                          },
                        ),
                        Text('${reviews[index]['likes']}'),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
