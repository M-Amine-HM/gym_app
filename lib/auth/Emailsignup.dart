import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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

  bool? _ischecked = false;
  bool _secureText = true;
  TextEditingController _email = TextEditingController();
  bool _textVerifyEmail = true;
  String _errorTextEmail = "Email forme non valide";

  TextEditingController _password = TextEditingController();
  bool _textVerifyPassword = true;
  bool isValidEmail(String email) {
    // Regular expression pattern for email validation
    RegExp regex = RegExp(r'^[\w\.-]+@[a-zA-Z0-9\.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  List<User> _userdata = [];
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
                  const Text(
                    "Mot de passe",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Minimum 6 caractéres",
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
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
                      //errorText: _textVerifyEmail ? _errorTextEmail : null,
                      errorText: _textVerifyPassword
                          ? null
                          : "Mot de passe doit contenir au plus 6 caractéres",
                    ),
                    obscureText: _secureText,
                    controller: _password,
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
              ListTile(
                contentPadding: const EdgeInsets.only(left: 0, right: 25),
                leading: Checkbox(
                    activeColor: Colors.blue,
                    value: _ischecked,
                    onChanged: (newBool) {
                      setState(() {
                        _ischecked = newBool;
                      });
                    }),
                title: RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 17),
                    children: [
                      const TextSpan(
                        text: "J'accepte les ",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: "conditions génerales ",
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            //TODO: page qui contient les conditons generales
                          },
                      ),
                      const TextSpan(
                        text: "et la ",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: "politique de la confidentialité",
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            //TODO: page qui contient les conditons generales
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  fixedSize:
                      Size.fromWidth(MediaQuery.of(context).size.width * 1),
                ),
                onPressed: () async {
                  if (_textVerifyEmail &&
                      _textVerifyPassword &&
                      _password.text.isNotEmpty &&
                      _email.text.isNotEmpty &&
                      _ischecked == true) {
                    String email = _email.text;
                    String password = _password.text;
                    oneUser.email = email;
                    oneUser.password = password;

                    _userdata = await Api.getUserByEmail((email));

                    if (_userdata.isEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => user(
                                  oneUser: oneUser,
                                )),
                      );
                    } else {
                      if (_userdata[0].email == (_email.text)) {
                        //case : there no user
                        setState(() {
                          _erreurText = "user is already exist try to connect";
                        });
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
              Text(
                _erreurText,
                style: TextStyle(fontSize: 25, color: Colors.red),
              )
            ],
          ),
        ),
      )),
    );
  }
}
