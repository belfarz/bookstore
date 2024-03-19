import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookTile extends StatelessWidget {
  final void Function()? onTap;
  final dynamic book;
  const BookTile({
    super.key,
    required this.book,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Image.network(book["Image"], height: 170, width: 150, fit: BoxFit.cover,),
                        ),
                        Text(book["Name"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text(book["Author"], 
                          style: TextStyle(
                            color: Colors.black38, 
                            fontSize: 15, 
                            fontWeight: FontWeight.w500),),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Text("\$" + book["Price"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                            SizedBox(
                              width: 40,
                            ),
                            Text("${book["Rating"] ?? "Not rated"}", style: TextStyle(fontSize: 18),), // Display rating or "Not rated" if rating is not available
                        Icon(Icons.star_rounded, color: Colors.amber, size: 25,),
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}


