import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Function to handle login button press
  void _signInWithEmailAndPassword() async {
    try {
      // Sign in with email and password
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // If login successful, check for specific credential and navigate accordingly
      if (userCredential != null) {
        final User? user = userCredential.user;
        print(user);
        // Check for specific credential
        if (emailController.text == 'admin@gmail.com' &&
            passwordController.text == 'admin123') {
              // Route to a admin page if is a specific credential
          Navigator.pushNamed(context, "/adminpage");
        } else {
          // Route to a default page if not a specific credential
          Navigator.pushNamed(context, "/homeage");
        }
      }
    } on FirebaseAuthException catch (e) {
      // Handle login errors
      print('Error: $e');
      // You can display an error message to the user here
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: Colors.deepPurple, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      });
  }

  @override
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwdcontroller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
              padding: EdgeInsets.only(top: 45, left: 20, right: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 27, 1, 95),
                    Color.fromARGB(224, 72, 64, 165),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 110))),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.only(left: 30, right: 30, top: 90),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome to Our Book Store',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gloock'),
                      ),
                      const Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 35),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gloock'),
                        ),
                      ),
                      Material(
                        elevation: 6.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 30, 40, 30),
                                child: TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFececf8),
                                      labelText: 'Email Address',
                                      labelStyle:
                                          TextStyle(fontFamily: 'Manrope'),
                                      prefixIcon: Icon(Icons.email),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      )),
                                  onChanged: (String value) {},
                                  validator: (value) {
                                    return value!.isEmpty
                                        ? 'Please enter email'
                                        : emailController.text = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 0, 40, 0),
                                child: TextFormField(
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFFececf8),
                                    labelText: 'Password',
                                    labelStyle:
                                        TextStyle(fontFamily: 'Manrope'),
                                    prefixIcon: Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onChanged: (String value) {},
                                  validator: (value) {
                                    return value!.isEmpty
                                        ? 'Please enter password'
                                        : passwordController.text = value;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: _signInWithEmailAndPassword,
                                child: Material(
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 275,
                                    child:const Padding(
                                      padding:  EdgeInsets.only(
                                          bottom: 5, top: 5),
                                      child: Center(
                                          child: Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontFamily: 'Catamaran'),
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: widget.onTap,
                                child:const  Padding(
                                  padding:
                                       EdgeInsets.fromLTRB(0, 10, 0, 20),
                                  child: Text(
                                    'Not a member? Register now',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontFamily: 'Manrope',
                                        fontSize: 17),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
