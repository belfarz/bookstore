
import 'dart:io';
import 'dart:math';
import 'package:bookstore/components/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBooks extends StatefulWidget {
  const AddBooks({super.key});

  @override
  State<AddBooks> createState() => _AddBooksState();
}

class _AddBooksState extends State<AddBooks> {
  final List<String>items = ['Fiction', 'Fantasy', 'Romance', 'Mystery', 'Novel', 'Thriller', 'Childrens Literature', 'True Crime', 'Manga'];
  String? value;
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();
  TextEditingController genrecontroller = new TextEditingController();
  TextEditingController desccontroller = new TextEditingController();
  TextEditingController authorcontroller = new TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage()async{
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {
      
    });
  }
  String randomAlphaNumeric(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
  );
}

  uploadItem() async {
    if(selectedImage != null && 
    namecontroller.text != null && 
    authorcontroller.text != null && 
    pricecontroller.text != null && 
    desccontroller.text != null){
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("BlogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> addItem = {
        "Image" : downloadUrl,
        "Name" : namecontroller.text,
        "Author" : authorcontroller.text,
        "Price" : pricecontroller.text,
        "Detail" : desccontroller.text

      };
      await DatabaseMethods().addBookInfo(addItem, value!).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.amberAccent,
          content: Text('New Book has been added!', style: TextStyle(fontSize: 20),)));
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,)),
          centerTitle: true,
          title: Text('Add Books',),
      ),
      
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left:20, right: 20, top: 20, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Upload the Book Thumbnail', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              SizedBox(height: 25,),

               selectedImage == null? GestureDetector(
                onTap: () {
                  getImage();
                },
                 child: Center(
                  child: Material(
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 170,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.5,), borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.camera_alt_outlined, color: Colors.black,),
                    ),
                  ),
                               ),
               ):Center(
                child: Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 170,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.5,), borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(selectedImage!, fit: BoxFit.cover, )),
                  ),
                ),
              ),
        
              SizedBox(height: 25,),
              Text('Book Title', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              SizedBox(height: 25,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8), 
                  borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Book Title',
                      ),
                  ),
              ),
        
              SizedBox(height: 25,),
              Text('Book Author', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              SizedBox(height: 25,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: authorcontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Book Author',
                      ),
                  ),
              ),
        
              SizedBox(height: 25,),
              Text('Book Price', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              SizedBox(height: 25,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8), 
                  borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: pricecontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Book Price',
                      ),
                  ),
              ),
              SizedBox(height: 25),
              Text('Select Book Genre', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String> (items: items.map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: TextStyle(fontSize: 18, color: Colors.black),))).toList(), 
                onChanged: ((value) => setState(() {
                  this.value = value;
                })), dropdownColor: Colors.white, hint: Text('Select a Genre') , iconSize: 30, icon: Icon(Icons.arrow_drop_down, color: Colors.black,), value: value,)),
              ),

              SizedBox(height: 10),
              SizedBox(height: 25,),
              Text('Book Description', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              SizedBox(height: 25,),
              Container(
                
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8), 
                  borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    maxLines: 6,
                    controller: desccontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Book Description',
                      ),
                  ),
              ),

              SizedBox(height: 30,),
              GestureDetector(
                onTap: uploadItem,
                child: Center(
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.black, 
                        borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text('Add', style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                
                          ),),
                        ),
                    ),
                    ),
                ),
              )
        
        
        
        
          ]),
        ),
      ),
    );
  }
}