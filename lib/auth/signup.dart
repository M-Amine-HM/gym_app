import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gym_app/auth/maleOrFemale.dart';
import 'package:gym_app/model/userModel.dart';
//import 'package:pfe/homme_femme.dart';

class user extends StatefulWidget {
  user({super.key, required this.oneUser});

//   final String userEmail;
// final String userPassword;
  final User oneUser;
  @override
  State<user> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<user> {
  bool isOnlyLetters(String input) {
    // Regular expression to match only letters (both uppercase and lowercase)
    final RegExp regex = RegExp(r'^[a-zA-Z]+(?:\s[a-zA-Z]+)*$');
    // Return true if the input string matches the regular expression
    return regex.hasMatch(input);
  }

  bool? _ischecked = false;
  bool _secureText = true;
  TextEditingController _email = TextEditingController();
  bool _textVerifyName = true;
  String _errorTextEmail = "Email forme non valide";

  TextEditingController _password = TextEditingController();
  bool _textVerifyPassword = true;
  bool isValidEmail(String email) {
    // Regular expression pattern for email validation
    RegExp regex = RegExp(r'^[\w\.-]+@[a-zA-Z0-9\.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  // User oneUser = User();
  TextEditingController _userName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, // Background color
        //elevation: 2, // Shadow elevation
        centerTitle: true,
        title: Text(
          "S'inscrire",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
        child: Container(
          height: 500,
          decoration: BoxDecoration(
            //shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 80),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nom d'utilisateur",
                  style: TextStyle(
                      color: Colors.indigo[700],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _userName,
                  onChanged: (value) {
                    setState(() {
                      if (isOnlyLetters(_userName.text)) {
                        _textVerifyName = true;
                      } else {
                        _textVerifyName = false;
                      }
                    });
                  },
                  decoration: InputDecoration(
                    errorText: _textVerifyName
                        ? null
                        : "nom contient uniquement des lettres",
                    hintText: "Entrez votre nom d'utilisateur",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.indigo[700],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          BorderSide(color: Colors.indigo.shade700, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          BorderSide(color: Colors.indigo.shade700, width: 2.0),
                    ),
                  ),
                  style: TextStyle(color: Color(0xff1d3557)),
                  cursorColor: Colors.blueAccent,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Mot de passe",
                  style: TextStyle(
                      color: Colors.indigo[700],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      if (_password.text.toString().length >= 6) {
                        _textVerifyPassword = true;
                      } else {
                        _textVerifyPassword = false;
                      }
                    });
                  },
                  obscureText: _secureText,
                  controller: _password,
                  decoration: InputDecoration(
                    errorText: _textVerifyPassword
                        ? null
                        : "Mot de passe doit contenir au plus 6 caractéres",
                    suffixIcon: IconButton(
                      icon: Icon(_secureText
                          ? CupertinoIcons.eye_fill
                          : CupertinoIcons.eye_slash_fill),
                      onPressed: () {
                        setState(() {
                          _secureText = !_secureText;
                        });
                      },
                    ),
                    hintText: "Entrez mot de passe",
                    prefixIcon: Icon(
                      Icons.key,
                      color: Colors.indigo[700],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          BorderSide(color: Colors.indigo.shade700, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          BorderSide(color: Colors.indigo.shade700, width: 2.0),
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
                  height: 20,
                ),

                CupertinoButton(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.indigo[600],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continuer",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onPressed: () {
                    if (isOnlyLetters(_userName.text) &&
                        (_textVerifyPassword)) {
                      String username = _userName.text;
                      widget.oneUser.name = username;
                      widget.oneUser.password = _password
                          .text; //send the user name with other attirbutes
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => maleOrFemaleScreen(
                                oneUser: widget.oneUser,
                              )),
                        ),
                      );
                      print(
                        widget.oneUser.sexe,
                      );
                    } else {
                      showToast("Les champs ne sont pas valides",
                          backgroundColor: Colors.red,
                          context: context,
                          animation: StyledToastAnimation.fade,
                          duration: Duration(seconds: 3),
                          reverseAnimation: StyledToastAnimation.fade,
                          alignment: Alignment.center,
                          position: StyledToastPosition(
                              align: Alignment.center, offset: 100));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
