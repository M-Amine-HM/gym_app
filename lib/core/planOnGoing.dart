import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gym_app/core/bodyPartDetails.dart';
import 'package:gym_app/core/choseExercises.dart';
import 'package:gym_app/core/doingPlan.dart';
import 'package:gym_app/core/doingThePlan.dart';
import 'package:gym_app/core/plans.dart';
import 'package:gym_app/core/updatePlan.dart';
import 'package:gym_app/model/friendPlanModel.dart';
import 'package:gym_app/model/planModel.dart';
import 'package:gym_app/model/predefinedPlan.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:gym_app/providers/checked_provider.dart';
import 'package:gym_app/services/Api.dart';
import 'package:provider/provider.dart';

class OnGoingPlanScreen extends StatefulWidget {
  OnGoingPlanScreen(
      {super.key,
      this.planToDo,
      required this.theUser,
      required this.planType,
      this.predefinedPlan,
      this.friendplan});
  Plan? planToDo;
  User theUser;
  String planType;
  Friendplan? friendplan;
  PredefinedPlan? predefinedPlan;

  @override
  State<OnGoingPlanScreen> createState() => _OnGoingPlanScreenState();
}

class _OnGoingPlanScreenState extends State<OnGoingPlanScreen> {
  TextEditingController _planName = TextEditingController();
  late String theTitle;
  late String nbrExercises;
  late List nbrSeries;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.planType == "1") {
      theTitle = widget.planToDo!.planName;
      nbrExercises = widget.planToDo!.nbrExercises;
      nbrSeries = widget.planToDo!.nbrsSeries;
    } else if (widget.planType == "2") {
      theTitle = widget.predefinedPlan!.planName;
      nbrExercises = widget.predefinedPlan!.nbrExercises;
      nbrSeries = widget.predefinedPlan!.nbrsSeries;
    } else if (widget.planType == "3") {
      theTitle = widget.friendplan!.planName;
      nbrExercises = widget.friendplan!.nbrExercises;
      nbrSeries = widget.friendplan!.nbrsSeries;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo[600], //Colors.blue[700],
        appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
                //push until 5atr ynjm ykun fama modiif fl plan w fl upadated plan 3aml nav push remove zeda
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlansScreen(
                        theuser: widget.theUser,
                      ),
                    ),
                    (route) => false);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: Colors.indigo[600], // Colors.blue[700],
          actions: [
            if (widget.planType != "2")
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[500],
                    side: BorderSide.none,
                  ),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Supprimer",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    showToastWidget(
                      reverseAnimation: StyledToastAnimation.fade,
                      //dismissOtherToast: false,
                      // animDuration: Duration(seconds: 4),
                      context: context,
                      animation: StyledToastAnimation.fade,
                      isIgnoring: false,
                      duration: Duration.zero,
                      position:
                          const StyledToastPosition(align: Alignment.center),
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
                            height: MediaQuery.sizeOf(context).height * 0.17,
                            width: MediaQuery.sizeOf(context).width * 0.85,
                            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Voulez vous supprimer ce Plan ?",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                //error message in textformfield is not working in the toast so need other way

                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue[700],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onPressed: () {
                                        dismissAllToast(showAnim: true);
                                      },
                                      child: const Text("NON",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(width: 20),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.red[700],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onPressed: () async {
                                        if (widget.planType == "1") {
                                          await Api.deletePlan(
                                              widget.planToDo!.id);
                                        } else if (widget.planType == "3") {
                                          await Api.deleteFriendPlan(
                                              widget.friendplan!.id);
                                        }
                                        dismissAllToast(showAnim: false);

                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PlansScreen(
                                                theuser: widget.theUser!,
                                              ),
                                            ),
                                            (route) => false);
                                      },
                                      child: const Text("OUI",
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

                    // Perform action for Option 2
                    // Add your code here
                  }),
            const SizedBox(
              width: 30,
            )
            // PopupMenuButton(
            //   color: Colors.black87,
            //   icon: Icon(
            //     Icons.more_vert,
            //     color: Colors.white,
            //   ),
            //   itemBuilder: (BuildContext context) {
            //     return [
            //       PopupMenuItem(
            //         child: Text(
            //           "Renommer",
            //           style: TextStyle(color: Colors.white),
            //         ),
            //         value: 1,
            //       ),
            //       PopupMenuItem(
            //         child: Text(
            //           "Supprimer",
            //           style: TextStyle(color: Colors.white),
            //         ),
            //         value: 2,
            //       ),
            //     ];
            //   },
            //   onSelected: (value) async {
            //     if (value == 1) {
            //       // Perform action for Option 1
            //       // Add your code here

            //       showToastWidget(
            //         reverseAnimation: StyledToastAnimation.fade,
            //         //dismissOtherToast: false,
            //         // animDuration: Duration(seconds: 4),
            //         context: context,
            //         animation: StyledToastAnimation.fade,
            //         isIgnoring: false,
            //         duration: Duration.zero,
            //         position:
            //             const StyledToastPosition(align: Alignment.center),
            //         Stack(
            //           alignment: Alignment.center,
            //           children: [
            //             ModalBarrier(
            //               color: Colors.black.withOpacity(0.2),
            //               dismissible:
            //                   false, // Prevents dismissing the toast by tapping outside
            //             ),
            //             Container(
            //               height: 210,
            //               width: 280,
            //               padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(18),
            //                 color: Colors.white,
            //                 boxShadow: [
            //                   BoxShadow(
            //                     color: Colors.grey.withOpacity(0.5),
            //                     spreadRadius: 2,
            //                     blurRadius: 7,
            //                     offset: Offset(0, 3),
            //                   ),
            //                 ],
            //               ),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   Text(
            //                     "Choisir un nouveau nom",
            //                     style: TextStyle(
            //                       fontSize: 18,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                   SizedBox(height: 10),

            //                   //error message in textformfield is not working in the toast so need other way
            //                   SizedBox(
            //                     width: 200,
            //                     child: TextFormField(
            //                       controller: _planName,
            //                       decoration: InputDecoration(
            //                         //errorText: newPlanName ? null : "error",
            //                         enabledBorder: OutlineInputBorder(
            //                           borderRadius: BorderRadius.circular(10),
            //                           borderSide: BorderSide(
            //                               color: Colors.black, width: 1.0),
            //                         ),
            //                         focusedBorder: OutlineInputBorder(
            //                           borderRadius: BorderRadius.circular(10),
            //                           borderSide: BorderSide(
            //                               color: Colors.black, width: 1.5),
            //                         ),
            //                         hintText: "eg: Plan 1",
            //                         //border: OutlineInputBorder(),
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(height: 20),
            //                   Row(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       TextButton(
            //                         style: TextButton.styleFrom(
            //                             backgroundColor: Colors.red[700],
            //                             shape: RoundedRectangleBorder(
            //                                 borderRadius:
            //                                     BorderRadius.circular(10))),
            //                         onPressed: () {
            //                           dismissAllToast(showAnim: true);
            //                         },
            //                         child: Text("Fermer",
            //                             style: TextStyle(
            //                                 color: Colors.white,
            //                                 fontSize: 15,
            //                                 fontWeight: FontWeight.bold)),
            //                       ),
            //                       SizedBox(width: 10),
            //                       TextButton(
            //                         style: TextButton.styleFrom(
            //                             backgroundColor: Colors.blue[700],
            //                             shape: RoundedRectangleBorder(
            //                                 borderRadius:
            //                                     BorderRadius.circular(10))),
            //                         onPressed: () async {
            //                           if (_planName.text.isNotEmpty) {
            //                             // Map Data = {
            //                             //   "planName": _planName.text,
            //                             // };
            //                             // //  Plan data;
            //                             // widget.planToDo.planName =
            //                             //     _planName.text;
            //                             //  await Api.updatePlan(
            //                             //     widget.planToDo.id, Data);
            //                             //print(data);
            //                             // Navigator.pushAndRemoveUntil(
            //                             //     context,
            //                             //     MaterialPageRoute(
            //                             //       builder: (context) =>
            //                             //           OnGoingPlanScreen(
            //                             //               planToDo: data![0]),
            //                             //     ),
            //                             //     (route) => false);

            //                             dismissAllToast(showAnim: true);
            //                           }
            //                         },
            //                         child: Text("Comfirmer",
            //                             style: TextStyle(
            //                                 color: Colors.white,
            //                                 fontSize: 15,
            //                                 fontWeight: FontWeight.bold)),
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     } else if (value == 2) {
            //       showToastWidget(
            //         reverseAnimation: StyledToastAnimation.fade,
            //         //dismissOtherToast: false,
            //         // animDuration: Duration(seconds: 4),
            //         context: context,
            //         animation: StyledToastAnimation.fade,
            //         isIgnoring: false,
            //         duration: Duration.zero,
            //         position:
            //             const StyledToastPosition(align: Alignment.center),
            //         Stack(
            //           alignment: Alignment.center,
            //           children: [
            //             ModalBarrier(
            //               color: Colors.black.withOpacity(0.2),
            //               dismissible:
            //                   false, // Prevents dismissing the toast by tapping outside
            //             ),
            //             Container(
            //               color: Colors.black,
            //               height: 50,
            //               width: 50,
            //             ),
            //             Container(
            //               height: 130,
            //               width: 340,
            //               padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(18),
            //                 color: Colors.white,
            //                 boxShadow: [
            //                   BoxShadow(
            //                     color: Colors.grey.withOpacity(0.5),
            //                     spreadRadius: 2,
            //                     blurRadius: 7,
            //                     offset: Offset(0, 3),
            //                   ),
            //                 ],
            //               ),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     "Voulez vous supprimer ce Plan ?",
            //                     style: TextStyle(
            //                       fontSize: 18,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),

            //                   //error message in textformfield is not working in the toast so need other way

            //                   SizedBox(height: 20),
            //                   Row(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       TextButton(
            //                         style: TextButton.styleFrom(
            //                             backgroundColor: Colors.blue[700],
            //                             shape: RoundedRectangleBorder(
            //                                 borderRadius:
            //                                     BorderRadius.circular(10))),
            //                         onPressed: () {
            //                           dismissAllToast(showAnim: true);
            //                         },
            //                         child: Text("NON",
            //                             style: TextStyle(
            //                                 color: Colors.white,
            //                                 fontSize: 15,
            //                                 fontWeight: FontWeight.bold)),
            //                       ),
            //                       SizedBox(width: 20),
            //                       TextButton(
            //                         style: TextButton.styleFrom(
            //                             backgroundColor: Colors.red[700],
            //                             shape: RoundedRectangleBorder(
            //                                 borderRadius:
            //                                     BorderRadius.circular(10))),
            //                         onPressed: () async {
            //                           await Api.deletePlan(widget.planToDo.id);
            //                           dismissAllToast(showAnim: false);

            //                           Navigator.pushAndRemoveUntil(
            //                               context,
            //                               MaterialPageRoute(
            //                                 builder: (context) => PlansScreen(),
            //                               ),
            //                               (route) => false);
            //                         },
            //                         child: Text("OUI",
            //                             style: TextStyle(
            //                                 color: Colors.white,
            //                                 fontSize: 15,
            //                                 fontWeight: FontWeight.bold)),
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       );

            //       // Perform action for Option 2
            //       // Add your code here
            //     }
            //   },
            // ), //IconButton
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
                    theTitle,
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    nbrExercises == "1"
                        ? "${nbrExercises} exercice"
                        : "${nbrExercises} exercices",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
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
                      future: widget.planType == "2"
                          ? Api.getExercisesByPredefinedPlan(theTitle)
                          : Api.getExercisesByPlan(theTitle),
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
                                    nbrSer: nbrSeries[index],
                                  )),
                              // separatorBuilder: (context, index) => const SizedBox(
                              //       height: 0,
                              //     ),
                              itemCount: data!.length);
                        }
                      })),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.grey[200],
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          // ignore: sort_child_properties_last
                          child: const Text(
                            "DEBUT",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.indigo[600], //Colors.blue[700],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            fixedSize: Size(
                                (MediaQuery.of(context).size.width * 0.8),
                                MediaQuery.of(context).size.height * 0.057),
                          ),
                          onPressed: () async {
                            // late List<List<dynamic>> seriesCompleted = [];
                            //
                            // // for (int i = 0;
                            // //     i < widget.planToDo.nbrsSeries.length;
                            // //     i++) {
                            // // Generate a list of lists for each iteration and append it to seriesCompleted
                            // seriesCompleted = generateListOfLists(
                            //   widget.planToDo.nbrsSeries.length,
                            //   1,
                            //   ["0", "1"],
                            // );
                            // for (int i = 0;
                            //     i < widget.planToDo.nbrsSeries.length;
                            //     i++) {
                            //   for (int j = 0;
                            //       j <
                            //           (int.parse(
                            //                   widget.planToDo.nbrsSeries[i]) -
                            //               1);
                            //       j++) {
                            //     seriesCompleted[i].add(["0", "1"]);
                            //   }
                            // }
                            //for  the chekeked list
                            // late List<List> seriesCompletedChecked = [];
                            // seriesCompletedChecked = generateListOfLists(
                            //   widget.planToDo.nbrsSeries.length,
                            //   1,
                            //   false,
                            // );
                            // for (int i = 0;
                            //     i < widget.planToDo.nbrsSeries.length;
                            //     i++) {
                            //   for (int j = 0;
                            //       j <
                            //           (int.parse(
                            //                   widget.planToDo.nbrsSeries[i]) -
                            //               1);
                            //       j++) {
                            //     seriesCompletedChecked[i].add(false);
                            //   }
                            // }
                            //Hadhi hiya flutter may5admch bl generated koma n7b dima tsiir mchkla
                            //nasna3ha ni personolazid
                            // List<List<dynamic>> list = [];

                            // for (int i = 0;
                            //     i < (widget.planToDo.nbrsSeries).length;
                            //     i++) {
                            //   List<dynamic> k = [];
                            //   for (int j = 0;
                            //       j < int.parse(widget.planToDo.nbrsSeries[i]);
                            //       j++) {
                            //     k.add(["", ""]);
                            //   }
                            //   list.add(k);
                            // }
                            // print(list);
                            //print(seriesCompleted);
                            // list = [
                            //   [
                            //     ["0", "1"]
                            //   ],
                            //   [
                            //     ["0", "1"],
                            //     ["0", "1"]
                            //   ],
                            //   [
                            //     ["0", "1"],
                            //     ["0", "1"],
                            //     ["0", "1"]
                            //   ]
                            // ];

                            //}
                            //print(seriesCompleted.runtimeType);
                            // print(list);
                            //seriesCompleted[1] = ["hello", "o", "f"];
                            //print(seriesCompletedChecked);
                            List? data;
                            if (widget.planType == "2") {
                              data = await Api.getExercisesByPredefinedPlan(
                                  theTitle);
                            } else {
                              data = await Api.getExercisesByPlan(theTitle);
                            }
                            //here
                            List<List<dynamic>> generateListOfLists(
                                int numberOfLists,
                                int lengthOfEachList,
                                dynamic defaultValue) {
                              // Generate a list of lists
                              return List.generate(
                                numberOfLists,
                                (_) => List.generate(
                                  lengthOfEachList,
                                  (_) =>
                                      defaultValue, // Here, you can specify the default value of each element in the inner list
                                ),
                              );
                            }

                            late List<List> seriesCompletedChecked = [];
                            seriesCompletedChecked = generateListOfLists(
                              nbrSeries.length,
                              1,
                              false,
                            );
                            for (int i = 0; i < nbrSeries.length; i++) {
                              for (int j = 0;
                                  j < (int.parse(nbrSeries[i]) - 1);
                                  j++) {
                                seriesCompletedChecked[i].add(false);
                              }
                            }
                            // for (int i = 0; i < (widget.planDoing.nbrsSeries).length; i++) {
                            //   List<dynamic> k = [];
                            //   for (int j = 0; j < int.parse(widget.planDoing.nbrsSeries[i]); j++) {
                            //     k.add(["", ""]);
                            //   }
                            //   seriesCompleted.add(k);
                            // }
                            //print(seriesCompleted);
                            //bool pauseTimer = context.watch<TimerProvider>().isTimerStarted;
                            ab = seriesCompletedChecked;
                            print("object");
                            print(ab);
                            //tohere
                            context
                                .read<CheckedProvider>()
                                .updateSeriesChecked(ab);
                            if (widget.planType == "1") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => doingThePlanScreen(
                                    planType: widget.planType,
                                    data: data!,
                                    planDoing: widget.planToDo!,
                                    theuser: widget.theUser,
                                    //friendplan: widget.friendplan,
                                    // seriesCompleted: list,
                                    // seriesCompletedChecked:
                                    //     seriesCompletedChecked,
                                  ),
                                ),
                              );
                            } else if (widget.planType == "3") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => doingThePlanScreen(
                                    planType: widget.planType,
                                    data: data!,
                                    //planDoing: widget.planToDo!,
                                    theuser: widget.theUser,
                                    friendplan: widget.friendplan,
                                    // seriesCompleted: list,
                                    // seriesCompletedChecked:
                                    //     seriesCompletedChecked,
                                  ),
                                ),
                              );
                            } else if (widget.planType == "2") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => doingThePlanScreen(
                                    planType: widget.planType,
                                    data: data!,
                                    //planDoing: widget.planToDo!,
                                    theuser: widget.theUser,
                                    predefinedPlan: widget.predefinedPlan,
                                    // seriesCompleted: list,
                                    // seriesCompletedChecked:
                                    //     seriesCompletedChecked,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        if (widget.planType == "1")
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              fixedSize: Size(
                                  (MediaQuery.of(context).size.width * 0.8),
                                  MediaQuery.of(context).size.height * 0.057),
                            ),
                            onPressed: () async {
                              late List<dynamic>? exercisesData;
                              Map chosed = {};
                              exercisesData = await Api.getExercises();

                              exercisesData!.forEach((key) {
                                chosed[key.name] = [false, 1];
                              });

                              // widget.planToDo.exercises.forEach((element) {
                              //   chosed[element][0] = true;
                              // });

                              for (int i = 0;
                                  i < (widget.planToDo!.exercises.length);
                                  i++) {
                                chosed[widget.planToDo!.exercises[i]][0] = true;
                                chosed[widget.planToDo!.exercises[i]][1] =
                                    widget.planToDo!.nbrsSeries[i];
                              }
                              // widget.planToDo.nbrsSeries.forEach((element) {
                              //   chosed[element][1] = element;
                              // });
                              //String ch = widget.planToDo.planName;
                              //await Api.deletePlan(widget.planToDo.id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdatePlanScreen(
                                    PlanID: widget.planToDo!.id,
                                    chosed: chosed,
                                    PlanName: widget.planToDo!.planName,
                                    theuser: widget.theUser,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "MODIFIER",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                      ],
                    ),
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
