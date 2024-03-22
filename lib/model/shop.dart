import 'package:bookstore/components/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Shop extends ChangeNotifier{

  final db = FirebaseFirestore.instance;
  final fAuth = FirebaseAuth.instance;

  // Constructor
  Shop() {
    // Call the init method when Shop is initialized
    init();
  }

  // Init method to fetch user's books
  void init() {
    getUserBook();
  }

  //customer cart
  List <dynamic> _cart = [];


  //getter methods
  
  List<dynamic> get cart => _cart;
  List<dynamic> get newCart => removeDuplicates(_cart);

  int getBookCount(dynamic book) {
    int count = 0;
    for (final dynamic item in _cart) {
      if (item["Name"] == book["Name"] && item["Author"] == book["Author"]) {
        count++;
      }
    }
    return count;
  }

  //add to cart
  void addToCart(dynamic book, int quantity){
    for (int i = 0; i < quantity; i++) {
      DatabaseMethods().addUserDetail(book,fAuth.currentUser!.uid );
    }
    getUserBook();
    notifyListeners();
  }

  //get cart items
  Future<void> getUserBook() async {
    cart.clear();
    print("initialized getusercart");
    var books = await db
        .collection("usersCart")
        .doc(fAuth.currentUser!.uid)
        .collection("Books")
        .get();
    for (var book in books.docs) {
      _cart.add(book.data());
    }

     print("getusercart successfull");
     notifyListeners();
  }

  //remove duplicates
  List<dynamic> removeDuplicates(List<dynamic> inputList) {
  List<dynamic> resultList = [];

  for (final dynamic item in inputList) {
     // Check if the resultList already contains an item that is "equal" to the current item
    if (!resultList.any((existingItem) => _areEqual(existingItem, item))) {
      resultList.add(item);
    }
  }
 print(resultList.length);
  return resultList;
}

bool _areEqual(dynamic item1, dynamic item2) {
  // Check if both items are maps
  if (item1 is Map<String, dynamic> && item2 is Map<String, dynamic>) {
    // Convert maps to strings and compare them
    return mapToString(item1) == mapToString(item2);
  } else {
    // For other types of items, use default equality comparison
    return item1 == item2;
  }
}

String mapToString(Map<String, dynamic> map) {
  // Convert the map to a string representation
  return map.entries.map((entry) => '${entry.key}: ${entry.value}').join(', ');
}


  //remove from cart

  void removeFromCart(dynamic book){
    _cart.remove(book);
    notifyListeners();
  }
}