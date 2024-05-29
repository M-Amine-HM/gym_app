import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gym_app/core/plans.dart';
import 'package:gym_app/model/exerciseModel.dart';
import 'package:gym_app/model/planModel.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:gym_app/services/Api.dart';

class ChooseExercisesScreen extends StatefulWidget {
  ChooseExercisesScreen(
      {super.key,
      required this.PlanName,
      required this.chosed,
      required this.theuser});
  final String PlanName;
  final Map chosed;
  User theuser;
  @override
  State<ChooseExercisesScreen> createState() => _ChooseExercisesScreenState();
}

class _ChooseExercisesScreenState extends State<ChooseExercisesScreen> {
  TextEditingController _Exercisename = TextEditingController(text: "");
  late bool bo;
  int length = 5; // Specify the length of the list
  //TODO: mch heka a3ml map

  List<bool> myList = List.generate(5, (index) => false);
  late List<dynamic>? houdata;
  // Map chosed = {};
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   houdata = Api.getExercises();

  //   houdata!.forEach((key) {
  //     chosed[key.name] = false;
  //   });
  //   print("$chosed new");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     setState(() {
        //       // Navigator.push(
        //       //   context,
        //       //   MaterialPageRoute(
        //       //       builder: (context) =>
        //       //           ProfileScreen(oneUser: widget.theUser)),
        //       // );
        //       Navigator.pushAndRemoveUntil(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => PlansScreen(),
        //           ),
        //           (route) => false);
        //     });
        //   },
        //   icon: const Icon(Icons.arrow_back_sharp),
        // ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade200,
        surfaceTintColor: Colors.grey.shade200,
        title: Text("Choisir des Exercices",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
      body: Center(
        child: FutureBuilder(
          future: _Exercisename.text.isEmpty
              ? Api.getExercises()
              : Api.getExercisesByName(_Exercisename.text),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              //TODO: if it return null , must handle the error
              List<Exercise> data = snapshot.data;

              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 3),
                child: Column(
                  children: [
                    // TextButton(
                    //   onPressed: () {
                    //     // dismissAllToast(
                    //     //     showAnim: true);
                    //   },
                    //   child: Text(
                    //     "Choisir des Exercices",
                    //     style: TextStyle(
                    //         fontSize: 22,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.black),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 22,
                    // ),
                    TextFormField(
                      onFieldSubmitted: (value) {
                        setState(() {});
                      },
                      controller: _Exercisename,
                      onChanged: (value) {
                        setState(() {
                          value;
                          _Exercisename;
                        });
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[400],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          hintText: "eg : Pull Ups",
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Colors.grey.shade900),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        decoration: BoxDecoration(
                          //shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15),
                              bottom: Radius.circular(15)),
                        ),
                        child: ListView.separated(
                            //shrinkWrap: true,
                            itemBuilder: ((context, index) {
                              //print(myList); // Output: [0, 1, 2, 3, 4]
                              return ExerciceWidget(
                                  nbrsSerieFunction: (int p0) =>
                                      widget.chosed[data[index].name][1] = p0,
                                  isChecked: widget.chosed[data[index].name][0],
                                  setNumber: widget.chosed[data[index].name][1],
                                  exerciseName: data[index].name,
                                  bodyPartImage: "${Api.baseUrl}exercise/" +
                                      data[index].image,
                                  bodyPartName: data[index].bodyPart,
                                  onTap: () {
                                    widget.chosed[data[index].name][0] =
                                        !(widget.chosed[data[index].name][0]);

                                    setState(() {});
                                    print("${widget.chosed} here");
                                  });
                            }),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 0,
                                ),
                            itemCount: snapshot.data.length),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo[700],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              fixedSize: Size(
                                  (MediaQuery.of(context).size.width * 0.8),
                                  45),
                            ),
                            onPressed: () async {
                              List? exercises = [];
                              List? listnbrsSeries = [];

                              // Using a for loop
                              // for (int i = 0; i < widget.chosed.length; i++) {
                              //   //print(exercises[i]);
                              //   if (myList[i] == true) {
                              //     exercises
                              //         .add((widget.chosed[i].name).toString());
                              //   }

                              // }

                              widget.chosed.forEach((key, value) {
                                if (value[0] == true) {
                                  exercises.add((key).toString());
                                }
                                //widget.chosed[key] = false;
                              });

                              widget.chosed.forEach((key, value) {
                                if (value[0] == true) {
                                  listnbrsSeries.add((value[1]).toString());
                                }

                                //widget.chosed[key] = false;
                              });
                              print(exercises);
                              print(listnbrsSeries);

                              //TODO: nbrs series lezmou yet7at ml user mch par defaut =1
                              // List<String> listnbrsSeries = List.generate(
                              //     exercises.length, (index) => "1");

                              String exsTostring = exercises.join(',');
                              String nbrsSeriesTostring =
                                  listnbrsSeries.join(',');
                              Map<String, String> thedata = {
                                "planName": widget.PlanName,
                                "nbrExercises": (exercises.length).toString(),
                                "exercises": exsTostring,
                                "nbrsSeries": nbrsSeriesTostring,
                                "userId": widget.theuser.id
                              };

                              // Map<dynamic, dynamic> hedata = {
                              //   "planName": widget.PlanName,
                              //   "nbrExercises": (exercises.length).toString(),
                              //   "exercises": ["nbrsSerieFunction", "nbrsSerieFunctiona"],
                              //   "nbrsSeries": "exes",
                              // };

                              // Create a Plan object using the fromMap function
                              //Plan plan = Plan.fromMap(planData);
                              //TODO: esm l plan ylzem ykun unique

                              if (exercises.isNotEmpty) {
                                await Api.addPlan(thedata);

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlansScreen(
                                              theuser: widget.theuser,
                                            )),
                                    (route) => false);
                              } else {
                                showToast('Chosissez au minimum un exercice',
                                    context: context,
                                    animation: StyledToastAnimation.fade,
                                    duration: Duration(seconds: 3),
                                    reverseAnimation: StyledToastAnimation.fade,
                                    alignment: Alignment.center,
                                    position: StyledToastPosition(
                                        align: Alignment.center, offset: 20.0));
                              }
                              //Navigator.pop(context);
                            },
                            child: Text(
                              "Confirmer",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class ExerciceWidget extends StatefulWidget {
  ExerciceWidget(
      {super.key,
      required this.bodyPartImage,
      required this.bodyPartName,
      required this.exerciseName,
      required this.isChecked,
      required this.onTap,
      required this.setNumber,
      required this.nbrsSerieFunction});
  void Function() onTap;
  int Function(int) nbrsSerieFunction;
  final String bodyPartImage;
  final String bodyPartName;
  final String exerciseName;
  bool isChecked;
  int setNumber;
  @override
  State<ExerciceWidget> createState() => _ExerciceWidgetState();
}

class _ExerciceWidgetState extends State<ExerciceWidget> {
  //int nbrSerie = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 2),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          height: widget.isChecked ? 120 : 80, //68 heifht ali ken
          decoration: BoxDecoration(
            //shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              ListTile(
                //tileColor: Colors.white,
                contentPadding: const EdgeInsets.only(left: 5, right: 0.0),
                leading: SizedBox(
                  height: 68,
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
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  widget.bodyPartName,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45),
                ),
                trailing: IgnorePointer(
                  ignoring: true,
                  child: CupertinoCheckbox(
                    value: widget.isChecked,
                    onChanged: (newBool) {
                      setState(() {
                        widget.isChecked = newBool!;
                      });
                    },
                    checkColor: Colors.white, // Color of the check icon
                    activeColor:
                        Colors.black87, // Color of the checkbox when checked
                    //hoverColor: Colors.blue.withOpacity(
                    //  0.1), // Color when hovering over the checkbox
                    focusColor: Colors.blue
                        .withOpacity(0.2), // Color when focused on the checkbox
                    //splashRadius: 20, // Adjust the splash radius as needed
                  ),
                ),
              ),
              if (widget.isChecked)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Series",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        if (widget.setNumber > 1) {
                          widget.setNumber = widget.setNumber - 1;
                          //widget.nbrsSerieFunction = widget.nbrSerie as int Function();
                          widget.nbrsSerieFunction(widget.setNumber);
                        }
                        setState(() {});
                      },
                      icon: Icon(CupertinoIcons.minus_circle_fill),
                      color: Colors.red[700],
                    ),
                    Text(
                      (widget.setNumber).toString(),
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.setNumber = widget.setNumber + 1;
                        widget.nbrsSerieFunction(widget.setNumber);
                        setState(() {});
                      },
                      icon: Icon(CupertinoIcons.add_circled_solid),
                      color: Colors.indigo[700],
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
