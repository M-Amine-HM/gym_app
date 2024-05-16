import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/model/planModel.dart';
import 'package:gym_app/services/Api.dart';

class doingThePlanScreen extends StatelessWidget {
  doingThePlanScreen({super.key, required this.planDoing, required this.data});
  Plan planDoing;
  List data;
  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> generateListOfLists(
        int numberOfLists, int lengthOfEachList, dynamic defaultValue) {
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
    List<List<dynamic>> seriesCompleted = [];
    seriesCompletedChecked = generateListOfLists(
      planDoing.nbrsSeries.length,
      1,
      false,
    );
    for (int i = 0; i < planDoing.nbrsSeries.length; i++) {
      for (int j = 0; j < (int.parse(planDoing.nbrsSeries[i]) - 1); j++) {
        seriesCompletedChecked[i].add(false);
      }
    }
    for (int i = 0; i < (planDoing.nbrsSeries).length; i++) {
      List<dynamic> k = [];
      for (int j = 0; j < int.parse(planDoing.nbrsSeries[i]); j++) {
        k.add(["", ""]);
      }
      seriesCompleted.add(k);
    }
    print(seriesCompleted);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Text(planDoing.planName,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     setState(() {
          //       pauseTimer = !pauseTimer;
          //     });
          //   },
          //   icon: pauseTimer
          //       ? Icon(
          //           Icons.play_arrow_sharp,
          //           size: 35,
          //         )
          //       : Icon(Icons.pause, size: 35),
          // ),
          // StreamBuilder<int>(
          //   stream: _timerStream,
          //   builder: (context, snapshot) {
          //     final int seconds = snapshot.data ?? 0;
          //     final int minutes = seconds ~/ 60;
          //     final int remainingSeconds = seconds % 60;

          //     return Text(
          //       '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}',
          //       style: TextStyle(fontSize: 40),
          //     );
          //   },
          // ),
          SizedBox(
            width: 30,
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.74,
                decoration: BoxDecoration(
                  //shape: BoxShape.rectangle,
                  color: Colors.grey[300],
                  // borderRadius: BorderRadius.circular(18),
                ),
                child: ListView.builder(
                    itemBuilder: ((context, index) => ExerciceWidget(
                          //weightController: controllers,
                          onTap: () {
                            print("fl exXidget" + index.toString());
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) {
                            //   return BodyPartDetailsScreen(
                            //     exercise: data[index],
                            //   );
                            // }));
                          },
                          exerciseImage:
                              "${Api.baseUrl}exercise/" + data[index].image,
                          exerciseName: data[index].name,
                          bodyPartName: data[index].bodyPart,
                          nbrSer: planDoing.nbrsSeries[index],
                          serieChecked: seriesCompletedChecked[index],
                          weightsAndrepetitions: seriesCompleted[index],
                          // repetitions: widget.seriesCompleted[index],
                        )),
                    // separatorBuilder: (context, index) => const SizedBox(
                    //       height: 0,
                    //     ),
                    itemCount: data.length),
              ),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.1,
                color: Colors.grey.shade200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text(
                        "Terminer",
                        style: TextStyle(fontSize: 23, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize: Size(
                            (MediaQuery.of(context).size.width * 0.70),
                            (MediaQuery.of(context).size.height * 0.058)),
                      ),
                      onPressed: () {
                        print(seriesCompletedChecked);
                        print(seriesCompleted);

                        //[[[1, 2]], [[3, 4], [5, 6]], [[7, 8], [9, 10], [11, 12]]]
                        List<List<dynamic>> list = seriesCompleted;
                        List<List<dynamic>> listChecked =
                            seriesCompletedChecked;
                        // for (int i = 0; i < (listChecked.length); i++) {
                        //   for (int j = 0; j < (listChecked[i].length); j++) {
                        //     if (listChecked[i][j] == false) {
                        //       list[i][j] = ["n", "n"];
                        //     }
                        //   }
                        // }
                        print("ahaya");
                        print(list);
                        String selonEx = "";

                        //selonEx = list.join(",");
                        for (int i = 0; i < (list.length); i++) {
                          for (int j = 0; j < (list[i].length); j++) {
                            for (int k = 0; k < (list[i][j].length); k++) {
                              selonEx = selonEx + list[i][j][k];
                              if (k + 1 == list[i][j].length) continue;
                              selonEx = selonEx + "*";
                            }
                            if (j + 1 == list[i].length) continue;
                            selonEx = selonEx + ",";
                          }
                          if (i + 1 == list.length) continue;
                          selonEx = selonEx + ";";
                        }

                        print(selonEx);
                        String exsTostring = planDoing.exercises.join(',');
                        String nbrsSeriesTostring =
                            planDoing.nbrsSeries.join(',');

                        Map<String, String> thedata = {
                          "planName": planDoing.planName,
                          "nbrExercises":
                              (planDoing.exercises.length).toString(),
                          "exercises": exsTostring,
                          "nbrsSeries": nbrsSeriesTostring,
                          "seriesCompleted": selonEx,
                        };
                        // Api.addPlanCompleted(thedata);

                        print(seriesCompletedChecked);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciceWidget extends StatelessWidget {
  ExerciceWidget({
    super.key,
    required this.exerciseImage,
    required this.exerciseName,
    required this.bodyPartName,
    required this.nbrSer,
    required this.serieChecked,
    required this.onTap,
    required this.weightsAndrepetitions,
    //required this.weightController,
  });
  void Function() onTap;
  final String exerciseImage;
  final String exerciseName;
  final String bodyPartName;
  final String nbrSer;
  List serieChecked;
  List weightsAndrepetitions;
  //List repetitions;

// //  List<TextEditingController> weightController;
//   @override
//   State<ExerciceWidget> createState() => _ExerciceWidgetState();
// }

// class _ExerciceWidgetState extends State<ExerciceWidget> {
  //List controllers = List.generate(6, (_) => TextEditingController());

//late TextEditingController _repetitonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool clicked = false;
    return Padding(
        padding: EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 2),
        child: StatefulBuilder(builder: (context, myStateFunc) {
          return Container(
            height: clicked ? (100 + (65 * double.parse(nbrSer))) : 80,
            decoration: BoxDecoration(
              //shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      myStateFunc(
                        () {
                          clicked = !clicked;
                        },
                      );
                      //setState(() {});
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                          child: clicked
                              ? Icon(CupertinoIcons.arrowtriangle_down)
                              : Icon(CupertinoIcons.arrowtriangle_up),
                        ),
                        Expanded(
                          child: ListTile(
                            //tileColor: Colors.white,
                            contentPadding:
                                const EdgeInsets.only(left: 5, right: 15),
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
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              bodyPartName,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black45),
                            ),
                            trailing: Text("Series : ${nbrSer}"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (clicked)
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 8,
                            ),
                            shrinkWrap: true,
                            itemBuilder: ((context, index) => SetContainer(
                                  contentRep: "",
                                  contentWeight: "",
                                  //TODO: l checkbox matet3ada kan maykunu l donnes m3ebiin;
                                  //weightController: controllers[index],
                                  // weight: widget.weightsAndrepetitions[index],
                                  // repetition: widget.weightsAndrepetitions[index],
                                  weightFunction: (p0) {
                                    weightsAndrepetitions[index][0] = p0;
                                    // String a = p0;
                                    // int i = widget.weightsAndrepetitions[index]
                                    //     .indexOf(';');
                                    // int l =
                                    //     widget.weightsAndrepetitions[index].length;

                                    // if (i > 0) {
                                    //   String sliced = widget
                                    //       .weightsAndrepetitions[index]
                                    //       .substring(i, l);

                                    //   widget.weightsAndrepetitions[index] =
                                    //       p0 + sliced;
                                    // } else if (widget
                                    //         .weightsAndrepetitions[index] ==
                                    //     "") {
                                    //   widget.weightsAndrepetitions[index] = a;
                                    // } else {
                                    //   widget.weightsAndrepetitions[index] =
                                    //       a + widget.weightsAndrepetitions[index];
                                    // }

                                    return p0;
                                  },
                                  repetetionFunction: (p1) {
                                    //print("fl setcontainer  " + index.toString());
                                    weightsAndrepetitions[index][1] = p1;
                                    // int i = widget.weightsAndrepetitions[index]
                                    //     .indexOf(';');
                                    // late String sliced;
                                    // if (i > 0) {
                                    //   sliced = widget.weightsAndrepetitions[index]
                                    //       .substring(0, i);
                                    //   // widget.weightsAndrepetitions[index] = "";
                                    //   widget.weightsAndrepetitions[index] =
                                    //       sliced + ";" + p1;
                                    // } else if (widget
                                    //         .weightsAndrepetitions[index] !=
                                    //     "") {
                                    //   //widget.weightsAndrepetitions[index] = "";
                                    //   widget.weightsAndrepetitions[index] =
                                    //       widget.weightsAndrepetitions[index] +
                                    //           ";" +
                                    //           p1;
                                    // } else {
                                    //   widget.weightsAndrepetitions[index] = p1;
                                    // }
                                    return p1;
                                  },
                                  isChecked: serieChecked[index],
                                  chekedSetFunction: (p0) =>
                                      serieChecked[index] = p0,
                                  serieNumber: (index + 1).toString(),
                                )),
                            itemCount: int.parse(nbrSer),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          );
        }));
  }
}

class SetContainer extends StatefulWidget {
  SetContainer({
    super.key,
    required this.serieNumber,
    required this.chekedSetFunction,
    required this.isChecked,
    //required this.weight,
    required this.weightFunction,
    //required this.repetition,
    required this.repetetionFunction,
    required this.contentWeight,
    required this.contentRep,
    //required this.weightController,
  });

  //bool serieChecked;
  bool Function(bool) chekedSetFunction;
  //String weight;
  String Function(String) weightFunction;
  //String repetition;
  String Function(String) repetetionFunction;
  String serieNumber;
  bool isChecked;
  String contentWeight;
  String contentRep;

  @override
  State<SetContainer> createState() => _SetContainerState();
}

class _SetContainerState extends State<SetContainer> {
  //TextEditingController weightController;
  @override
  Widget build(BuildContext context) {
    late bool serieChecked;
    late TextEditingController _weightController = TextEditingController();
    serieChecked = widget.isChecked;
    //return StatefulBuilder(builder: (context, statefunc) {
    return Container(
      decoration: BoxDecoration(
        //shape: BoxShape.rectangle,
        color: serieChecked ? Colors.green : Colors.black.withOpacity(0.7),

        borderRadius: BorderRadius.circular(20),
      ),
      width: MediaQuery.sizeOf(context).width * 0.88,
      height: 55,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //TODO: maynajmch ya3di set
          CupertinoCheckbox(
            value: serieChecked,
            onChanged: (newBool) {
              //ndhaer toast wela nbadel lon l setcontainer kan l fields far8iin
              //if (contentWeight.isNotEmpty && contentRep.isNotEmpty) {
              //  statefunc(
              //() {
              serieChecked = newBool!;
              widget.chekedSetFunction(newBool);
              // },
              //);
              //  }
              // setState(() {
              // });
            },
            checkColor: Colors.green, // Color of the check icon
            activeColor: Colors.white,
            inactiveColor: Colors.white,
          ),
          Text(
            widget.serieNumber,
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            height: 43,
            width: 60,
            child: TextFormField(
              //controller: _weightController,
              onChanged: (value) {
                //statefunc(
                //() {
                widget.contentWeight = value;
                widget.weightFunction(value);
                // },
                //);
              },
              textAlignVertical: TextAlignVertical.top,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              //maxLength: 2,
              showCursor: true,
              cursorColor: Colors.white,

              //textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,

              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: serieChecked
                    ? Colors.green.shade300
                    : Colors.black.withOpacity(0.5),
                border: InputBorder.none,
                //errorText: newPlanName ? null : "error",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  // borderSide: BorderSide(
                  //   color: widget.serieChecked
                  //       ? Colors.green
                  //       : Colors.black.withOpacity(0.7),
                  // ),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  // borderSide: BorderSide(
                  //   color: widget.serieChecked
                  //       ? Colors.green
                  //       : Colors.black.withOpacity(0.7),
                  // ),
                  borderSide: BorderSide.none,
                ),
                // hintText: "eg: Plan 1",
                //border: OutlineInputBorder(),
              ),
            ),
          ),
          Text(
            "KG",
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 43,
            width: 60,
            child: TextFormField(
              onChanged: (value) {
                //statefunc(
                //() {
                widget.contentRep = value;
                widget.repetetionFunction(value);
                //},
                //);
              },
              textAlignVertical: TextAlignVertical.top,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              //maxLength: 2,
              showCursor: true,
              cursorColor: Colors.white,

              //textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,

              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: serieChecked
                    ? Colors.green.shade300
                    : Colors.black.withOpacity(0.5),
                border: InputBorder.none,
                //errorText: newPlanName ? null : "error",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                  // borderSide: BorderSide(
                  //   color: widget.serieChecked
                  //       ? Colors.green
                  //       : Colors.black.withOpacity(0.7),
                  // ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                  // borderSide: BorderSide(
                  //   color: widget.serieChecked
                  //       ? Colors.green
                  //       : Colors.black.withOpacity(0.7),
                  // ),
                ),
                // hintText: "eg: Plan 1",
                //border: OutlineInputBorder(),
              ),
            ),
          ),
          Text(
            "REP",
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
    //});
  }
}
