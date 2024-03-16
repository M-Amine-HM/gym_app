// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gym_app/auth/Emailsignup.dart';
import 'package:gym_app/auth/login.dart';
import 'package:gym_app/auth/signup.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/image1.png"),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Image(
                  image: AssetImage("assets/images/logo2.png"),
                  width: 100,
                ),
                Spacer(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    fixedSize:
                        Size.fromWidth(MediaQuery.of(context).size.width * 1),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => user()),
                    );
                  },
                  icon: Image.asset(
                    "assets/images/google.png",
                    width: 20,
                    height: 20,
                  ),
                  label: Text("S'inscrire avec Google",
                      style: TextStyle(color: Colors.black)),
                  // child: Row(
                  //   children: [
                  //     Icon(Icons.home),
                  //     Text("S'inscrire avec Google")
                  //   ],
                  // ),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    fixedSize:
                        Size.fromWidth(MediaQuery.of(context).size.width * 1),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmailSignupScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "S'inscrire avec un Email",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    "Vous Avez déja un compte ? Se Connecter",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
