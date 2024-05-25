import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:gym_app/services/Api.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class friendProfileScreen extends StatefulWidget {
  const friendProfileScreen({super.key, required this.email});

  final String email;
  @override
  State<friendProfileScreen> createState() => _friendProfileScreenState();
}

class _friendProfileScreenState extends State<friendProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Community",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
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
                      height: 50,
                    ),
                    Text(
                      "Name : ${data[0].name}",
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
                        icon: Icon(
                          LineAwesomeIcons.sms,
                          size: 25,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          fixedSize: Size.fromWidth(
                              MediaQuery.of(context).size.width * 0.4),
                        ),
                        onPressed: () {},
                        label: const Text(
                          "Messages",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 250,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          LineAwesomeIcons.dumbbell,
                          size: 25,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          fixedSize: Size.fromWidth(
                              MediaQuery.of(context).size.width * 0.4),
                        ),
                        onPressed: () {},
                        label: const Text(
                          "Envoyer Plan",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
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
