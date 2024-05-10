import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/model/planModel.dart';
import 'package:gym_app/services/Api.dart';

class doingPlanScreen extends StatefulWidget {
  doingPlanScreen({super.key, required this.planDoing});
  Plan planDoing;

  @override
  State<doingPlanScreen> createState() => _doingPlanScreenState();
}

class _doingPlanScreenState extends State<doingPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Text(widget.planDoing.planName,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
        actions: [
          Text(
            "00:55",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
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
                  child: FutureBuilder(
                      future: Api.getExercisesByPlan(widget.planDoing.planName),
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
                                      // Navigator.push(context,
                                      //     MaterialPageRoute(builder: (context) {
                                      //   return BodyPartDetailsScreen(
                                      //     exercise: data[index],
                                      //   );
                                      // }));
                                    },
                                    exerciseImage: "${Api.baseUrl}exercise/" +
                                        data[index].image,
                                    exerciseName: data[index].name,
                                    bodyPartName: data[index].bodyPart,
                                    nbrSer: widget.planDoing.nbrsSeries[index],
                                  )),
                              // separatorBuilder: (context, index) => const SizedBox(
                              //       height: 0,
                              //     ),
                              itemCount: data!.length);
                        }
                      })),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.1,
                color: Colors.grey.shade200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize: Size(
                            (MediaQuery.of(context).size.width * 0.70),
                            (MediaQuery.of(context).size.height * 0.058)),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Terminer",
                        style: TextStyle(fontSize: 23, color: Colors.white),
                      ),
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
  State<ExerciceWidget> createState() => _ExerciceWidgetState();
}

class _ExerciceWidgetState extends State<ExerciceWidget> {
  bool clicked = false;
  bool serieChecked = false;
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
                  clicked = !clicked;
                  setState(() {});
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
                              serieChecked: serieChecked,
                              serieNumber: (index + 1).toString(),
                            )),
                        itemCount: int.parse(widget.nbrSer),
                      ),
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

class SetContainer extends StatefulWidget {
  SetContainer({
    super.key,
    required this.serieChecked,
    required this.serieNumber,
  });

  bool serieChecked;
  String serieNumber;
  @override
  State<SetContainer> createState() => _SetContainerState();
}

class _SetContainerState extends State<SetContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //shape: BoxShape.rectangle,
        color:
            widget.serieChecked ? Colors.green : Colors.black.withOpacity(0.7),

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
            value: widget.serieChecked,
            onChanged: (newBool) {
              setState(() {
                widget.serieChecked = newBool!;
              });
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
                fillColor: widget.serieChecked
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
                fillColor: widget.serieChecked
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
  }
}
