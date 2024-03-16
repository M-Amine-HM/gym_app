import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/auth/def.dart';
import 'package:gym_app/home.dart';

class width extends StatefulWidget {
  const width({super.key});

  @override
  State<width> createState() => _widthState();
}

double imc = 0;
String s = "";
String t = "";
Color c1 = Colors.green;

class _widthState extends State<width> {
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
                // SizedBox(
                //   height: 60,
                // ),
                Text(
                  "Quelle taille faites-vous?",
                  style: TextStyle(
                    color: Color(0xff1d3557),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // SizedBox(
                //   height: 25,
                // ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          TextButton(
                            child: Text(
                              "$poid Kg",
                              style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff669bbc),
                              ),
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 300,
                            height: 70,
                            child: RotatedBox(
                              quarterTurns: -3,
                              child: CupertinoPicker(
                                magnification: 1.2,
                                itemExtent: 45,
                                scrollController: FixedExtentScrollController(
                                  initialItem: 220,
                                ),
                                onSelectedItemChanged: (int value) {
                                  setState(() {
                                    poid = -(value - 249);
                                    imc =
                                        poid / ((taile / 100) * (taile / 100));
                                    s = imc.toStringAsFixed(2);
                                    if (imc > 24.9 || imc < 18.5) {
                                      t = "Vous avez juste besoin d'un peu plus de transpiration pour t'améliorer";
                                      c1 = Color(0xFFe63946);
                                    } else {
                                      c1 = const Color(0xff4c956c);
                                      t = "Vous avez une allure charmante ! Continuez ainsi !";
                                    }
                                  });
                                },
                                children: List.generate(
                                  220,
                                  (index) => Center(
                                    child: RotatedBox(
                                      quarterTurns: 3,
                                      child: Text(
                                        (249 - index).toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xff1d3557)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Votre IMC :",
                            style: TextStyle(
                              color: Color(0xff1d3557),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            child: Text(
                              "$s ",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                color: c1,
                              ),
                            ),
                            onPressed: () {},
                          ),
                          Container(
                            width: 260,
                            child: TextButton(
                              child: Text(
                                "$t ",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: c1,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
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
