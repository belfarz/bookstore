import 'package:bookstore/model/shop.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookController extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Map<String, dynamic>> books = <Map<String, dynamic>>[].obs;

  

  @override
  void onInit() {
    super.onInit();
    fetchBooks();
    print(books);
  }

  Future<void> fetchBooks() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('books').get();
      books.assignAll(
          querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
          
    } catch (e) {
      print('Error fetching books: $e');
    }
  }
}

