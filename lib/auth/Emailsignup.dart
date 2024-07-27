import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gym_app/auth/signup.dart';
//import 'package:gym_app/auth/width.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:gym_app/services/Api.dart';

class EmailSignupScreen extends StatefulWidget {
  const EmailSignupScreen({super.key});

  @override
  State<EmailSignupScreen> createState() => _EmailSignupScreenState();
}

class _EmailSignupScreenState extends State<EmailSignupScreen> {
  User oneUser = User();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _codeIsSent = true;
  }

  late bool? _codeIsSent;
  int _thecode = 1;
  bool? _ischecked = false;
  bool _secureText = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _verificationCode = TextEditingController();
  bool _textVerifyEmail = true;
  String _errorTextEmail = "Email forme non valide";

  TextEditingController _password = TextEditingController();
  bool _textVerifyPassword = true;
  bool isValidEmail(String email) {
    // Regular expression pattern for email validation
    RegExp regex = RegExp(r'^[\w\.-]+@[a-zA-Z0-9\.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  List? _userdata = [];
  //TODO: erreur text ki famech user wela 8alet fl password
  String _erreurText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "S'inscrire",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  TextFormField(
                    enabled: _codeIsSent,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "exemple@gmail.com",
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      errorText: _textVerifyEmail ? null : _errorTextEmail,
                      //errorText: _errorTextEmail,
                    ),
                    controller: _email,
                    onTap: () {
                      _textVerifyEmail = false;
                    },
                    onChanged: (value) {
                      setState(() {
                        String email = _email.text.toString();
                        _textVerifyEmail = isValidEmail(email);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo.shade700,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          fixedSize: Size.fromWidth(
                              MediaQuery.of(context).size.width * 0.8),
                        ),
                        onPressed: () async {
                          if (isValidEmail(_email.text)) {
                            setState(() {
                              _codeIsSent = false;
                            });
                            _thecode =
                                await Api.getVerificationCode(_email.text);
                            print(_thecode);
                            showToast(
                                "Code de verification est envoyé a votre email",
                                context: context,
                                backgroundColor: Colors.green,
                                animation: StyledToastAnimation.fade,
                                duration: Duration(seconds: 3),
                                reverseAnimation: StyledToastAnimation.fade,
                                alignment: Alignment.center,
                                position: StyledToastPosition(
                                    align: Alignment.center, offset: 100));
                          } else {
                            showToast("l'email n'est pas valide",
                                context: context,
                                backgroundColor: Colors.red,
                                animation: StyledToastAnimation.fade,
                                duration: Duration(seconds: 3),
                                reverseAnimation: StyledToastAnimation.fade,
                                alignment: Alignment.center,
                                position: StyledToastPosition(
                                    align: Alignment.center, offset: 100));
                          }
                        },
                        //amine@gmail.com
                        child: const Text(
                          "Envoyer code de vérification",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Code de vérification",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Entrer code de vérification",
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      // suffixIcon: IconButton(
                      //   icon: Icon(_secureText
                      //       ? CupertinoIcons.eye_fill
                      //       : CupertinoIcons.eye_slash_fill),
                      //   onPressed: () {
                      //     setState(() {
                      //       _secureText = !_secureText;
                      //     });
                      //   },
                      // ),
                      //errorText: _textVerifyEmail ? _errorTextEmail : null,
                      // errorText: _textVerifyPassword
                      //     ? null
                      //     : "Mot de passe doit contenir au plus 6 caractéres",
                    ),
                    //obscureText: _secureText,
                    controller: _verificationCode,
                    onTap: () {
                      _textVerifyPassword = false;
                    },
                    onChanged: (value) {
                      setState(() {
                        if (_password.text.toString().length >= 6) {
                          _textVerifyPassword = true;
                        } else {
                          _textVerifyPassword = false;
                        }
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              // ListTile(
              //   contentPadding: const EdgeInsets.only(left: 0, right: 25),
              //   leading: Checkbox(
              //       activeColor: Colors.indigo.shade700,
              //       value: _ischecked,
              //       onChanged: (newBool) {
              //         setState(() {
              //           _ischecked = newBool;
              //         });
              //       }),
              //   title: RichText(
              //     text: TextSpan(
              //       style: const TextStyle(fontSize: 17),
              //       children: [
              //         const TextSpan(
              //           text: "J'accepte les ",
              //           style: TextStyle(color: Colors.black),
              //         ),
              //         TextSpan(
              //           text: "conditions génerales ",
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             color: Colors.indigo.shade600,
              //           ),
              //           recognizer: TapGestureRecognizer()
              //             ..onTap = () {
              //               //TODO: page qui contient les conditons generales
              //             },
              //         ),
              //         const TextSpan(
              //           text: "et la ",
              //           style: TextStyle(color: Colors.black),
              //         ),
              //         TextSpan(
              //           text: "politique de la confidentialité",
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             color: Colors.indigo.shade600,
              //           ),
              //           recognizer: TapGestureRecognizer()
              //             ..onTap = () {
              //               //TODO: page qui contient les conditons generales
              //             },
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade700,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize:
                      Size.fromWidth(MediaQuery.of(context).size.width * 0.8),
                ),
                onPressed: () async {
                  if (_textVerifyEmail && _email.text.isNotEmpty) {
                    String email = _email.text;
                    String password = _password.text;
                    oneUser.email = email;
                    oneUser.password = password;

                    _userdata = await Api.getUserByEmail((email));
                    if (_userdata == null) {
                      showToast("Pas de connection avec le serveur",
                          context: context,
                          backgroundColor: Colors.red,
                          animation: StyledToastAnimation.fade,
                          duration: Duration(seconds: 3),
                          reverseAnimation: StyledToastAnimation.fade,
                          alignment: Alignment.center,
                          position: StyledToastPosition(
                              align: Alignment.center, offset: 100));
                      return;
                    }
                    if (_userdata!.isEmpty) {
                      if (_verificationCode.text != _thecode.toString()) {
                        showToast("le code de verification est incorrecte",
                            context: context,
                            backgroundColor: Colors.red,
                            animation: StyledToastAnimation.fade,
                            duration: Duration(seconds: 3),
                            reverseAnimation: StyledToastAnimation.fade,
                            alignment: Alignment.center,
                            position: StyledToastPosition(
                                align: Alignment.center, offset: 100));
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => user(
                                    oneUser: oneUser,
                                  )),
                        );
                      }
                    } else {
                      if (_userdata![0].email == (_email.text)) {
                        //case : there no user
                        //setState(() {
                        _erreurText = "Le compte est déja utilisé ";
                        showToast(_erreurText,
                            context: context,
                            backgroundColor: Colors.red,
                            animation: StyledToastAnimation.fade,
                            duration: Duration(seconds: 3),
                            reverseAnimation: StyledToastAnimation.fade,
                            alignment: Alignment.center,
                            position: StyledToastPosition(
                                align: Alignment.center, offset: 100));
                        //});
                      }
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Home(
                      //       oneUser: _userdata[0],
                      //     ),
                      //   ),
                      // );
                    }
                  } else {
                    showToast("Veuillez remplir les champs",
                        context: context,
                        backgroundColor: Colors.red,
                        animation: StyledToastAnimation.fade,
                        duration: Duration(seconds: 3),
                        reverseAnimation: StyledToastAnimation.fade,
                        alignment: Alignment.center,
                        position: StyledToastPosition(
                            align: Alignment.center, offset: 100));
                  }

                  //TODO : badll esm user screen
                },
                //amine@gmail.com
                child: const Text(
                  "Continuer",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // Text(
              //   _erreurText,
              //   style: TextStyle(fontSize: 25, color: Colors.red),
              // )
            ],
          ),
        ),
      )),
    );
  }
}
