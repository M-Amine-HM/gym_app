import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gym_app/auth/def.dart';
import 'package:gym_app/auth/width.dart';

class taille extends StatefulWidget {
  @override
  _tailleState createState() => _tailleState();
}

class _tailleState extends State<taille> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf1faee),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Quelle taille faites-vous?",
                  style: TextStyle(
                    color: Color(0xff1d3557),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  // height: 600,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          TextButton(
                            child: Text(
                              "$taile cm",
                              style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.w900,
                                color: c,
                              ),
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          gender == true
                              ? Image.asset(
                                  "assets/images/homme.png",
                                  height: 150 + (taile.toDouble() * 1.7),
                                  excludeFromSemantics: true,
                                )
                              : Image.asset(
                                  "assets/images/femme.png",
                                  height: 150 + (taile.toDouble() * 1.7),
                                  excludeFromSemantics: true,
                                ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: 100,
                            height: 500,
                            child: CupertinoPicker(
                              magnification: 1.2,
                              itemExtent: 30,
                              scrollController: FixedExtentScrollController(
                                initialItem: 80,
                              ),
                              onSelectedItemChanged: (int value) {
                                setState(() {
                                  taile = -(value - 209);
                                });
                              },
                              children: List.generate(
                                80,
                                (index) => Center(
                                  child: Text(
                                    (209 - index).toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Color(0xff1d3557)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 40,
                // ),
                CupertinoButton(
                  borderRadius: BorderRadius.circular(25),
                  color: c,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continuer",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => width()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
