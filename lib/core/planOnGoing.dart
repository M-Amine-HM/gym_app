import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gym_app/core/bodyPartDetails.dart';
import 'package:gym_app/model/planModel.dart';
import 'package:gym_app/services/Api.dart';

class OnGoingPlanScreen extends StatefulWidget {
  const OnGoingPlanScreen({super.key, required this.planToDo});
  final Plan planToDo;

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
          actions: [
            PopupMenuButton(
              color: Colors.black87,
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text(
                      "Renommer",
                      style: TextStyle(color: Colors.white),
                    ),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text(
                      "Supprimer",
                      style: TextStyle(color: Colors.white),
                    ),
                    value: 2,
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 1) {
                  // Perform action for Option 1
                  // Add your code here
                } else if (value == 2) {
                  // Perform action for Option 2
                  // Add your code here
                }
              },
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
                    widget.planToDo.planName,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.planToDo.nbrExercises == "1"
                        ? "${widget.planToDo.nbrExercises} exercice"
                        : "${widget.planToDo.nbrExercises} exercices",
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
                  child: FutureBuilder(
                      future: Api.getExercisesByPlan(widget.planToDo.planName),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          //TODO: if it return null , must handle the error
                          List? data = snapshot.data;
                          return ListView.builder(
                              itemBuilder: ((context, index) => ExerciceWidget(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return BodyPartDetailsScreen(
                                          exercise: data[index],
                                        );
                                      }));
                                    },
                                    exerciseImage: "${Api.baseUrl}exercise/" +
                                        data[index].image,
                                    exerciseName: data[index].name,
                                    bodyPartName: data[index].bodyPart,
                                    nbrSer: widget.planToDo.nbrsSeries[index],
                                  )),
                              // separatorBuilder: (context, index) => const SizedBox(
                              //       height: 0,
                              //     ),
                              itemCount: data!.length);
                        }
                      })),
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
                          fixedSize: Size(
                              (MediaQuery.of(context).size.width * 0.9), 45),
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
                          fixedSize: Size(
                              (MediaQuery.of(context).size.width * 0.9), 45),
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
              ),
            ),
          ],
        ));
  }
}

class ExerciceWidget extends StatelessWidget {
  ExerciceWidget(
      {super.key,
      required this.exerciseImage,
      required this.exerciseName,
      required this.bodyPartName,
      required this.nbrSer,
      required this.onTap});
  void Function() onTap;
  final String exerciseImage;
  final String exerciseName;
  final String bodyPartName;
  final String nbrSer;

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
              contentPadding: const EdgeInsets.only(left: 5, right: 15),
              leading: SizedBox(
                height: 70,
                width: 60,
                // constraints: BoxConstraints(
                //   minWidth: 70,
                //   minHeight: 40,
                //   maxWidth: 95,
                //   maxHeight: 90,
                // ),
                child: Image.network(
                  exerciseImage,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                exerciseName,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                bodyPartName,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
              trailing: Text("Series : $nbrSer"),
            ),
          ),
        ),
      ),
    );
  }
}
