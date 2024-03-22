import 'package:bookstore/model/shop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Quantity extends StatelessWidget {
  
  final dynamic book;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const Quantity({super.key, required this.book, required this.onIncrement, required this.onDecrement});
  

  @override
  Widget build(BuildContext context) {
    final shop = context.read<Shop>();
    // Initialize a variable to store the count of occurrences
    int bookCount = 0;
    return Row(
      children: [
        //minus button
        GestureDetector(
          onTap: onDecrement,
          child: Container(
            decoration:
                const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
            child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            
          ),
        ),
        //quantity count
        SizedBox(
          width: 40,
          child: Center(
            child: Text(
              shop.getBookCount(book).toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
        //plus count
        GestureDetector(
          onTap: onIncrement,
          child: Container(
            decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
            child:Icon(
                Icons.add,
                color: Colors.white,
              ),
          ),
        )
      ],
    );
  }
}
