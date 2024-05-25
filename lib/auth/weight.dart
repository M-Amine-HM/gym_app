import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/auth/def.dart';
import 'package:gym_app/home.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:gym_app/services/Api.dart';

class weightScreen extends StatefulWidget {
  const weightScreen({super.key, required this.oneUser});

  final User oneUser;

  @override
  State<weightScreen> createState() => _weightScreenState();
}

double imc = 0;
String s = "";
String t = "";
Color c1 = Colors.green.shade600;

class _weightScreenState extends State<weightScreen> {
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        surfaceTintColor: Colors.grey.shade200,
      ),
      backgroundColor: Colors.grey.shade200,
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
                  "Quelle est votre poids ?",
                  style: TextStyle(
                    color: Colors.black,
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
                                color: Colors.indigo.shade700,
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
                                      c1 = Colors.red.shade600;
                                    } else {
                                      c1 = Colors.green.shade600;
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
                              color: Colors.indigo.shade700,
                              fontSize: 30,
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
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: CupertinoButton(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.indigo.shade700,
                    child: Text(
                      "Continuer",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      //TODO : weight mch widht
                      String userWeight = poid.toString();
                      widget.oneUser.weight = userWeight;
                      var data = {
                        "name": widget.oneUser.name,
                        "email": widget.oneUser.email,
                        "password": widget.oneUser.password,
                        "sexe": widget.oneUser.sexe,
                        "height": widget.oneUser.height,
                        "weight": widget.oneUser.weight,
                        "phoneNumber": widget.oneUser.phoneNumber,
                        "adress": widget.oneUser.adress,
                        "image": widget.oneUser.image,
                      };

                      await Api.addUser(data);

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => Home(
                      //             oneUser: widget.oneUser,
                      //           )),
                      // );

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(
                              oneUser: widget.oneUser,
                            ),
                          ),
                          (route) => false);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
