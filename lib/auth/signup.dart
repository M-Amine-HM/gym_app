import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/auth/homme_femme.dart';
//import 'package:pfe/homme_femme.dart';

class user extends StatefulWidget {
  const user({super.key});

  @override
  State<user> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<user> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1faee),
      appBar: AppBar(
          backgroundColor: const Color(0xffa8dadc), // Background color
          elevation: 2, // Shadow elevation
          centerTitle: true,
          title: Text(
            "S'inscrire",
            style: TextStyle(
              color: Color(0xff1d3557),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          )),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Nom d'utilisateur",
              style: TextStyle(
                  color: Color(0xff1d3557),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Entrez votre nom d'utilisateur",
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xff1d3557),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Color(0xff457b9d), width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Color(0xff457b9d), width: 2.0),
                ),
              ),
              style: TextStyle(color: Color(0xff1d3557)),
              cursorColor: Colors.blueAccent,
              keyboardType: TextInputType.text,
            ),
            // Text(
            //   "Quelle âge avez-vous",
            //   style: TextStyle(
            //     color: Color(0xff1d3557),
            //     fontSize: 30,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(
            //   height: 25,
            // ),
            // Container(
            //   height: 200,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Column(
            //         children: [
            //           TextButton(
            //             child: Text(
            //               "$age Ans",
            //               style: TextStyle(
            //                 fontSize: 45,
            //                 fontWeight: FontWeight.w900,
            //                 color: c,
            //               ),
            //             ),
            //             onPressed: () {},
            //           ),
            //           SizedBox(
            //             height: 8,
            //           ),
            //           SizedBox(
            //             width: 300,
            //             height: 70,
            //             child: RotatedBox(
            //               quarterTurns: -3,
            //               child: CupertinoPicker(
            //                 magnification: 1.2,
            //                 itemExtent: 45,
            //                 scrollController: FixedExtentScrollController(
            //                   initialItem: 98,
            //                 ),
            //                 onSelectedItemChanged: (int value) {
            //                   setState(() {
            //                     age = -(value - 104);
            //                   });
            //                 },
            //                 children: List.generate(
            //                   98,
            //                   (index) => Center(
            //                     child: RotatedBox(
            //                       quarterTurns: 3,
            //                       child: Text(
            //                         (104 - index).toString(),
            //                         style: TextStyle(
            //                             fontSize: 20, color: Color(0xff1d3557)),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 25,
            ),
            CupertinoButton(
              borderRadius: BorderRadius.circular(25),
              color: Color(0xff457b9d),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Continuer",
                    style: TextStyle(
                        color: Color(0xff1d3557),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: ((context) => h_f())));
              },
            )
          ],
        ),
      )),
    );
  }
}
