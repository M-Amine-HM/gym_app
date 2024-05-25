// ignore: file_names
import 'package:flutter/material.dart';
import 'package:gym_app/core/bodyPart.dart';

// void screenChanger(int screen) {
//   //setState(() {
//   screenS = screen;
//   print("$screenS ex");
//   //});
// }

class ExercicesScreen extends StatefulWidget {
  const ExercicesScreen({super.key});

  @override
  State<ExercicesScreen> createState() => _ExercicesScreenState();
}

class _ExercicesScreenState extends State<ExercicesScreen> {
  List<String> _namesBodyPart = [
    "Poitrine",
    "Dos",
    "Jambes",
    "Epaules",
    "Biceps",
    "Triceps",
    "Avant-Bras",
    "Abdos",
    "Cardio",
    "Etirement"
  ];
  List<String> _imagesBodyPart = [
    "poitrine",
    "dos",
    "jambes",
    "epaules",
    "biceps",
    "triceps",
    "avantbras",
    "abdos",
    "cardio",
    "etirement"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        surfaceTintColor: Colors.grey.shade200,
        title: const Text(
          "Exercices",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Container(
        //color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
              itemBuilder: ((context, index) => BodyPartWidget(
                  imageBodyPart: _imagesBodyPart[index],
                  nameBodyPart: _namesBodyPart[index],
                  onTap: () {
                    String bodyPart = _namesBodyPart[index];
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BodyPartScreen(
                        bodyPart: bodyPart,
                      );
                    }));
                  })),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                    height: 10,
                  ),
              itemCount: _imagesBodyPart.length),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BodyPartWidget extends StatelessWidget {
  BodyPartWidget(
      {super.key,
      required this.imageBodyPart,
      required this.nameBodyPart,
      required this.onTap});
  String imageBodyPart;
  String nameBodyPart;
  void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          //shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: AssetImage("assets/body/$imageBodyPart.png"),
              fit: BoxFit.cover),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              nameBodyPart,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
