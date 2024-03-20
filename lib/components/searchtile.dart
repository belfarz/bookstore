import 'package:flutter/material.dart';

class SearchTile extends StatelessWidget {
  final void Function()? onTap;
  final dynamic book;
  const SearchTile({
    super.key,
    required this.book,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:const EdgeInsets.only(left: 25),
        padding: EdgeInsets.all(25),
        
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
      
            // SizedBox(height: 100,),
            //image
            Image.network(
              book["Image"],
              height: 140,
            ),
            SizedBox(height: 20,),
            //text
            Text(
              book["name"],
              style: TextStyle(fontSize: 20),
            ),
      
            //price + rating
            SizedBox(
              width: 160,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //price
                  Text(
                    "\$"+book["Price"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
      
                  //icon
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                      ),
                      //rating
                      Text(
                        book["Rating"],
                        style: TextStyle(color: Colors.grey),
                        ),
                    ],
                  ),
      
                ],
              ),
            )
      
          ],
        ),
      ),
    );
  }
}
