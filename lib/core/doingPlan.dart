// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:gym_app/model/planModel.dart';
// import 'package:gym_app/services/Api.dart';

// class doingPlanScreen extends StatefulWidget {
//   doingPlanScreen({super.key, required this.planDoing, required this.data
//       // required this.seriesCompleted,
//       // required this.seriesCompletedChecked
//       });
//   Plan planDoing;
//   List data;
//   // List<List> seriesCompleted;
//   // List<List> seriesCompletedChecked;
//   //late TextEditingController _weightController = TextEditingController();
// //late TextEditingController _repetitonController = TextEditingController();

//   @override
//   State<doingPlanScreen> createState() => _doingPlanScreenState();
// }

// List<List<dynamic>> generateListOfLists(
//     int numberOfLists, int lengthOfEachList, dynamic defaultValue) {
//   // Generate a list of lists
//   return List.generate(
//     numberOfLists,
//     (_) => List.generate(
//       lengthOfEachList,
//       (_) =>
//           defaultValue, // Here, you can specify the default value of each element in the inner list
//     ),
//   );
// }

// late List<List> seriesCompletedChecked = [];
// List<List<dynamic>> seriesCompleted = [];
// late List<TextEditingController> controllers;
// bool pauseTimer = false;

// class _doingPlanScreenState extends State<doingPlanScreen> {
//   // int timee = 0;
//   // int _seconds = 0;
//   // int _minutes = 0;
//   //Timer? _timer;
//   late Stream<int> _timerStream;
//   late StreamSubscription<int> _timerSubscription;
//   @override
//   void initState() {
//     super.initState();
//     // _timerStream = Stream<int>.periodic(Duration(seconds: 1), (i) => i)
//     //     .asBroadcastStream();
//     // _timerSubscription = _timerStream.listen((int tick) {
//     //   setState(() {
//     //     _seconds = tick % 60;
//     //     _minutes = tick ~/ 60;
//     //   });
//     // });

//     //startTimer();
//     seriesCompletedChecked = generateListOfLists(
//       widget.planDoing.nbrsSeries.length,
//       1,
//       false,
//     );
//     for (int i = 0; i < widget.planDoing.nbrsSeries.length; i++) {
//       for (int j = 0;
//           j < (int.parse(widget.planDoing.nbrsSeries[i]) - 1);
//           j++) {
//         seriesCompletedChecked[i].add(false);
//       }
//     }
//     for (int i = 0; i < (widget.planDoing.nbrsSeries).length; i++) {
//       List<dynamic> k = [];
//       for (int j = 0; j < int.parse(widget.planDoing.nbrsSeries[i]); j++) {
//         k.add(["", ""]);
//       }
//       seriesCompleted.add(k);
//     }
//     print(seriesCompleted);
//   }

//   // @override
//   // void dispose() {
//   //   _timerSubscription.cancel();
//   //   //_timer?.cancel();
//   //   super.dispose();
//   // }

//   // void _timer() {
//   //   Timer.periodic(Duration(seconds: 1), (timer) {
//   //     setState(() {
//   //       timee++;
//   //     });
//   //   });
//   // }
//   // void startTimer() {
//   //   const oneSec = const Duration(seconds: 1);
//   //   _timer = Timer.periodic(oneSec, (Timer timer) {
//   //     if (pauseTimer == false) {
//   //       setState(() {
//   //         if (_seconds < 59) {
//   //           _seconds++;
//   //         } else {
//   //           _seconds = 0;
//   //           if (_minutes < 59) {
//   //             _minutes++;
//   //           } else {
//   //             // Reset the timer if it reaches maximum
//   //             _minutes = 0;
//   //           }
//   //         }
//   //       });
//   //     }
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // String timerText =
//     //     '${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}';
//     // final Stream<int> _timerStream =
//     //     Stream<int>.periodic(Duration(seconds: 1), (i) => i)
//     //         .asBroadcastStream();
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       appBar: AppBar(
//         backgroundColor: Colors.grey.shade200,
//         title: Text(widget.planDoing.planName,
//             style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
//         actions: [
//           // IconButton(
//           //   onPressed: () {
//           //     setState(() {
//           //       pauseTimer = !pauseTimer;
//           //     });
//           //   },
//           //   icon: pauseTimer
//           //       ? Icon(
//           //           Icons.play_arrow_sharp,
//           //           size: 35,
//           //         )
//           //       : Icon(Icons.pause, size: 35),
//           // ),
//           // StreamBuilder<int>(
//           //   stream: _timerStream,
//           //   builder: (context, snapshot) {
//           //     final int seconds = snapshot.data ?? 0;
//           //     final int minutes = seconds ~/ 60;
//           //     final int remainingSeconds = seconds % 60;

//           //     return
//           Text(
//             //'${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}',

//             "00:55", style: TextStyle(fontSize: 40),
//           ),
//           //},
//           //),
//           SizedBox(
//             width: 30,
//           )
//         ],
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           physics: NeverScrollableScrollPhysics(),
//           child: Column(
//             children: [
//               Container(
//                 height: MediaQuery.sizeOf(context).height * 0.74,
//                 decoration: BoxDecoration(
//                   //shape: BoxShape.rectangle,
//                   color: Colors.grey[300],
//                   // borderRadius: BorderRadius.circular(18),
//                 ),
//                 child: ListView.builder(
//                     itemBuilder: ((context, index) => ExerciceWidget(
//                           //weightController: controllers,
//                           onTap: () {
//                             print("fl exXidget" + index.toString());
//                             // Navigator.push(context,
//                             //     MaterialPageRoute(builder: (context) {
//                             //   return BodyPartDetailsScreen(
//                             //     exercise: data[index],
//                             //   );
//                             // }));
//                           },
//                           exerciseImage: "${Api.baseUrl}exercise/" +
//                               widget.data[index].image,
//                           exerciseName: widget.data[index].name,
//                           bodyPartName: widget.data[index].bodyPart,
//                           nbrSer: widget.planDoing.nbrsSeries[index],
//                           serieChecked: seriesCompletedChecked[index],
//                           weightsAndrepetitions: seriesCompleted[index],
//                           // repetitions: widget.seriesCompleted[index],
//                         )),
//                     // separatorBuilder: (context, index) => const SizedBox(
//                     //       height: 0,
//                     //     ),
//                     itemCount: widget.data!.length),
//               ),
//               Container(
//                 height: MediaQuery.sizeOf(context).height * 0.1,
//                 color: Colors.grey.shade200,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ElevatedButton(
//                       child: Text(
//                         "Terminer",
//                         style: TextStyle(fontSize: 23, color: Colors.white),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue[700],
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         fixedSize: Size(
//                             (MediaQuery.of(context).size.width * 0.70),
//                             (MediaQuery.of(context).size.height * 0.058)),
//                       ),
//                       onPressed: () {
//                         print(seriesCompletedChecked);
//                         print(seriesCompleted);

//                         //[[[1, 2]], [[3, 4], [5, 6]], [[7, 8], [9, 10], [11, 12]]]
//                         List<List<dynamic>> list = seriesCompleted;
//                         List<List<dynamic>> listChecked =
//                             seriesCompletedChecked;
//                         // for (int i = 0; i < (listChecked.length); i++) {
//                         //   for (int j = 0; j < (listChecked[i].length); j++) {
//                         //     if (listChecked[i][j] == false) {
//                         //       list[i][j] = ["n", "n"];
//                         //     }
//                         //   }
//                         // }
//                         print("ahaya");
//                         print(list);
//                         String selonEx = "";

//                         //selonEx = list.join(",");
//                         for (int i = 0; i < (list.length); i++) {
//                           for (int j = 0; j < (list[i].length); j++) {
//                             for (int k = 0; k < (list[i][j].length); k++) {
//                               selonEx = selonEx + list[i][j][k];
//                               if (k + 1 == list[i][j].length) continue;
//                               selonEx = selonEx + "*";
//                             }
//                             if (j + 1 == list[i].length) continue;
//                             selonEx = selonEx + ",";
//                           }
//                           if (i + 1 == list.length) continue;
//                           selonEx = selonEx + ";";
//                         }

//                         print(selonEx);
//                         String exsTostring =
//                             widget.planDoing.exercises.join(',');
//                         String nbrsSeriesTostring =
//                             widget.planDoing.nbrsSeries.join(',');

//                         Map<String, String> thedata = {
//                           "planName": widget.planDoing.planName,
//                           "nbrExercises":
//                               (widget.planDoing.exercises.length).toString(),
//                           "exercises": exsTostring,
//                           "nbrsSeries": nbrsSeriesTostring,
//                           "seriesCompleted": selonEx,
//                         };
//                         // Api.addPlanCompleted(thedata);

//                         print(seriesCompletedChecked);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ExerciceWidget extends StatefulWidget {
//   ExerciceWidget({
//     super.key,
//     required this.exerciseImage,
//     required this.exerciseName,
//     required this.bodyPartName,
//     required this.nbrSer,
//     required this.serieChecked,
//     required this.onTap,
//     required this.weightsAndrepetitions,
//     //required this.weightController,
//   });
//   void Function() onTap;
//   final String exerciseImage;
//   final String exerciseName;
//   final String bodyPartName;
//   final String nbrSer;
//   List serieChecked;
//   List weightsAndrepetitions;
//   //List repetitions;

// //  List<TextEditingController> weightController;
//   @override
//   State<ExerciceWidget> createState() => _ExerciceWidgetState();
// }

// class _ExerciceWidgetState extends State<ExerciceWidget> {
//   //List controllers = List.generate(6, (_) => TextEditingController());
//   bool clicked = false;
// //late TextEditingController _repetitonController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 2),
//       child: Container(
//         height: clicked ? (100 + (65 * double.parse(widget.nbrSer))) : 80,
//         decoration: BoxDecoration(
//           //shape: BoxShape.rectangle,
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//           child: Column(
//             children: [
//               InkWell(
//                 onTap: () {
//                   clicked = !clicked;
//                   setState(() {});
//                 },
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 30,
//                       child: clicked
//                           ? Icon(CupertinoIcons.arrowtriangle_down)
//                           : Icon(CupertinoIcons.arrowtriangle_up),
//                     ),
//                     Expanded(
//                       child: ListTile(
//                         //tileColor: Colors.white,
//                         contentPadding:
//                             const EdgeInsets.only(left: 5, right: 15),
//                         leading: SizedBox(
//                           height: 70,
//                           width: 60,
//                           // constraints: BoxConstraints(
//                           //   minWidth: 70,
//                           //   minHeight: 40,
//                           //   maxWidth: 95,
//                           //   maxHeight: 90,
//                           // ),
//                           child: Image.network(
//                             widget.exerciseImage,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         title: Text(
//                           widget.exerciseName,
//                           style: const TextStyle(
//                               fontSize: 13, fontWeight: FontWeight.w600),
//                         ),
//                         subtitle: Text(
//                           widget.bodyPartName,
//                           style: const TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black45),
//                         ),
//                         trailing: Text("Series : ${widget.nbrSer}"),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (clicked)
//                 Column(
//                   children: [
//                     SizedBox(
//                       height: 10,
//                     ),
//                     SizedBox(
//                       child: ListView.separated(
//                         physics: NeverScrollableScrollPhysics(),
//                         separatorBuilder: (context, index) => SizedBox(
//                           height: 8,
//                         ),
//                         shrinkWrap: true,
//                         itemBuilder: ((context, index) => SetContainer(
//                               contentRep: "",
//                               contentWeight: "",
//                               //TODO: l checkbox matet3ada kan maykunu l donnes m3ebiin;
//                               //weightController: controllers[index],
//                               // weight: widget.weightsAndrepetitions[index],
//                               // repetition: widget.weightsAndrepetitions[index],
//                               weightFunction: (p0) {
//                                 widget.weightsAndrepetitions[index][0] = p0;
//                                 // String a = p0;
//                                 // int i = widget.weightsAndrepetitions[index]
//                                 //     .indexOf(';');
//                                 // int l =
//                                 //     widget.weightsAndrepetitions[index].length;

//                                 // if (i > 0) {
//                                 //   String sliced = widget
//                                 //       .weightsAndrepetitions[index]
//                                 //       .substring(i, l);

//                                 //   widget.weightsAndrepetitions[index] =
//                                 //       p0 + sliced;
//                                 // } else if (widget
//                                 //         .weightsAndrepetitions[index] ==
//                                 //     "") {
//                                 //   widget.weightsAndrepetitions[index] = a;
//                                 // } else {
//                                 //   widget.weightsAndrepetitions[index] =
//                                 //       a + widget.weightsAndrepetitions[index];
//                                 // }

//                                 return p0;
//                               },
//                               repetetionFunction: (p1) {
//                                 //print("fl setcontainer  " + index.toString());
//                                 widget.weightsAndrepetitions[index][1] = p1;
//                                 // int i = widget.weightsAndrepetitions[index]
//                                 //     .indexOf(';');
//                                 // late String sliced;
//                                 // if (i > 0) {
//                                 //   sliced = widget.weightsAndrepetitions[index]
//                                 //       .substring(0, i);
//                                 //   // widget.weightsAndrepetitions[index] = "";
//                                 //   widget.weightsAndrepetitions[index] =
//                                 //       sliced + ";" + p1;
//                                 // } else if (widget
//                                 //         .weightsAndrepetitions[index] !=
//                                 //     "") {
//                                 //   //widget.weightsAndrepetitions[index] = "";
//                                 //   widget.weightsAndrepetitions[index] =
//                                 //       widget.weightsAndrepetitions[index] +
//                                 //           ";" +
//                                 //           p1;
//                                 // } else {
//                                 //   widget.weightsAndrepetitions[index] = p1;
//                                 // }
//                                 return p1;
//                               },
//                               isChecked: widget.serieChecked[index],
//                               chekedSetFunction: (p0) =>
//                                   widget.serieChecked[index] = p0,
//                               serieNumber: (index + 1).toString(),
//                             )),
//                         itemCount: int.parse(widget.nbrSer),
//                       ),
//                     ),
//                   ],
//                 )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SetContainer extends StatefulWidget {
//   SetContainer({
//     super.key,
//     required this.serieNumber,
//     required this.chekedSetFunction,
//     required this.isChecked,
//     //required this.weight,
//     required this.weightFunction,
//     //required this.repetition,
//     required this.repetetionFunction,
//     required this.contentWeight,
//     required this.contentRep,
//     //required this.weightController,
//   });

//   //bool serieChecked;
//   bool Function(bool) chekedSetFunction;
//   //String weight;
//   String Function(String) weightFunction;
//   //String repetition;
//   String Function(String) repetetionFunction;
//   String serieNumber;
//   bool isChecked;
//   String contentWeight;
//   String contentRep;
//   //TextEditingController weightController;
// //TextEditingController _repetitonController;
//   //ba3d bch ki tetsaker w t3awed tet7al kanha checked to93d checked

//   @override
//   State<SetContainer> createState() => _SetContainerState();
// }

// late bool serieChecked;
// late TextEditingController _weightController = TextEditingController();
// // late TextEditingController _repetitonController = TextEditingController();

// class _SetContainerState extends State<SetContainer> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // if (widget.test == "") {
//     //   serieChecked = widget.chekedSetFunction(false);
//     // } else {
//     //   serieChecked = widget.chekedSetFunction(true);
//     // }
//     serieChecked = widget.isChecked;
//     //_weightController = widget.weightController;
//     // _weightController.text = widget.weight;
//     //_repetitonController.text = widget.repetition;
//   }

//   // void _submitForm(String value) {
//   //   // Handle form submission logic here
//   //   //String fieldValue = _name.text;
//   //   //print('Field Value: $fieldValue');
//   //   widget.weightFunction(value);
//   //   setState(() {});
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         //shape: BoxShape.rectangle,
//         color: serieChecked ? Colors.green : Colors.black.withOpacity(0.7),

//         borderRadius: BorderRadius.circular(20),
//       ),
//       width: MediaQuery.sizeOf(context).width * 0.88,
//       height: 55,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           //TODO: maynajmch ya3di set
//           CupertinoCheckbox(
//             value: serieChecked,
//             onChanged: (newBool) {
//               //ndhaer toast wela nbadel lon l setcontainer kan l fields far8iin
//               setState(() {
//                 //if (widget.contentWeight.isNotEmpty &&
//                 //  widget.contentRep.isNotEmpty) {
//                 serieChecked = newBool!;
//                 widget.chekedSetFunction(newBool);
//                 //}
//               });
//             },
//             checkColor: Colors.green, // Color of the check icon
//             activeColor: Colors.white,
//             inactiveColor: Colors.white,
//           ),
//           Text(
//             widget.serieNumber,
//             style: TextStyle(
//                 fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           SizedBox(
//             height: 43,
//             width: 60,
//             child: TextFormField(
//               //controller: _weightController,
//               onChanged: (value) {
//                 widget.contentWeight = value;
//                 widget.weightFunction(value);
//               },
//               textAlignVertical: TextAlignVertical.top,
//               style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold),
//               //maxLength: 2,
//               showCursor: true,
//               cursorColor: Colors.white,

//               //textAlignVertical: TextAlignVertical.center,
//               textAlign: TextAlign.center,

//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: serieChecked
//                     ? Colors.green.shade300
//                     : Colors.black.withOpacity(0.5),
//                 border: InputBorder.none,
//                 //errorText: newPlanName ? null : "error",
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   // borderSide: BorderSide(
//                   //   color: widget.serieChecked
//                   //       ? Colors.green
//                   //       : Colors.black.withOpacity(0.7),
//                   // ),
//                   borderSide: BorderSide.none,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   // borderSide: BorderSide(
//                   //   color: widget.serieChecked
//                   //       ? Colors.green
//                   //       : Colors.black.withOpacity(0.7),
//                   // ),
//                   borderSide: BorderSide.none,
//                 ),
//                 // hintText: "eg: Plan 1",
//                 //border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           Text(
//             "KG",
//             style: TextStyle(
//                 fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             height: 43,
//             width: 60,
//             child: TextFormField(
//               onChanged: (value) {
//                 widget.contentRep = value;
//                 widget.repetetionFunction(value);
//               },
//               textAlignVertical: TextAlignVertical.top,
//               style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold),
//               //maxLength: 2,
//               showCursor: true,
//               cursorColor: Colors.white,

//               //textAlignVertical: TextAlignVertical.center,
//               textAlign: TextAlign.center,

//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: serieChecked
//                     ? Colors.green.shade300
//                     : Colors.black.withOpacity(0.5),
//                 border: InputBorder.none,
//                 //errorText: newPlanName ? null : "error",
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide.none,
//                   // borderSide: BorderSide(
//                   //   color: widget.serieChecked
//                   //       ? Colors.green
//                   //       : Colors.black.withOpacity(0.7),
//                   // ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide.none,
//                   // borderSide: BorderSide(
//                   //   color: widget.serieChecked
//                   //       ? Colors.green
//                   //       : Colors.black.withOpacity(0.7),
//                   // ),
//                 ),
//                 // hintText: "eg: Plan 1",
//                 //border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           Text(
//             "REP",
//             style: TextStyle(
//                 fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             width: 10,
//           )
//         ],
//       ),
//     );
//   }
// }
