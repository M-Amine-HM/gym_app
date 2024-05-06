import 'package:flutter/material.dart';
import 'package:gym_app/model/exerciseModel.dart';
import 'package:gym_app/services/Api.dart';

class ChooseExercisesScreen extends StatefulWidget {
  const ChooseExercisesScreen({super.key});

  @override
  State<ChooseExercisesScreen> createState() => _ChooseExercisesScreenState();
}

class _ChooseExercisesScreenState extends State<ChooseExercisesScreen> {
  TextEditingController _Exercisename = TextEditingController(text: "");
  late bool bo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
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
                              int length =
                                  data.length; // Specify the length of the list

                              List<bool> myList =
                                  List.generate(length, (index) => false);

                              print(myList); // Output: [0, 1, 2, 3, 4]
                              return ExerciceWidget(
                                  tobeChecked: true,
                                  isChecked: myList[index],
                                  exerciseName: data[index].name,
                                  bodyPartImage: "${Api.baseUrl}exercise/" +
                                      data[index].image,
                                  bodyPartName: data[index].bodyPart,
                                  onTap: () {
                                    myList[index] = !(myList[index]);
                                    setState(() {});
                                    print(myList[index]);
                                  });
                            }),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 0,
                                ),
                            itemCount: data!.length),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[700],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              fixedSize: Size(
                                  (MediaQuery.of(context).size.width * 0.8),
                                  45),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Comfirmer",
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
      required this.tobeChecked,
      required this.onTap});
  void Function() onTap;
  final String bodyPartImage;
  final String bodyPartName;
  final String exerciseName;
  bool? isChecked = false;
  bool tobeChecked = false;

  @override
  State<ExerciceWidget> createState() => _ExerciceWidgetState();
}

class _ExerciceWidgetState extends State<ExerciceWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
            onTap: widget.onTap,
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
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              widget.bodyPartName,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45),
            ),
            trailing: Checkbox(
              value: widget.isChecked,
              onChanged: (newBool) {
                setState(() {
                  widget.isChecked = newBool;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
