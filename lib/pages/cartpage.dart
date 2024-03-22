import 'package:bookstore/components/button.dart';
import 'package:bookstore/components/quantityselector.dart';
import 'package:bookstore/model/shop.dart';
import 'package:bookstore/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //remove from cart function
  void removeFromCart(dynamic book, BuildContext context) {
    //get access to shop
    final shop = context.read<Shop>();

    //remove from cart
    shop.removeFromCart(book);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
        builder: (context, value, child) => Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text("Cart"),
                centerTitle: true,
                backgroundColor: primaryColor,
                elevation: 0,
              ),
              body: Column(
                children: [
                  //CART
                  Expanded(
                    child: ListView.builder(
                        itemCount: value.newCart.length,
                        itemBuilder: (context, index) {

                          //get food from cart
                          final dynamic book = value.newCart[index];
                          //get food name
                          final bookName = book["Name"];
                          //get food price
                          final foodPrice = book["Price"];
                          //get image
                          final image = book["Image"];
                          int bookCount = 0;

                          // get author
                          final author = book["Author"];
                          // Initialize a variable to store the count of occurrences

                          // Iterate through the cart and count occurrences of the book

                          //return list tile
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8)),
                            margin: const EdgeInsets.only(
                                left: 20, top: 20, right: 20),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    image,
                                    width: 150,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        //title
                                        title: Text(
                                          bookName,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        //subtitle
                                        subtitle: Text(
                                          "\$" + foodPrice,
                                          style: TextStyle(
                                              color: Colors.grey[200]),
                                        ),
                                        //delete button
                                        trailing: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.grey[300],
                                          ),
                                          onPressed: () =>
                                              removeFromCart(book, context),
                                        ),
                                      ),
                                      Quantity(
                                        
                                        book: book,
                                        onIncrement: () {
                                          final shop = context.read<Shop>();
                                          // shop.getUserBook();
                                          shop.addToCart(book, 1);
                                          for (final dynamic book
                                              in shop.cart) {
                                            // Check if the current book's name matches the book you're interested in
                                            if (book["Name"] == bookName &&
                                                book["Author"] == author) {
                                              // Increment the count if there's a match
                                              bookCount++;
                                            }
                                          }
                                          print(shop.getBookCount(book));
                                        },
                                        onDecrement: () {
                                          //get access to shop
                                          final shop = context.read<Shop>();
                                          //add to cart
                                          shop.removeFromCart(book);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  //PAY BUTTON
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: MyButton(text: "Pay Now", onTap: () {}),
                  )
                ],
              ),
            ));
  }
}
