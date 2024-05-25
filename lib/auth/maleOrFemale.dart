import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/auth/def.dart';
import 'package:gym_app/auth/height.dart';
import 'package:gym_app/model/userModel.dart';
// import 'package:pfe/auth/taille.dart';
// import 'package:pfe/def.dart';

class maleOrFemaleScreen extends StatefulWidget {
  const maleOrFemaleScreen({super.key, required this.oneUser});
  final User oneUser;

  @override
  State<maleOrFemaleScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<maleOrFemaleScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> positionAnimation;
  late Animation<double> scaleAnimation;
  late Animation<double> scaleAnimation1;
  late AnimationController controller1;
  late Animation<Offset> positionAnimation1;

  @override
  void initState() {
    super.initState();
    homme_ou_femme = "";
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller1 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    positionAnimation = Tween<Offset>(
      begin: Offset(-0.1, 0.0), // Start from the right
      end: Offset(0.4, 0.0), // Move towards the left
    ).animate(controller);
    positionAnimation1 = Tween<Offset>(
      begin: Offset(0.1, 0.0), // Start from the right
      end: Offset(-0.4, 0.0), // Move towards the left
    ).animate(controller1);
    // Use Tween for scaling animation
    scaleAnimation = Tween<double>(
      begin: 1.4, // Start with the original size
      end: 2.0, // Scale to double the size
    ).animate(controller);
    scaleAnimation1 = Tween<double>(
      begin: 1.4, // Start with the original size
      end: 2.2, // Scale to double the size
    ).animate(controller1);
  }

  final List img = [
    Image.asset("assets/images/null.jpg"),
    Image.asset("assets/images/homme_logo.png"),
    Image.asset("assets/images/femme_logo.png")
  ];

  final List<String> sexe = ["", " homme_logo ", " femme_logo "];
  int i = 0;
  String homme_ou_femme = "";

  @override
  void dispose() {
    controller.dispose();
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Text(
                      "Quel est votre sexe ?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   width: 22,
                        // ),
                        Expanded(
                          child: Container(
                            // width: MediaQuery.of(context).size.width * 0.4,
                            child: CupertinoButton(
                              onPressed: () {
                                controller.forward();
                                setState(() {
                                  controller1.reverse();
                                  i = 1;
                                  c = Colors.indigo.shade700;
                                  //TODO :gender true = male ?
                                  gender = true;
                                  homme_ou_femme = "homme";
                                });
                              },
                              child: ScaleTransition(
                                  scale: scaleAnimation,
                                  child: SlideTransition(
                                      position: positionAnimation,
                                      child: Container(
                                          height: 200,
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/images/homme.png"))))),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 30,
                        // ),
                        Expanded(
                          child: Container(
                            //    width: MediaQuery.of(context).size.width * 0.4,
                            child: CupertinoButton(
                              onPressed: () {
                                controller1.forward();
                                setState(() {
                                  controller.reverse();
                                  i = 2;
                                  c = Color(0xffe63946);
                                  gender = false;
                                  homme_ou_femme = "femme";
                                });
                              },
                              child: ScaleTransition(
                                  scale: scaleAnimation1,
                                  child: SlideTransition(
                                      position: positionAnimation1,
                                      child: Container(
                                          height: 200,
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/images/femme.png"))))),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 22,
                        // ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 90,
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    i == 0
                        ? Container(
                            child: img[1],
                            height: 30,
                          )
                        : Container(
                            color: Colors.green,
                            //child: img[0],
                            height: 100,
                          ),
                    Spacer(),
                    i == 0
                        ? Container(
                            child: img[2],
                            height: 30,
                          )
                        : Container(
                            color: Colors.green,
                            //child: img[0],
                            height: 100,
                          ),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              i == 0
                  ? Container(
                      height: 80,
                      color: Colors.grey.shade200,
                    )
                  : Container(
                      child: img[i],
                      height: 80,
                    ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: CupertinoButton(
                  borderRadius: BorderRadius.circular(25),
                  color: c,
                  child: Text(
                    "Continuer",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    //kanet gender de type bool radetha String 5atr maynajm yet3ada lil page lo5ra kan maya5tar l sexe
                    // String maleOrfemale = "";
                    // if (gender) {
                    //   maleOrfemale = "homme";
                    // } else {
                    //   maleOrfemale = "femme";
                    // }
                    if (homme_ou_femme != "") {
                      widget.oneUser.sexe = homme_ou_femme;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => heightScreen(
                                  oneUser: widget.oneUser,
                                )),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      )),
    );
  }
}
