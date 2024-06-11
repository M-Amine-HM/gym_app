import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/controller/chatController.dart';
import 'package:gym_app/model/message.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:gym_app/services/Api.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, required this.theuser}) : super(key: key);
  final User theuser;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgInputController = TextEditingController();
  ChatController chatController = ChatController();

  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  void initSocket() {
    socket = IO.io(
      'http://192.168.1.14:2000',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect() // Enable auto connection
          .setReconnectionAttempts(10) // Try to reconnect 10 times
          .setReconnectionDelay(500) // Wait 500ms before each attempt
          .build(),
    );

    socket.connect();
    setUpSocketListener();
  }

  void setUpSocketListener() {
    socket.on('connect', (_) {
      print('Connected: ${socket.id}');
    });

    socket.on('disconnect', (reason) {
      print('Disconnected. Reason: $reason');
    });

    socket.on('connect_error', (error) {
      print('Connection error: $error');
    });

    socket.on('message-receive', (data) {
      print('Message received: $data');
      chatController.chatMesssages.add(Message.fromJson(data));
    });
  }

  void sendMessage(String text) {
    var messageJson = {"message": text, "sentByMe": socket.id};
    print('Sending message: $messageJson'); // Debug print
    socket.emit('message', messageJson);
    chatController.chatMesssages.add(Message.fromJson(messageJson));
  }

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
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                //shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Obx(
                  () => ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: chatController.chatMesssages.length,
                    itemBuilder: (context, index) {
                      var currentITem = chatController.chatMesssages[index];
                      return MessageItem(
                        message: currentITem.message,
                        sentByMe: currentITem.sentByMe == socket.id,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  height: 60,
                  padding: EdgeInsets.all(3),
                  //color: Colors.grey.shade500,
                  child: TextFormField(
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 18),
                      contentPadding: EdgeInsets.fromLTRB(20, 20, 10, 20),
                      filled: true,
                      fillColor: Colors.grey[400],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      hintText: "message",
                      // prefixIcon: Icon(Icons.search),
                      prefixIconColor: Colors.grey.shade700,
                      // suffixIcon: Container(
                      //   margin: EdgeInsets.only(right: 10),
                      //   decoration: BoxDecoration(
                      //     color: Colors.blue,
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: IconButton(
                      //     color: Colors.white,
                      //     onPressed: () {
                      //       sendMessage(msgInputController.text);
                      //       msgInputController.clear();
                      //     },
                      //     icon: Icon(Icons.send),
                      //   ),
                      // ),
                    ),
                    controller: msgInputController,
                  ),
                ),
              ),
              Expanded(
                //width: MediaQuery.sizeOf(context).width * 0.15,
                child: IconButton(
                  color: Colors.indigo,
                  onPressed: () {
                    sendMessage(msgInputController.text);
                    msgInputController.clear();
                  },
                  icon: Icon(Icons.send),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  final bool sentByMe;
  final String message;
  MessageItem({Key? key, required this.sentByMe, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: message.length < 65 ? null : 350,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: BoxDecoration(
          color: sentByMe ? Colors.indigo[700] : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            message,
            style: TextStyle(
                color: sentByMe ? Colors.white : Colors.black,
                fontSize: 23,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
