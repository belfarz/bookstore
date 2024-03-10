import 'package:bookstore/pages/homepage.dart';
import 'package:bookstore/pages/login_or_registerpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder <User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //user is logged in
          if (snapshot.hasData) {
            return const HomePage();
          }
          //user is not logged in
          else{
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}