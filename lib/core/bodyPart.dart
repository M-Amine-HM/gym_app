// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gym_app/core/bodyPartDetails.dart';

class BodyPartScreen extends StatefulWidget {
  const BodyPartScreen({super.key, required this.bodyPart});
  final String bodyPart;
  @override
  State<BodyPartScreen> createState() => _BodyPartScreenState();
}

// String _bodyPartImage = "chestflyes.png";
// String _bodyPartName = "Arm Chest flyes plies à la machine";

class _BodyPartScreenState extends State<BodyPartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.bodyPart,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView.separated(
            itemBuilder: ((context, index) => ExerciceWidget(
                  onTap: () {
                    // ignore: non_constant_identifier_names
                    String ExName = "Arm Chest flyes plies à la machine";
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BodyPartDetailsScreen(
                        ExerciceName: ExName,
                      );
                    }));
                  },
                  bodyPartImage: "chestflyes.png",
                  bodyPartName: "Arm Chest flyes plies à la machine",
                )),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            itemCount: 5),
      ),
    );
  }
}

// ignore: must_be_immutable
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
      child: ListTile(
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
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        // trailing: Checkbox(
        //   value: false,
        //   onChanged: (newBool) {},
        // ),
      ),
    );
  }
}

// Container(
//         height: 90,
//         width: MediaQuery.of(context).size.width * 1,
//         color: Colors.green,
//         child: Row(
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.2,
//               height: 100,
//               child: Image(
//                 image: AssetImage("assets/images/$_bodyPartImage"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(
//               width: 12,
//             ),
//             Expanded(
//                 child: Text(
//               _bodyPartName,
//               style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//             ))
//           ],
//         ),
//       ),