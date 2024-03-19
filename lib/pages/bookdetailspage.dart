import 'package:bookstore/components/button.dart';
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
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(widget.book["Name"]),
              ),
            ),

            //add item to cart container
            Container(
            padding: const EdgeInsets.all(25),
            color: primaryColor,
            child: Column(
              children: [
                //price + quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //price
                    Text(
                      "\$${widget.book["Price"]}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),

                    //quantity
                    Row(
                      children: [
                        //minus button
                        Container(
                          decoration:const  BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle),
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
                                  color: Colors.white,
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
          )
          ],
        ));
  }
}
