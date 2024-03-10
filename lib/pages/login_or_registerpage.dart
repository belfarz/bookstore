import 'package:bookstore/pages/loginpage.dart';
import 'package:bookstore/pages/registerpage.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
    //innitially show login page

  bool showLoginPage = true;

  void togglePage(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    
          //user is logged in
          if (showLoginPage) {
            return LoginPage(
              onTap: togglePage,
            );
          }
          //user is not logged in
          else{
            return RegisterPage(
              onTap: togglePage,
              );
          }
  }
}