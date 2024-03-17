import 'package:flutter/material.dart';
import 'package:gym_app/core/calendar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/AminePhoto.jpg")),
                  shape: BoxShape.circle,
                  color: Colors.black),
              // child: Image(
              //   image: AssetImage("assets/images/AminePhoto.jpg"),
              //   //fit: BoxFit.cover,
              // ),
            ),

            SizedBox(
              height: 10,
            ),
            Text(
              "Amine",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            // Divider(
            //   indent: 10,
            //   endIndent: 10,
            //   height: 20,
            //   color: Colors.grey,
            //   thickness: 1,
            // ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Button_IconWidget(
                  name: "Statistiques",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => calendar()),
                    );
                  },
                ),
                SizedBox(
                  width: 8,
                ),
                Button_IconWidget(
                  name: "Communité",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => calendar()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Button_IconWidget(
                  name: "Mesures",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => calendar()),
                    );
                  },
                ),
                SizedBox(
                  width: 8,
                ),
                Button_IconWidget(
                  name: "Calendar",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => calendar()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

class Button_IconWidget extends StatelessWidget {
  Button_IconWidget({super.key, required this.name, required this.onTap});
  //final Icon iconSpecial;
  final String name;
  void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            fixedSize: const Size.fromHeight(55),
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            // fixedSize:
            //     Size.fromWidth(MediaQuery.of(context).size.width * 1),
          ),
          onPressed: onTap,
          icon: const Icon(
            Icons.abc,
            size: 40,
            color: Colors.blue,
          ),
          label: Text(
            name,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          )),
    );
  }
}
