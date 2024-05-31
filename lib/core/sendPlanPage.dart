// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:gym_app/services/Api.dart';

class sendPlanScreen extends StatefulWidget {
  sendPlanScreen(
      {super.key,
      required this.theUserId,
      required this.booleanList,
      required this.TheUserName,
      required this.totheUserId});
  final String theUserId;
  final String TheUserName;
  final String totheUserId;
  List<bool> booleanList;
  @override
  State<sendPlanScreen> createState() => _sendPlanScreenState();
}

class _sendPlanScreenState extends State<sendPlanScreen> {
  late List<bool> thecheckedlist;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    thecheckedlist = widget.booleanList;
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
            "Envoyer Plan",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: FutureBuilder(
                  future: Api.getPlanByOwner(widget.theUserId),
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
                                child: PlanFriendWidget(
                                    isChecked: thecheckedlist[index],
                                    onTap: () {
                                      thecheckedlist[index] =
                                          !thecheckedlist[index];
                                      setState(() {});
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
              Expanded(
                child: Container(
                  color: Colors.grey[200],
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize:
                            Size((MediaQuery.of(context).size.width * 0.8), 45),
                      ),
                      child: Text(
                        "Envoyer",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () async {
                        bool atleastone = false;
                        String exsTostring;
                        String nbrsSeriesTostring;
                        Map<String, String> thedata;
                        List? thelist =
                            await Api.getPlanByOwner(widget.theUserId);
                        for (int i = 0; i < thelist!.length; i++) {
                          if (thecheckedlist[i]) {
                            atleastone = true;
                            exsTostring = (thelist[i].exercises).join(',');
                            nbrsSeriesTostring =
                                (thelist[i].nbrsSeries).join(',');
                            thedata = {
                              "planName": thelist[i].planName,
                              "nbrExercises":
                                  ((thelist[i].exercises).length).toString(),
                              "exercises": exsTostring,
                              "nbrsSeries": nbrsSeriesTostring,
                              "userId": widget.totheUserId,
                              "planFrom": widget.TheUserName,
                            };
                            await Api.addFriendPlan(thedata);
                          }
                        }
                        if (!atleastone) {
                          showToast('Chosissez au minimum un plan à envoyer',
                              context: context,
                              //backgroundColor: Colors.red.shade500,
                              animation: StyledToastAnimation.fade,
                              duration: Duration(seconds: 3),
                              reverseAnimation: StyledToastAnimation.fade,
                              alignment: Alignment.center,
                              position: StyledToastPosition(
                                  align: Alignment.center, offset: 20.0));
                        } else {
                          showToastWidget(
                            reverseAnimation: StyledToastAnimation.fade,
                            //dismissOtherToast: false,
                            //animDuration: Duration(seconds: 1),
                            context: context,
                            animation: StyledToastAnimation.fade,
                            isIgnoring: false,
                            duration: Duration(seconds: 3),
                            position: const StyledToastPosition(
                                align: Alignment.center),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                ModalBarrier(
                                  color: Colors.black26,
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
                                        horizontal: 20, vertical: 10),
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
                                    child: const Text(
                                      "Envoyé avec succées",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )),
                              ],
                            ),
                          );
                          await Future.delayed(Duration(seconds: 3));
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class PlanFriendWidget extends StatefulWidget {
  PlanFriendWidget(
      {super.key,
      required this.planName,
      required this.nbrExercises,
      required this.exercises,
      required this.theimage,
      required this.onTap,
      required this.nbrsSeries,
      required this.isChecked});
  final String planName;
  final String nbrExercises;
  final List? exercises;
  final List? nbrsSeries;
  final String theimage;
  void Function() onTap;
  final bool isChecked;

  @override
  State<PlanFriendWidget> createState() => _PlanFriendWidgetState();
}

bool clicked = false;

class _PlanFriendWidgetState extends State<PlanFriendWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
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
                  widget.isChecked
                      ? Container(
                          height: 60,
                          width: 60,
                          child: Image(
                            image: AssetImage("assets/images/check.png"),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.red, //Color.fromRGBO(0, 186, 0, 1),
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text(
                              widget.theimage,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
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
