// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gym_app/auth/Emailsignup.dart';
import 'package:gym_app/auth/login.dart';
import 'package:gym_app/auth/signup.dart';
import 'package:gym_app/model/userModel.dart';

class FirstPage extends StatefulWidget {
  FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

User oneUser = User();

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/fpage2.jpg"),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 1,
                ),
                Image(
                  image: AssetImage("assets/images/thelogo.png"),
                  width: 220,
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize:
                        Size.fromWidth(MediaQuery.of(context).size.width * 0.8),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen(
                                oneUser: oneUser,
                              )),
                    );
                  },
                  // icon: Image.asset(
                  //   "assets/images/google.png",
                  //   width: 20,
                  //   height: 20,
                  // ),
                  child: Text("Se connecter",
                      style: TextStyle(color: Colors.black, fontSize: 16)),
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
                    backgroundColor: Colors.indigo.shade600,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize:
                        Size.fromWidth(MediaQuery.of(context).size.width * 0.8),
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
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 35,
                )
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => LoginScreen(
                //                 oneUser: oneUser,
                //               )),
                //     );
                //   },
                //   child: Text(
                //     "Vous Avez déja un compte ? Se Connecter",
                //     style: TextStyle(color: Colors.white, fontSize: 16),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
