import 'package:flutter/material.dart';

class OnGoingPlanScreen extends StatefulWidget {
  const OnGoingPlanScreen({super.key});

  @override
  State<OnGoingPlanScreen> createState() => _OnGoingPlanScreenState();
}

class _OnGoingPlanScreenState extends State<OnGoingPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[700],
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: Colors.blue[700],
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              tooltip: 'Comment Icon',
              onPressed: () {},
            ), //IconButton
            //IconButton
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nom de Plan",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Date de creation",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  //shape: BoxShape.rectangle,
                  color: Colors.grey[300],
                  // borderRadius: BorderRadius.circular(18),
                ),
                child: ListView.builder(
                    itemBuilder: ((context, index) => ExerciceWidget(
                          onTap: () {},
                          bodyPartImage: "chestflyes.png",
                          bodyPartName: "Arm Chest flyes plies à la machine",
                        )),
                    // separatorBuilder: (context, index) => const SizedBox(
                    //       height: 0,
                    //     ),
                    itemCount: 20),
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize:
                            Size((MediaQuery.of(context).size.width * 0.9), 45),
                      ),
                      onPressed: () {},
                      child: Text(
                        "DEBUT",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize:
                            Size((MediaQuery.of(context).size.width * 0.9), 45),
                      ),
                      onPressed: () {},
                      child: Text(
                        "MODIFIER",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ));
  }
}

class ExerciceWidget extends StatelessWidget {
  ExerciceWidget(
      {super.key,
      required this.bodyPartImage,
      required this.bodyPartName,
      required this.onTap});
  void Function() onTap;
  final String bodyPartImage;
  final String bodyPartName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 2),
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            //shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: ListTile(
              //tileColor: Colors.white,
              contentPadding: const EdgeInsets.only(left: 5, right: 0.0),
              leading: SizedBox(
                height: 70,
                width: 60,
                // constraints: BoxConstraints(
                //   minWidth: 70,
                //   minHeight: 40,
                //   maxWidth: 95,
                //   maxHeight: 90,
                // ),
                child: Image(
                  image: AssetImage("assets/images/$bodyPartImage"),
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                bodyPartName,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              // trailing: Checkbox(
              //   value: false,
              //   onChanged: (newBool) {},
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
