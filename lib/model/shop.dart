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

  //add to cart
  void addToCart(dynamic book, int quantity){
    for (int i = 0; i < quantity; i++) {
      DatabaseMethods().addUserDetail(book,fAuth.currentUser!.uid );
    }
    notifyListeners();
  }

  //get cart items
   void getUserBook() async {
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

  //remove from cart

  void removeFromCart(dynamic book){
    _cart.remove(book);
    notifyListeners();
  }
}