import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/auth/signup.dart';
import 'package:gym_app/home.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:gym_app/services/Api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.oneUser});

  final User oneUser;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _secureText = true;
  TextEditingController _email = TextEditingController(text: "amine@gmail.com");
  bool _textVerifyEmail = true;
  String _errorTextEmail = "Email forme non valide";

  TextEditingController _password = TextEditingController(text: "123456");
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
          "Se Connecter",
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
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
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
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
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
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Mot de passe oublié ?",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              ),
              ElevatedButton(
                child: const Text(
                  "Se connecter",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
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
                      _email.text.isNotEmpty) {
                    if (await Api.getUserByEmail((_email.text)) == null) {
                      print("erreur de serveur");
                      return;
                    }
                    _userdata = await Api.getUserByEmail((_email.text));

                    if (_userdata.isEmpty) {
                      //case : there no user
                      setState(() {
                        _erreurText = "user doesn't exist go sign in";
                      });
                    } else {
                      if (_userdata[0].password != (_password.text)) {
                        setState(() {
                          _erreurText =
                              "password ${_userdata[0].password} is incorrect";
                        });
                      } else {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => Home(
                        //       oneUser: _userdata[0],
                        //     ),
                        //   ),
                        // );
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(
                                oneUser: _userdata[0],
                              ),
                            ),
                            (route) => false);
                      }
                    }
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      // indent: 20,
                      endIndent: 10,

                      thickness: 1.3,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "ou",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Expanded(
                    child: Divider(
                      indent: 10,
                      //endIndent: 20,

                      thickness: 1.3,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              OutlinedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  fixedSize:
                      Size.fromWidth(MediaQuery.of(context).size.width * 1),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => user(
                              oneUser: widget.oneUser,
                            )),
                  );
                },
                icon: Image.asset(
                  "assets/images/google.png",
                  width: 20,
                  height: 20,
                ),
                label: const Text("Se Connecter avec Google",
                    style: TextStyle(color: Colors.black)),
              ),
              //TODO: autre methode d'afficher les erreurs
              SizedBox(
                height: 20,
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
