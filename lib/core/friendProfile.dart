// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/core/chatPage.dart';
import 'package:gym_app/core/chatScreen.dart';
import 'package:gym_app/core/sendPlanPage.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:gym_app/services/Api.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class friendProfileScreen extends StatefulWidget {
  const friendProfileScreen(
      {super.key, required this.email, required this.theUser});
  final User theUser;
  final String email;
  @override
  State<friendProfileScreen> createState() => _friendProfileScreenState();
}

class _friendProfileScreenState extends State<friendProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        surfaceTintColor: Colors.grey.shade200,
        //shadowColor: Colors.grey.shade50,
        title: const Text(
          "Communauté",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: FutureBuilder(
            future: Api.getUserByEmail(widget.email),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                //TODO: if it return null , must handle the error
                List<User> data = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 180,
                      width: 180,
                      child: data[0].image == ""
                          ? ClipOval(
                              child: Image.asset("assets/images/noPerson.png"),
                            )
                          : ClipOval(
                              child: Image.network(
                                  "${Api.baseUrl}profile/" + data[0].image),
                            ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      decoration: BoxDecoration(
                        //shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: [
                            Text(
                              "Nom : ${data[0].name}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Email : ${data[0].email}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              width: 250,
                              child: ElevatedButton.icon(
                                icon: const Icon(
                                  LineAwesomeIcons.sms,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo.shade700,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  fixedSize: Size.fromWidth(
                                      MediaQuery.of(context).size.width * 0.4),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                                theuser: widget.theUser,
                                              )));
                                },
                                label: const Text(
                                  "Messages",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 250,
                              child: ElevatedButton.icon(
                                icon: const Icon(
                                  LineAwesomeIcons.dumbbell,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo[700],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  fixedSize: Size.fromWidth(
                                      MediaQuery.of(context).size.width * 0.4),
                                ),
                                onPressed: () async {
                                  List? thelist = await Api.getPlanByOwner(
                                      widget.theUser.id);

                                  List<bool> booleanList = List<bool>.generate(
                                      thelist!.length, (index) => false);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => sendPlanScreen(
                                                totheUserId: data[0].id,
                                                TheUserName:
                                                    widget.theUser.name,
                                                booleanList: booleanList,
                                                theUserId: widget.theUser.id,
                                              )));
                                },
                                label: const Text(
                                  "Envoyer Plan",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: 30,
                            // ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
