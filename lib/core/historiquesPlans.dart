import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/core/rapport.dart';
import 'package:gym_app/services/Api.dart';

class historiquePlansScreen extends StatefulWidget {
  const historiquePlansScreen({super.key});

  @override
  State<historiquePlansScreen> createState() => _historiquePlansScreenState();
}

class _historiquePlansScreenState extends State<historiquePlansScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     setState(() {
        //       Navigator.pop(
        //         context,
        //         MaterialPageRoute(builder: (context) => RapportScreen()),
        //       );
        //       // Navigator.pushAndRemoveUntil(
        //       //     context,
        //       //     CupertinoPageRoute(
        //       //       builder: (context) => RapportScreen(),
        //       //     ),
        //       //     (route) => false);
        //     });
        //   },
        //   icon: const Icon(Icons.arrow_back_sharp),
        // ),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          "Historques",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              child: FutureBuilder(
                future: Api.getCompletedPlans(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    //TODO: if it return null , must handle the error
                    List<dynamic> plans = snapshot.data;
                    if (plans.isEmpty) {
                      return Center(
                        //TODO: image tbayen anou mafama 7ata plan ma5doum
                        child: Text(
                          "Vous n'avez pas fait aucun plan pour le moment !",
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                    }

                    return ListView.builder(
                        //physics: AlwaysScrollableScrollPhysics(),
                        //shrinkWrap: true,
                        itemBuilder: ((context, index) => completedPlanWidget(
                              hour:
                                  (plans[plans.length - 1 - index].currentTime)
                                      .toString()
                                      .substring(11, 16),
                              date:
                                  (plans[plans.length - 1 - index].currentTime)
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
                        itemCount: plans.length);
                  }
                },
              ),
            ),
          ),
        ],
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
        height: 130,
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
              Text(
                planName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
