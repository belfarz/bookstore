import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookTile extends StatelessWidget {
  final void Function()? onTap;
  final dynamic book;
  const BookTile({super.key, required this.book, required this.onTap});

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
                    width: 120,
                    height: 200,
                    child: Column(
                      children: [
                        Image.network(
                          book["Image"],
                          height: 150,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          book["Name"],
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    book["Author"],
                    style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "\$" + book["Price"],
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Text(
                        "${book["Rating"] ?? "Not rated"}",
                        style: TextStyle(fontSize: 18),
                      ), // Display rating or "Not rated" if rating is not available
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 25,
                      ),
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
