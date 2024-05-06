import 'package:flutter/material.dart';
import 'package:gym_app/core/choseExercises.dart';
import 'package:gym_app/core/planOnGoing.dart';
import 'package:gym_app/model/exerciseModel.dart';
import 'package:gym_app/model/planModel.dart';
import 'package:gym_app/services/Api.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlansScreen> {
  final List<Widget> _screens = [
    Container(
      color: Colors.grey.shade200,
      child: PlanContainerWidget(),
    ),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.blue,
    )
  ];

  late int screenS;
  @override
  void initState() {
    screenS = 0;
    super.initState();
  }

  void screenChanger(int screen) {
    setState(() {
      screenS = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        surfaceTintColor: Colors.grey.shade200,
        //shadowColor: Colors.grey.shade50,
        title: const Text(
          "Plans",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //TODO: Design des boutons et les couleurs
                ElevatedButton(
                  onPressed: () {
                    screenChanger(0);
                  },
                  child: Text(
                    "Mes Plans",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    screenChanger(1);
                  },
                  child: Text(
                    "Plans Prédéfinis",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    screenChanger(2);
                  },
                  child: Text(
                    "Plans amis",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 5,
            // ),
            Expanded(child: _screens[screenS])
          ],
        ),
      ),
    );
  }
}

class PlanContainerWidget extends StatefulWidget {
  const PlanContainerWidget({
    super.key,
  });

  @override
  State<PlanContainerWidget> createState() => _PlanContainerWidgetState();
}

class _PlanContainerWidgetState extends State<PlanContainerWidget> {
// Inside your State class, add the listener to the TextEditingController
  // @override
  // void initState() {
  //   super.initState();
  //   Exercisename.addListener(_onExerciseNameChanged);
  // }

  // @override
  // void dispose() {
  //   Exercisename.removeListener(_onExerciseNameChanged);
  //   Exercisename.dispose();
  //   super.dispose();
  // }

  // void _onExerciseNameChanged() {
  //   setState(() {
  //     // Trigger rebuilding of the FutureBuilder
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController _planName = TextEditingController();
    TextEditingController _Exercisename = TextEditingController(text: "");

    return Container(
      color: Colors.grey.shade200,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: Size((MediaQuery.of(context).size.width * 0.55), 45),
              ),
              onPressed: () {
                showDialog(
                    useSafeArea: false,
                    barrierDismissible: true,
                    //barrierColor: Colors.amber.withOpacity(0.2),
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Nom de Plan"),
                          content: TextFormField(controller: _planName),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  if (_planName.text.isEmpty) {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChooseExercisesScreen()));
                                    // showToastWidget(
                                    //   reverseAnimation:
                                    //       StyledToastAnimation.fadeRotate,
                                    //   // animDuration: Duration(seconds: 4),
                                    //   context: context,
                                    //   animation: StyledToastAnimation.fade,
                                    //   isIgnoring: false,
                                    //   duration: Duration.zero,
                                    //   position: const StyledToastPosition(
                                    //       align: Alignment.center),
                                    //   Container(
                                    //     color: Colors.white,
                                    //     height:
                                    //         MediaQuery.sizeOf(context).height *
                                    //             0.9,
                                    //     child: Center(
                                    //       child: FutureBuilder(
                                    //         future: _Exercisename.text.isEmpty
                                    //             ? Api.getExercises()
                                    //             : Api.getExercisesByName(
                                    //                 _Exercisename.text),
                                    //         builder: (BuildContext context,
                                    //             AsyncSnapshot snapshot) {
                                    //           if (!snapshot.hasData) {
                                    //             return const Center(
                                    //               child:
                                    //                   CircularProgressIndicator(),
                                    //             );
                                    //           } else {
                                    //             //TODO: if it return null , must handle the error
                                    //             List<Exercise> data =
                                    //                 snapshot.data;
                                    //             return Padding(
                                    //               padding:
                                    //                   const EdgeInsets.fromLTRB(
                                    //                       8, 0, 8, 0),
                                    //               child: Column(
                                    //                 children: [
                                    //                   SizedBox(
                                    //                     height: 20,
                                    //                   ),
                                    //                   TextButton(
                                    //                     onPressed: () {
                                    //                       dismissAllToast(
                                    //                           showAnim: true);
                                    //                     },
                                    //                     child: Text(
                                    //                       "Choisir des Exercices",
                                    //                       style: TextStyle(
                                    //                           fontSize: 22,
                                    //                           fontWeight:
                                    //                               FontWeight
                                    //                                   .bold,
                                    //                           color:
                                    //                               Colors.black),
                                    //                     ),
                                    //                   ),
                                    //                   SizedBox(
                                    //                     height: 22,
                                    //                   ),
                                    //                   TextFormField(
                                    //                     onFieldSubmitted:
                                    //                         (value) {
                                    //                       setState(() {});
                                    //                     },
                                    //                     controller:
                                    //                         _Exercisename,
                                    //                     onChanged: (value) {
                                    //                       setState(() {
                                    //                         value;
                                    //                         _Exercisename;
                                    //                       });
                                    //                     },
                                    //                     decoration: InputDecoration(
                                    //                         filled: true,
                                    //                         fillColor: Colors
                                    //                             .grey[400],
                                    //                         border: OutlineInputBorder(
                                    //                             borderRadius:
                                    //                                 BorderRadius
                                    //                                     .circular(
                                    //                                         15),
                                    //                             borderSide:
                                    //                                 BorderSide
                                    //                                     .none),
                                    //                         hintText:
                                    //                             "eg : Pull Ups",
                                    //                         prefixIcon: Icon(
                                    //                             Icons.search),
                                    //                         prefixIconColor:
                                    //                             Colors.grey
                                    //                                 .shade900),
                                    //                   ),
                                    //                   SizedBox(
                                    //                     height: 10,
                                    //                   ),
                                    //                   Expanded(
                                    //                     child: Container(
                                    //                       child: ListView
                                    //                           .separated(
                                    //                               //shrinkWrap: true,
                                    //                               itemBuilder: ((context, index) => ExerciceWidget(
                                    //                                   checked:
                                    //                                       false,
                                    //                                   exerciseName:
                                    //                                       data[index]
                                    //                                           .name,
                                    //                                   bodyPartImage:
                                    //                                       "${Api.baseUrl}exercise/" +
                                    //                                           data[index]
                                    //                                               .image,
                                    //                                   bodyPartName:
                                    //                                       data[index]
                                    //                                           .bodyPart,
                                    //                                   onTap:
                                    //                                       () {})),
                                    //                               separatorBuilder:
                                    //                                   (context,
                                    //                                           index) =>
                                    //                                       const SizedBox(
                                    //                                         height:
                                    //                                             0,
                                    //                                       ),
                                    //                               itemCount: data!
                                    //                                   .length),
                                    //                     ),
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //             );
                                    //           }
                                    //         },
                                    //       ),
                                    //     ),
                                    //   ),
                                    // );
                                  }
                                },
                                child: const Text("Choisir les exercises")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("close")),
                          ],
                        ));
              },
              label: Text(
                "Créer un Plan",
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: Api.getPlans(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  //TODO: if it return null , must handle the error
                  List? data = snapshot.data;
                  return ListView.separated(
                      itemBuilder: ((context, index) => PlanWidget(
                            nbrExercises: data![index].nbrExercises,
                            planName: data[index].planName,
                            exercises: data[index].exercises,
                            nbrsSeries: data[index].nbrsSeries,
                          )),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 13,
                          ),
                      itemCount: data!.length);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PlanWidget extends StatefulWidget {
  const PlanWidget(
      {super.key,
      required this.planName,
      required this.nbrExercises,
      required this.exercises,
      required this.nbrsSeries});
  final String planName;
  final String nbrExercises;
  final List? exercises;
  final List? nbrsSeries;

  @override
  State<PlanWidget> createState() => _PlanWidgetState();
}

class _PlanWidgetState extends State<PlanWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OnGoingPlanScreen()));
      },
      child: Container(
        decoration: BoxDecoration(
          //shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.planName,
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w700),
                          //softWrap: true,
                        ),
                        Text(
                          widget.nbrExercises,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                          //softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.red,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: ((context, index) => ExNameAndNbrSetsRow(
                          exerciseName: widget.exercises![index],
                          nbrSerie: widget.nbrsSeries![index],
                        )),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: widget.exercises!.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExNameAndNbrSetsRow extends StatefulWidget {
  const ExNameAndNbrSetsRow(
      {super.key, required this.exerciseName, required this.nbrSerie});
  final String exerciseName;
  final String nbrSerie;

  @override
  State<ExNameAndNbrSetsRow> createState() => _ExNameAndNbrSetsRowState();
}

class _ExNameAndNbrSetsRowState extends State<ExNameAndNbrSetsRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            widget.exerciseName,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Text(
            widget.nbrSerie,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class ExerciceWidget extends StatefulWidget {
  ExerciceWidget(
      {super.key,
      required this.bodyPartImage,
      required this.bodyPartName,
      required this.exerciseName,
      required this.checked,
      required this.onTap});
  void Function() onTap;
  final String bodyPartImage;
  final String bodyPartName;
  final String exerciseName;
  bool checked;

  @override
  State<ExerciceWidget> createState() => _ExerciceWidgetState();
}

class _ExerciceWidgetState extends State<ExerciceWidget> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 2),
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
                child: Image.network(
                  widget.bodyPartImage,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                widget.exerciseName,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                widget.bodyPartName,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
              trailing: Checkbox(
                value: isChecked,
                onChanged: (newBool) {
                  setState(() {
                    isChecked = newBool;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
