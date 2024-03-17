import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  Future adduserDetail(Map<String, dynamic> userInfoMap, String id) async{
    return await FirebaseFirestore.instance
    .collection('users')
    .doc(id)
    .set(userInfoMap);
  }

  Future addBookInfo(Map<String, dynamic> userInfoMap, String name) async{
    return await FirebaseFirestore.instance
    .collection(name)
    .add(userInfoMap);
  }

  Stream<QuerySnapshot> getBookInfo(String name) {
    return FirebaseFirestore.instance.collection(name).snapshots();
  }
}