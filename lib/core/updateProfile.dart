import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gym_app/core/ImageUpload.dart';
import 'package:gym_app/core/profile.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:gym_app/services/Api.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

//TODO: l page m9asma 3ala zoz l backgroud gris , w kl botton l icon mta3ha mlawen
// 7ata modifier Profile
// ignore: must_be_immutable
class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreen(
      {super.key,
      required this.userEmail,
      required this.theUser,
      this.imageUploaded});

  final String? userEmail;
  User? theUser;
  final File? imageUploaded;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  List<User> userdata = [];
  String _userID = "";
  //File? imagefile = widget.theUser.image;
  TextEditingController _name = TextEditingController();
  TextEditingController _adress = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _height = TextEditingController();
  TextEditingController _weight = TextEditingController();
  bool isOnlyLetters(String input) {
    // Regular expression to match only letters (both uppercase and lowercase)
    final RegExp regex = RegExp(r'^[a-zA-Z]+(?:\s[a-zA-Z]+)*$');
    // Return true if the input string matches the regular expression
    return regex.hasMatch(input);
  }

  bool isEightDigits(String str) {
    // Cette expression régulière vérifie que la chaîne contient exactement 8 chiffres
    final eightDigitsRegex = RegExp(r'^\d{8}$');
    return eightDigitsRegex.hasMatch(str);
  }

  bool isNumeric(String str) {
    // Cette expression régulière vérifie que la chaîne contient uniquement des chiffres
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(str);
  }

  @override
  void initState() {
    _name.text = widget.theUser!.name;
    _adress.text = widget.theUser!.adress;
    _phoneNumber.text = widget.theUser!.phoneNumber;
    _userID = widget.theUser!.id;
    _password.text = widget.theUser!.password;
    _height.text = widget.theUser!.height;
    _weight.text = widget.theUser!.weight;

    super.initState();
  }

//TODO: control de saisie sur les champs num tel , adress et nom
  // bool isValidPhoneNumber(String email) {
  //   // Regular expression pattern for email validation
  //   RegExp regex = RegExp(r'^[\w\.-]+@[a-zA-Z0-9\.-]+\.[a-zA-Z]{2,}$');
  //   return regex.hasMatch(email);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        surfaceTintColor: Colors.grey.shade200,
        leading: IconButton(
          onPressed: () {
            setState(() {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) =>
              //           ProfileScreen(oneUser: widget.theUser)),
              // );
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProfileScreen(oneUser: widget.theUser!),
                  ),
                  (route) => false);
            });
          },
          icon: const Icon(Icons.arrow_back_sharp),
        ),
        centerTitle: true,
        title: Text("Modifier Profil",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: widget.theUser!.image == ""
                            ? Image.asset("assets/images/noPerson.png")
                            : Image.network(
                                "${Api.baseUrl}profile/${widget.theUser!.image}")
                        //Text("Please select an image"),
                        // const Image(
                        //   image: AssetImage("assets/images/AminePhoto.jpg"),
                        // ),
                        ),
                  ),
                  //TODO: icon button bch tfasa5 l image
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkResponse(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => (imageUploadScreen(
                                      theUser: widget.theUser,
                                      userEmail: widget.userEmail,
                                    ))));
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.indigo[600]),
                        child: const Icon(
                          LineAwesomeIcons.camera,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              FutureBuilder(
                  future: Api.getUserByEmail(widget.userEmail),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      // userdata = snapshot.data;
                      // _name.text = userdata[0].name;
                      // _adress.text = userdata[0].adress;
                      // _phoneNumber.text = userdata[0].phoneNumber;
                      // _userID = userdata[0].id;

                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              //shape: BoxShape.rectangle,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                              child: Column(
                                children: [
                                  TextFormField(
                                    //initialValue: "fff",
                                    controller: _name,
                                    decoration: InputDecoration(
                                        //labelText: "dd",
                                        border: InputBorder.none,
                                        label: Text("Nom"),
                                        prefixIcon:
                                            Icon(LineAwesomeIcons.user)),
                                  ),
                                  //const SizedBox(height: 2),
                                  // Row(
                                  //   children: [Icon(LineAwesomeIcons.envelope_1), Text("data")],
                                  // ),
                                  ListTile(
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    leading:
                                        const Icon(LineAwesomeIcons.envelope_1),
                                    title: const Text(
                                      "Email",
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                    subtitle: Text(
                                      widget.userEmail!,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  // const SizedBox(height: 10),
                                  // TextFormField(
                                  //   decoration: const InputDecoration(
                                  //       label: Text("Email"),
                                  //       prefixIcon: Icon(LineAwesomeIcons.envelope_1)),
                                  // ),

                                  TextFormField(
                                    controller: _phoneNumber,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        //contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        label: Text("numéro de téléphone"),
                                        prefixIcon:
                                            Icon(LineAwesomeIcons.phone)),
                                  ),
                                  // const SizedBox(height: 10),
                                  TextFormField(
                                    controller: _adress,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      label: Text("Adresse"),
                                      prefixIcon:
                                          Icon(Icons.location_on_outlined),
                                    ),
                                  ),
                                  TextFormField(
                                    cursorColor: Colors.black,
                                    obscureText: true,
                                    controller: _password,
                                    decoration: const InputDecoration(
                                      // floatingLabelStyle:
                                      //     TextStyle(color: Colors.red),
                                      border: InputBorder.none,
                                      //contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      label: Text("Mot de Passe"),
                                      prefixIcon: Icon(LineAwesomeIcons.key),
                                      //suffixIcon: Icon(LineAwesomeIcons.pen),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              //shape: BoxShape.rectangle,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _height,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      label: Text("Taille (cm)"),
                                      prefixIcon: Icon(Icons.height),
                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    cursorColor: Colors.black,
                                    controller: _weight,
                                    decoration: const InputDecoration(
                                      // floatingLabelStyle:
                                      //     TextStyle(color: Colors.red),
                                      border: InputBorder.none,
                                      //contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      label: Text("Poids (KG)"),
                                      prefixIcon: Icon(LineAwesomeIcons.weight),
                                      //suffixIcon: Icon(LineAwesomeIcons.pen),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            child: ElevatedButton(
                              onPressed: () async {
                                print(_phoneNumber.text.length);
                                if (!isOnlyLetters(_name.text)) {
                                  showToast("Le nom n'est pas valide",
                                      context: context,
                                      backgroundColor: Colors.red,
                                      animation: StyledToastAnimation.fade,
                                      duration: Duration(seconds: 3),
                                      reverseAnimation:
                                          StyledToastAnimation.fade,
                                      alignment: Alignment.center,
                                      position: StyledToastPosition(
                                          align: Alignment.center,
                                          offset: 100));
                                } else if (((_phoneNumber.text).length != 0) &&
                                    (!isEightDigits(_phoneNumber.text))) {
                                  showToast(
                                      "Le numéro de telephone n'est pas valide",
                                      context: context,
                                      backgroundColor: Colors.red,
                                      animation: StyledToastAnimation.fade,
                                      duration: Duration(seconds: 3),
                                      reverseAnimation:
                                          StyledToastAnimation.fade,
                                      alignment: Alignment.center,
                                      position: StyledToastPosition(
                                          align: Alignment.center,
                                          offset: 100));
                                } else if (_password.text.length <= 5) {
                                  showToast(
                                      "Le mot de passe doit contient au moins 6 caractéres",
                                      context: context,
                                      backgroundColor: Colors.red,
                                      animation: StyledToastAnimation.fade,
                                      duration: Duration(seconds: 3),
                                      reverseAnimation:
                                          StyledToastAnimation.fade,
                                      alignment: Alignment.center,
                                      position: StyledToastPosition(
                                          align: Alignment.center,
                                          offset: 100));
                                } else if ((double.tryParse(_height.text) ==
                                        null) ||
                                    (double.parse(_height.text) < 100) ||
                                    (double.parse(_height.text) > 250)) {
                                  showToast(
                                      "La taille doit etre entre 100 et 250",
                                      context: context,
                                      backgroundColor: Colors.red,
                                      animation: StyledToastAnimation.fade,
                                      duration: Duration(seconds: 3),
                                      reverseAnimation:
                                          StyledToastAnimation.fade,
                                      alignment: Alignment.center,
                                      position: StyledToastPosition(
                                          align: Alignment.center,
                                          offset: 100));
                                } else if (double.tryParse(_weight.text) ==
                                    null) {
                                  showToast("La poids n'est pas valide",
                                      context: context,
                                      backgroundColor: Colors.red,
                                      animation: StyledToastAnimation.fade,
                                      duration: Duration(seconds: 3),
                                      reverseAnimation:
                                          StyledToastAnimation.fade,
                                      alignment: Alignment.center,
                                      position: StyledToastPosition(
                                          align: Alignment.center,
                                          offset: 100));
                                } else {
                                  Map Data = {
                                    "name": _name.text,
                                    "phoneNumber": _phoneNumber.text,
                                    "adress": _adress.text,
                                    "password": _password.text,
                                    "weight": _weight.text,
                                    "height": _height.text,
                                  };
                                  await Api.updateUser(_userID, Data);
                                  // setState(() {
                                  //   ProfileScreen(
                                  //     oneUser: widget.theUser!,
                                  //   );
                                  // });
                                  showToast("Modifié avec succés ",
                                      context: context,
                                      backgroundColor: Colors.green,
                                      animation: StyledToastAnimation.fade,
                                      duration: Duration(seconds: 3),
                                      reverseAnimation:
                                          StyledToastAnimation.fade,
                                      alignment: Alignment.center,
                                      position: StyledToastPosition(
                                          align: Alignment.center,
                                          offset: 100));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo[600],
                                  side: BorderSide.none,
                                  shape: const StadiumBorder()),
                              child: const Text("Confirmer",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          // const SizedBox(height: 15),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     const Text.rich(
                          //       TextSpan(
                          //         text: "Nom ",
                          //         style: TextStyle(fontSize: 12),
                          //         children: [
                          //           TextSpan(
                          //               text: "Prénom",
                          //               style: TextStyle(
                          //                   fontWeight: FontWeight.bold,
                          //                   fontSize: 12))
                          //         ],
                          //       ),
                          //     ),
                          //     ElevatedButton(
                          //       onPressed: () {},
                          //       style: ElevatedButton.styleFrom(
                          //           backgroundColor:
                          //               Colors.redAccent.withOpacity(0.1),
                          //           elevation: 0,
                          //           foregroundColor: Colors.red,
                          //           shape: const StadiumBorder(),
                          //           side: BorderSide.none),
                          //       child: const Text("Supprimer le compte"),
                          //     ),
                          //   ],
                          // )
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
