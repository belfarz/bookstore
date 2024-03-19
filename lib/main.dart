import 'package:bookstore/model/shop.dart';
import 'package:bookstore/pages/addbooks.dart';
import 'package:bookstore/pages/adminpage.dart';
import 'package:bookstore/pages/authpage.dart';
import 'package:bookstore/pages/cartpage.dart';
import 'package:bookstore/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(ChangeNotifierProvider(
    create: (context) => Shop(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
    home: AuthPage(),
    routes: {
      "/homepage":(context) => const HomePage(),
      "/adminpage":(context) => const AdminHomePage(),
      "/addbooks":(context) => const AddBooks(),
      "/cartPage":(context) => const CartPage(),
    },
    );
  }
}
