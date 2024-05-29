import 'package:flutter/material.dart';
import 'package:gym_app/core/historiquesPlans.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:gym_app/services/Api.dart';

class RapportScreen extends StatefulWidget {
  RapportScreen({super.key, required this.theuser});
  User theuser;
  @override
  State<RapportScreen> createState() => _RapportScreenState();
}

class _RapportScreenState extends State<RapportScreen> {
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   pageVar = 1;
  // }

  // @override
  // void setState(VoidCallback fn) {
  //   // TODO: implement setState

  //   if (pageVar != 0) {
  //     super.setState(fn);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // if (pageVar != 0) {
    //   setState(() {});
    // }
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        surfaceTintColor: Colors.grey.shade200,
        title: Text(
          "Rapport",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                ),
                // IconButton(
                //   onPressed: () {
                //     // setState(() {});
                //   },
                //   icon: Icon(
                //     Icons.refresh_sharp,
                //     color: Colors.indigo.shade700,
                //   ),
                // )
              ],
            ),
            FutureBuilder(
              future: Api.getCompletedPlansByOwnerId(widget.theuser.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  //TODO: if it return null , must handle the error
                  List<dynamic> plans = snapshot.data;
                  String a;
                  int s = 0;
                  for (int i = 0; i < plans.length; i++) {
                    a = (plans[i].time).toString().substring(0, 2);
                    s = s + int.parse(a);
                  }

                  int s1 = 0;
                  List<dynamic> lista;
                  for (int i = 0; i < plans.length; i++) {
                    lista = plans[i].seriesCompleted;
                    for (int j = 0; j < lista.length; j++) {
                      for (int k = 0; k < lista[j].length; k++) {
                        if (lista[j][k][0] != "n") {
                          s1 = int.parse(lista[j][k][0]) + s1;
                        }
                      }
                    }
                  }

                  int count = plans.length;
                  if (plans.length >= 2) {
                    count = 2;
                  }
                  if (plans.length == 1) {
                    count = 1;
                  }
                  // if (plans.isEmpty) {
                  //   return totalContainer(
                  //     plansNumber: (plans.length).toString(),
                  //     time: s.toString(),
                  //     allWeights: s1.toString(),
                  //   );
                  // }
                  return totalContainer(
                    plansNumber: (plans.length).toString(),
                    time: s.toString(),
                    allWeights: s1.toString(),
                  );
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Historique",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                ),
                // Text(
                //   "les 2 plus récents",
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                // ),
                TextButton(
                  child: Text(
                    "Voir tout",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.indigo.shade700,
                        fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => historiquePlansScreen(
                                  theuser: widget.theuser,
                                )));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SizedBox(
                child: FutureBuilder(
                  future: Api.getCompletedPlansByOwnerId(widget.theuser.id),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      //TODO: if it return null , must handle the error
                      List<dynamic> plans = snapshot.data;
                      int count = plans.length;
                      if (plans.length >= 2) {
                        count = 2;
                      }
                      if (plans.length == 1) {
                        count = 1;
                      }
                      if (plans.isEmpty) {
                        return Center(
                          child: Text(
                            "Vous n'avez pas fait aucun plan pour le moment !",
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                      }
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          //shrinkWrap: true,
                          itemBuilder: ((context, index) => completedPlanWidget(
                                hour: (plans[plans.length - 1 - index]
                                        .currentTime)
                                    .toString()
                                    .substring(11, 16),
                                date: (plans[plans.length - 1 - index]
                                        .currentTime)
                                    .toString()
                                    .substring(5, 10),
                                time: plans[plans.length - 1 - index].time,
                                planName:
                                    (plans[plans.length - 1 - index].planName),
                                poids: plans[plans.length - 1 - index]
                                    .seriesCompleted,
                              )),
                          // separatorBuilder: (context, index) => const SizedBox(
                          //       height: 0,
                          //     ),
                          itemCount: count);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class totalContainer extends StatelessWidget {
  totalContainer(
      {super.key,
      required this.allWeights,
      required this.plansNumber,
      required this.time});
  String plansNumber;
  String time;
  String allWeights;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          //shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 10, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "Plans",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    plansNumber,
                    style: TextStyle(
                        color: Colors.indigo[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Temps",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    time + " min",
                    style: TextStyle(
                        color: Colors.indigo[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Volume",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    allWeights + " KG",
                    style: TextStyle(
                        color: Colors.indigo[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class completedPlanWidget extends StatelessWidget {
  completedPlanWidget(
      {super.key,
      required this.date,
      required this.planName,
      required this.hour,
      required this.time,
      required this.poids});
  String planName;
  String time;
  String date;
  String hour;
  List<dynamic> poids;

  @override
  Widget build(BuildContext context) {
    int myfunc(thelist) {
      List<dynamic> a = thelist;
      List b = [];
      List c = [];
      int s = 0;
      for (int i = 0; i < a.length; i++) {
        for (int j = 0; j < a[i].length; j++) {
          //for (int k = 0; k < a[i][j].length; k++) {
          if (a[i][j][0] != "n") {
            s = int.parse(a[i][j][0]) + s;
          }
          // }
        }
      }
      return s;
    }

    ;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        // height: 130,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          //shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 10, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Text(
                planName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        hour,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        date,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Durée",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        myfunc(poids).toString() + "KG",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Volume",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
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
