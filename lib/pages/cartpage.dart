import 'package:bookstore/components/button.dart';
import 'package:bookstore/model/shop.dart';
import 'package:bookstore/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  //remove from cart function
  void removeFromCart(dynamic book, BuildContext context) {
    //get access to shop
    final shop = context.read<Shop>();

    //remove from cart
    shop.removeFromCart(book);
  }

  @override
 

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
                        itemCount: value.cart.length,
                        itemBuilder: (context, index) {
                          //get food from cart
                          final dynamic book = value.cart[index];
                          //get food name
                          final foodName = book["Name"];
                          //get food price
                          final foodPrice = book["Price"];
                          //get image
                          final image = book["Image"];
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
                                  child: ListTile(
                                    //title
                                    title: Text(
                                      foodName,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    //subtitle
                                    subtitle: Text(
                                      "\$" + foodPrice,
                                      style: TextStyle(color: Colors.grey[200]),
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
