import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:gym_app/services/Api.dart';

class chatScreen extends StatefulWidget {
  chatScreen({super.key, required this.theuser});
  final User theuser;

  @override
  State<chatScreen> createState() => _chatScreenState();
}

TextEditingController _message = TextEditingController(text: "");
String labelText = "";

class _chatScreenState extends State<chatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        //centerTitle: false,
        backgroundColor: Colors.grey.shade200,
        surfaceTintColor: Colors.grey.shade200,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 28,
              // height: 180,
              // width: 180,
              child: widget.theuser.image == ""
                  ? ClipOval(
                      child: Image.asset("assets/images/noPerson.png"),
                    )
                  : ClipOval(
                      child: Image.network(
                          "${Api.baseUrl}profile/" + widget.theuser.image),
                    ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              widget.theuser.name,
              style: TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  //shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      sender(
                        message: "hello",
                      ),
                      reciever(
                          message:
                              "Hi how are youjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj"),
                      reciever(message: "can yous send me a plan"),
                      sender(
                        message: "yes sure how many exercises do you want",
                      ),
                      reciever(
                          message:
                              "5 exercisesllllllllllllllllllllllllllllhhhhhhhhhhhhllllllllllllllllllllllllllllllll"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    // height: 50,
                    //width: MediaQuery.sizeOf(context).width * 0.85,
                    child: TextFormField(
                      style: TextStyle(fontSize: 20),
                      controller: _message,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                          //labelText: labelText,
                          hintStyle: TextStyle(fontSize: 18),
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 10, 20),
                          filled: true,
                          fillColor: Colors.grey[400],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          hintText: "message",
                          // prefixIcon: Icon(Icons.search),
                          prefixIconColor: Colors.grey.shade700),
                    ),
                  ),
                  Expanded(
                      //width: MediaQuery.sizeOf(context).width * 0.15,
                      child: IconButton(
                          onPressed: () {
                            _message.clear();
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.indigo.shade700,
                          )))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class reciever extends StatelessWidget {
  const reciever({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    // bool bo;
    // if (message.length > 10) {
    //   bo = true;
    // } else {
    //   bo = false;
    // }

    return Column(
      children: [
        Row(
          //crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              //alignment: Alignment.bottomLeft,
              //transformAlignment: Alignment.bottomLeft,
              //height: 80,
              width: message.length < 65 ? null : 350,
              decoration: BoxDecoration(
                //shape: BoxShape.rectangle,
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  message,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class sender extends StatelessWidget {
  const sender({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          //crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              //alignment: Alignment.bottomLeft,
              //transformAlignment: Alignment.bottomLeft,
              //height: 80,
              width: message.length < 65 ? null : 350,
              decoration: BoxDecoration(
                //shape: BoxShape.rectangle,
                color: Colors.indigo.shade700,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  child: Text(
                    message,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
