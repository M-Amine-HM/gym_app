import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gym_app/auth/firstPage.dart';
import 'package:gym_app/core/doingPlan.dart';
import 'package:gym_app/core/plans.dart';
import 'package:gym_app/core/rapport.dart';
import 'package:gym_app/home.dart';
import 'package:gym_app/model/planModel.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:gym_app/providers/checked_provider.dart';
import 'package:gym_app/providers/timer_provider.dart';
import 'package:gym_app/services/Api.dart';
import 'package:provider/provider.dart';

class doingThePlanScreen extends StatefulWidget {
  doingThePlanScreen(
      {super.key,
      required this.planDoing,
      required this.data,
      required this.theuser});
  Plan planDoing;
  List data;
  User theuser;

  @override
  State<doingThePlanScreen> createState() => _doingThePlanScreenState();
}

class _doingThePlanScreenState extends State<doingThePlanScreen> {
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //context.read<CheckedProvider>().seriesChecked;
    // final checkedProvider =
    //     Provider.of<CheckedProvider>(context, listen: false);
    final timerProvider = Provider.of<TimerProvider>(context, listen: false);
    //timerProvider.resetTimer();
    // timerProvider.changeSeconds();
    //checkedProvider.seriesChecked = seriesCompletedChecked;
    timerProvider.startTimer();
    timerProvider.timerOn = true;
    // sseriesCompletedChecked = seriesCompletedChecked;
    // print("object");
    // print(sseriesCompletedChecked);

    seriesCompletedChecked = generateListOfLists(
      widget.planDoing.nbrsSeries.length,
      1,
      false,
    );
    for (int i = 0; i < widget.planDoing.nbrsSeries.length; i++) {
      for (int j = 0;
          j < (int.parse(widget.planDoing.nbrsSeries[i]) - 1);
          j++) {
        seriesCompletedChecked[i].add(false);
      }
    }
    for (int i = 0; i < (widget.planDoing.nbrsSeries).length; i++) {
      List<dynamic> k = [];
      for (int j = 0; j < int.parse(widget.planDoing.nbrsSeries[i]); j++) {
        k.add(["", ""]);
      }
      seriesCompleted.add(k);
    }
    print(seriesCompleted);
    //bool pauseTimer = context.watch<TimerProvider>().isTimerStarted;
    // ab = seriesCompletedChecked;
    // print("object");
    // print(ab);
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    // context.read<CheckedProvider>().updateSeriesChecked(ab);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              //Toast t9olou t7b to5rej ??
              timerProvider.timerOn = false;
              timerProvider.resetTimer();
              sseriesCompletedChecked = [];

              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.grey.shade200,
        title: Text(widget.planDoing.planName,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!(timerProvider.timerOn))
                IconButton(
                  onPressed: () {
                    timerProvider.timerOn = true;
                    timerProvider.startTimer();
                  },
                  icon: Icon(
                    Icons.play_arrow_rounded,
                    size: 30,
                  ),
                ),
              //SizedBox(width: 10),
              if (timerProvider.timerOn)
                IconButton(
                  onPressed: () {
                    timerProvider.timerOn = false;
                    timerProvider.stopTimer();
                  },
                  icon: Icon(
                    Icons.pause,
                    size: 30,
                  ),
                ),
              // SizedBox(width: 10),
              // ElevatedButton(
              //   onPressed: () {
              //     timerProvider.timerOn = false;
              //     timerProvider.resetTimer();
              //   },
              //   child: Text('Reset'),
              // ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            timerProvider.formatTime(),
            style: TextStyle(fontSize: 30.0),
          ),
          SizedBox(
            width: 25,
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
                          theEx: index,
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
                          exerciseImage: "${Api.baseUrl}exercise/" +
                              widget.data[index].image,
                          exerciseName: widget.data[index].name,
                          bodyPartName: widget.data[index].bodyPart,
                          nbrSer: widget.planDoing.nbrsSeries[index],
                          serieChecked: seriesCompletedChecked[index],
                          weightsAndrepetitions: seriesCompleted[index],
                          // repetitions: widget.seriesCompleted[index],
                        )),
                    // separatorBuilder: (context, index) => const SizedBox(
                    //       height: 0,
                    //     ),
                    itemCount: widget.data.length),
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
                      onPressed: () async {
                        print(seriesCompletedChecked);
                        print(seriesCompleted);
                        bool allNotChecked = true;
                        for (int i = 0;
                            i < seriesCompletedChecked.length;
                            i++) {
                          for (int j = 0;
                              j < (seriesCompletedChecked[i].length);
                              j++) {
                            if (seriesCompletedChecked[i][j] == true) {
                              allNotChecked = false;
                              break;
                            }
                          }
                          if (allNotChecked == false) {
                            break;
                          }
                        }
                        if (allNotChecked == true) {
                          showToast('faire au moins une serie',
                              context: context,
                              animation: StyledToastAnimation.fade,
                              backgroundColor: Colors.red.shade700,
                              duration: Duration(seconds: 3),
                              reverseAnimation: StyledToastAnimation.fade,
                              alignment: Alignment.center,
                              position: StyledToastPosition(
                                  align: Alignment.center, offset: 20.0));
                        } else {
                          //[[[1, 2]], [[3, 4], [5, 6]], [[7, 8], [9, 10], [11, 12]]]
                          List<List<dynamic>> list = seriesCompleted;
                          List<List<dynamic>> listChecked =
                              seriesCompletedChecked;
                          for (int i = 0; i < (listChecked.length); i++) {
                            for (int j = 0; j < (listChecked[i].length); j++) {
                              if (listChecked[i][j] == false) {
                                list[i][j] = ["n", "n"];
                              }
                            }
                          }
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
                          String exsTostring =
                              widget.planDoing.exercises.join(',');
                          String nbrsSeriesTostring =
                              widget.planDoing.nbrsSeries.join(',');
                          String currentTime =
                              (DateTime.now().toLocal().toString())
                                  .substring(0, 16);
                          Map<String, String> thedata = {
                            "currentTime": currentTime,
                            "time": timerProvider.formatTime(),
                            "planName": widget.planDoing.planName,
                            "nbrExercises":
                                (widget.planDoing.exercises.length).toString(),
                            "exercises": exsTostring,
                            "nbrsSeries": nbrsSeriesTostring,
                            "seriesCompleted": selonEx,
                            "userId": widget.planDoing.userId
                          };
                          await Api.addPlanCompleted(thedata);

                          print(seriesCompletedChecked);
                          print(thedata);
                          // Navigator.of(context, rootNavigator: false).push(
                          //   CupertinoPageRoute(
                          //       builder: (context) => RapportScreen()),
                          //   //(route) => false
                          // );
                          // Navigator.of(context, rootNavigator: true)
                          //     .pushAndRemoveUntil(
                          //         CupertinoPageRoute(
                          //             builder: (context) => FirstPage()),
                          //         (route) => false);
                          //User user = User();
                          //timerProvider.timerOn = false;
                          timerProvider.resetTimer();
                          //sseriesCompletedChecked = [];
                          //Navigator.pop(context);
                          showToastWidget(
                            reverseAnimation: StyledToastAnimation.fade,
                            //dismissOtherToast: false,
                            //animDuration: Duration(seconds: 1),
                            context: context,
                            animation: StyledToastAnimation.fade,
                            isIgnoring: false,
                            duration: Duration(seconds: 5),
                            position: const StyledToastPosition(
                                align: Alignment.center),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                ModalBarrier(
                                  color: Colors.black.withOpacity(0.1),
                                  dismissible:
                                      false, // Prevents dismissing the toast by tapping outside
                                ),
                                // Container(
                                //   color: Colors.black,
                                //   height: 50,
                                //   width: 50,
                                // ),
                                Container(
                                    // height:
                                    //     MediaQuery.sizeOf(context).height * 0.25,
                                    // width:
                                    //     MediaQuery.sizeOf(context).width * 0.78,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green,
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.grey.withOpacity(0.5),
                                      //     spreadRadius: 2,
                                      //     blurRadius: 7,
                                      //     offset: Offset(0, 3),
                                      //   ),
                                      // ],
                                    ),
                                    child: Text(
                                      "Plan fait avec succées",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    )),
                              ],
                            ),
                          );
                          await Future.delayed(Duration(seconds: 5));
                          //Navigator.pop(context);

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlansScreen(
                                  theuser: widget.theuser,
                                ),
                              ),
                              (route) => false);
                          // CupertinoTabView(
                          //   builder: (context) {
                          //     return const CupertinoPageScaffold(
                          //         child: RapportScreen());
                          //   },
                          // );
                          // Navigator.of(context).push(
                          //   CupertinoPageRoute(
                          //     builder: (context) => RapportScreen(),
                          //   ),
                          // );
                        }
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

class ExerciceWidget extends StatefulWidget {
  ExerciceWidget({
    super.key,
    required this.exerciseImage,
    required this.exerciseName,
    required this.bodyPartName,
    required this.nbrSer,
    required this.serieChecked,
    required this.onTap,
    required this.weightsAndrepetitions,
    required this.theEx,
    //required this.weightController,
  });
  void Function() onTap;
  final String exerciseImage;
  final String exerciseName;
  final String bodyPartName;
  final String nbrSer;
  List serieChecked;
  List weightsAndrepetitions;
  int theEx;

  @override
  State<ExerciceWidget> createState() => _ExerciceWidgetState();
}

class _ExerciceWidgetState extends State<ExerciceWidget> {
  bool clicked = false;

  //List repetitions;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 2),
        child: Container(
          height: clicked ? (100 + (65 * double.parse(widget.nbrSer))) : 80,
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
                    //myStateFunc(
                    //() {

                    //},
                    //);
                    setState(() {
                      clicked = !clicked;
                    });
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
                              widget.exerciseImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            widget.exerciseName,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            widget.bodyPartName,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black45),
                          ),
                          trailing: Text("Series : ${widget.nbrSer}"),
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
                                contentRep: widget.weightsAndrepetitions[index]
                                    [1],
                                contentWeight:
                                    widget.weightsAndrepetitions[index][0],
                                //TODO: l checkbox matet3ada kan maykunu l donnes m3ebiin;
                                //weightController: controllers[index],
                                // weight: widget.weightsAndrepetitions[index],
                                // repetition: widget.weightsAndrepetitions[index],
                                weightFunction: (p0) {
                                  widget.weightsAndrepetitions[index][0] = p0;
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
                                  widget.weightsAndrepetitions[index][1] = p1;
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
                                isChecked: widget.serieChecked[index],
                                theEX: widget.theEx,
                                theindex: index,
                                chekedSetFunction: (p0) {
                                  context.read<CheckedProvider>().changeChecked(
                                      checked: p0, i: widget.theEx, j: index);
                                  widget.serieChecked[index] = p0;
                                  return p0;
                                },

                                serieNumber: (index + 1).toString(),
                                // onTap: () {
                                //   widget.serieChecked[index] =
                                //       !widget.serieChecked[index];
                                //   // setState(() {});
                                // },
                              )),
                          itemCount: int.parse(widget.nbrSer),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ));
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
    //required this.onTap,
    required this.theindex,
    required this.theEX,
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
  String contentRep;
  String contentWeight;
  //void Function() onTap;
  int theindex;
  int theEX;

  @override
  State<SetContainer> createState() => _SetContainerState();
}

class _SetContainerState extends State<SetContainer> {
  TextEditingController _weightController = TextEditingController();
  late String contentRep;
  late String contentWeight;
  @override
  void initState() {
    super.initState();
    contentWeight = widget.contentWeight;

    contentRep = widget.contentRep;
  }
  //bool serieChecked = isChecked;

  @override
  Widget build(BuildContext context) {
    bool serieChecked = context
        .watch<CheckedProvider>()
        .seriesChecked[widget.theEX][widget.theindex];

    //serieChecked = isChecked;
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
              //serieChecked = newBool!;

              if (contentWeight.isNotEmpty && contentRep.isNotEmpty) {
                if ((double.tryParse(contentWeight) == null) ||
                    (double.tryParse(contentRep) == null)) {
                  showToast('les champs nes sont pas valides !!',
                      context: context,
                      animation: StyledToastAnimation.fade,
                      backgroundColor: Colors.red.shade700,
                      duration: Duration(seconds: 3),
                      reverseAnimation: StyledToastAnimation.fade,
                      alignment: Alignment.center,
                      position: StyledToastPosition(
                          align: Alignment.center, offset: 20.0));
                } else {
                  widget.chekedSetFunction(newBool!);
                  serieChecked = newBool;
                }
              } else {
                showToast('Remplir les champs !!',
                    context: context,
                    animation: StyledToastAnimation.fade,
                    duration: Duration(seconds: 3),
                    reverseAnimation: StyledToastAnimation.fade,
                    alignment: Alignment.center,
                    position: StyledToastPosition(
                        align: Alignment.center, offset: 20.0));
              }
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
              initialValue: contentWeight,
              //controller: _weightController,
              onChanged: (value) {
                //statefunc(
                //() {
                contentWeight = value;
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
              initialValue: contentRep,
              onChanged: (value) {
                //statefunc(
                //() {
                contentRep = value;
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
