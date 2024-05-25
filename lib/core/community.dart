import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/core/friendProfile.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:gym_app/services/Api.dart';

// TODO: y9bl kan png wel jpg images khw
class coummunityScreen extends StatefulWidget {
  const coummunityScreen({super.key});

  @override
  State<coummunityScreen> createState() => _coummunityScreenState();
}

class _coummunityScreenState extends State<coummunityScreen> {
  //list of movies

  TextEditingController _name = TextEditingController(text: "");

  // static List<User> theUsers = [];

  // void _submitForm() {
  //   // Handle form submission logic here
  //   String fieldValue = _name.text;
  //   print('Field Value: $fieldValue');
  //   setState(() {});
  // }
  String theimagepaths = "${Api.baseUrl}profile/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          surfaceTintColor: Colors.grey.shade200,
          centerTitle: true,
          title: Text(
            "Community",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: FutureBuilder(
            future: _name.text.isEmpty
                ? Api.getUsers()
                : Api.getUsersByNames(_name.text),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List? thedata = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Search for a user",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    TextFormField(
                      controller: _name,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[400],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          hintText: "eg : Amine",
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Colors.grey.shade900),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          //shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListView.builder(
                          // scrollDirection: Axis.vertical,
                          //physics: NeverScrollableScrollPhysics(),
                          //shrinkWrap: true,
                          itemCount: thedata!.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => friendProfileScreen(
                                          email: (thedata[index]).email,
                                        )),
                              );
                            },
                            child: ListTile(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 1, 5, 1),
                                title: Text(
                                  thedata[index].name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  thedata[index].email,
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                                // trailing: Text(
                                //   snapshot.data[index].weight,
                                //   style: TextStyle(color: Colors.amber),
                                // ),

                                leading: theimagepaths +
                                                snapshot.data[index].image ==
                                            "${Api.baseUrl}profile/" ||
                                        theimagepaths +
                                                snapshot.data[index].image ==
                                            ""
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                          "assets/images/noPerson.png",
                                          fit: BoxFit.cover,
                                          height: 80,
                                          width: 55,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          theimagepaths +
                                              thedata[index]
                                                  .image, //snapshot.data[index].image,
                                          fit: BoxFit.cover,
                                          height: 80,
                                          width: 55,
                                        ),
                                      )
                                // CircleAvatar(
                                //   backgroundColor: Colors.blue,
                                // ),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ));
  }
}
