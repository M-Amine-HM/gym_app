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
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
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
                //TODO: ali fi wost l plan container ydhaher kan awl 4 exercises wfam button afficher plus...
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
                    backgroundColor: Colors.indigo[600], //Colors.blue[700],
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
                    backgroundColor: Colors.indigo[600], //Colors.blue[700],
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
                    backgroundColor: Colors.indigo[600], //Colors.blue[700],
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
    bool newPlanName = true;
//gesture detector to rdismmiss the toast
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
                backgroundColor: Colors.green[500],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: Size((MediaQuery.of(context).size.width * 0.55), 45),
              ),
              onPressed: () async {
                // ignore: use_build_context_synchronously
                showToastWidget(
                  reverseAnimation: StyledToastAnimation.fade,
                  //dismissOtherToast: false,
                  // animDuration: Duration(seconds: 4),
                  context: context,
                  animation: StyledToastAnimation.fade,
                  isIgnoring: false,
                  duration: Duration.zero,
                  position: const StyledToastPosition(align: Alignment.center),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ModalBarrier(
                        color: Colors.black.withOpacity(0.2),
                        dismissible:
                            false, // Prevents dismissing the toast by tapping outside
                      ),
                      // Container(
                      //   color: Colors.black,
                      //   height: 50,
                      //   width: 50,
                      // ),
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.25,
                        width: MediaQuery.sizeOf(context).width * 0.78,
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Choisir un nom pour le plan",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),

                            //error message in textformfield is not working in the toast so need other way
                            TextFormField(
                              controller: _planName,
                              decoration: InputDecoration(
                                //errorText: newPlanName ? null : "error",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.5),
                                ),
                                hintText: "eg: Plan 1",
                                //border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.red[700],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    dismissAllToast(showAnim: true);
                                  },
                                  child: Text("Fermer",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(width: 10),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue[700],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () async {
                                    //bool notExist = true;
                                    late List<dynamic>? allPlans;

                                    allPlans =
                                        await Api.getPlanByName(_planName.text);

                                    if (_planName.text.isNotEmpty &&
                                        allPlans!.isEmpty) {
                                      dismissAllToast(showAnim: false);
                                      late List<dynamic>? exercisesData;
                                      Map chosed = {};
                                      exercisesData = await Api.getExercises();

                                      exercisesData!.forEach((key) {
                                        chosed[key.name] = [false, 1];
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChooseExercisesScreen(
                                                  chosed: chosed,
                                                  PlanName: _planName.text),
                                        ),
                                      );
                                    } else {
                                      setState(() {
                                        newPlanName = false;
                                      });
                                      print("error message");
                                      print(newPlanName);
                                    }
                                  },
                                  child: Text("Choisir des exercices",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
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
                      itemBuilder: ((context, index) => GestureDetector(
                            child: PlanWidget(
                                onTap: () {
                                  dismissAllToast(showAnim: false);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OnGoingPlanScreen(
                                                planToDo: snapshot.data[index],
                                              )));
                                },
                                nbrExercises: data![index].nbrExercises,
                                planName: snapshot.data[index].planName,
                                exercises: snapshot.data[index].exercises,
                                nbrsSeries: snapshot.data[index].nbrsSeries,
                                theimage: (index + 1).toString()
                                // (snapshot.data[index].planName).substring(0, 3),
                                ),
                          )),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 13,
                          ),
                      itemCount: snapshot.data.length);
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
  PlanWidget(
      {super.key,
      required this.planName,
      required this.nbrExercises,
      required this.exercises,
      required this.theimage,
      required this.onTap,
      required this.nbrsSeries});
  final String planName;
  final String nbrExercises;
  final List? exercises;
  final List? nbrsSeries;
  final String theimage;
  void Function() onTap;

  @override
  State<PlanWidget> createState() => _PlanWidgetState();
}

class _PlanWidgetState extends State<PlanWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
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
                          "Nombre des exercices : " + widget.nbrExercises,
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
                    child: Text(
                      widget.theimage,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    radius: 30,
                    backgroundColor: Colors.red[600],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "les exercices : ",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
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
          flex: 6,
          child: Text(
            widget.exerciseName,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "series: " + widget.nbrSerie,
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
