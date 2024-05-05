import 'dart:io';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    _name.text = widget.theUser!.name;
    _adress.text = widget.theUser!.adress;
    _phoneNumber.text = widget.theUser!.phoneNumber;
    _userID = widget.theUser!.id;

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
                            ProfileScreen(oneUser: widget.theUser!)),
                    (route) => false);
              });
            },
            icon: const Icon(Icons.arrow_back_sharp)),
        centerTitle: true,
        title: Text("Modifier Profile",
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
                            : Image.network(widget.theUser!.image)
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
                            color: Colors.blue),
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
              const SizedBox(height: 50),
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
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            child: ElevatedButton(
                              onPressed: () async {
                                Map Data = {
                                  "name": _name.text,
                                  "phoneNumber": _phoneNumber.text,
                                  "adress": _adress.text
                                };
                                await Api.updateUser(_userID, Data);
                                setState(() {
                                  ProfileScreen(
                                    oneUser: widget.theUser!,
                                  );
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
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
