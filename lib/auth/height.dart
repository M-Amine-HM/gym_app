import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gym_app/auth/def.dart';
import 'package:gym_app/auth/weight.dart';
import 'package:gym_app/model/userModel.dart';

class heightScreen extends StatefulWidget {
  const heightScreen({super.key, required this.oneUser});
  final User oneUser;

  @override
  _heightScreenState createState() => _heightScreenState();
}

//late bool sexe;
late Color theColor;

class _heightScreenState extends State<heightScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.oneUser.sexe == "homme") {
      theColor = Colors.indigo.shade700;
    } else {
      theColor = Colors.red.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.grey.shade200,
        backgroundColor: Colors.grey.shade200,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Quelle taille faites-vous?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                // height: 600,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "$taile cm",
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w900,
                            color: theColor,
                          ),
                        ),

                        // SizedBox(
                        //   height: 8,
                        // ),
                        gender == true
                            ? Image.asset(
                                "assets/images/homme.png",
                                height: 150 + (taile.toDouble() * 1.5),
                                excludeFromSemantics: true,
                              )
                            : Image.asset(
                                "assets/images/femme.png",
                                height: 150 + (taile.toDouble() * 1.5),
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
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: CupertinoButton(
                  borderRadius: BorderRadius.circular(25),
                  color: theColor,
                  child: Text(
                    "Continuer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    String userHeight = taile.toString();
                    widget.oneUser.height = userHeight;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                weightScreen(oneUser: widget.oneUser)));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
