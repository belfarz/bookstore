import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    await FirebaseFirestore.instance
        .collection('usersCart')
        .doc(id)
        .collection("Books")
        .add(userInfoMap);
  }

  Future<void> addBookInfo(Map<String, dynamic> bookInfoMap) async {
    await FirebaseFirestore.instance
        .collection('books')  // Store all book information in the "books" collection
        .add(bookInfoMap);
  }

  Stream<QuerySnapshot> getBookInfo() {
    return FirebaseFirestore.instance.collection('books').snapshots();
  }
} 