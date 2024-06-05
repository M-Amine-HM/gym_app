import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/services/Api.dart';

class salleDeSportScreen extends StatefulWidget {
  const salleDeSportScreen({super.key});

  @override
  State<salleDeSportScreen> createState() => _salleDeSportScreenState();
}

class _salleDeSportScreenState extends State<salleDeSportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        surfaceTintColor: Colors.grey.shade200,
        centerTitle: true,
        title: Text(
          "Salle de Sport",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 5),
        child: Center(
          child: FutureBuilder(
            future: Api.getUserSubscribedById("66326bedae72e5ef0df7d6c7"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                //TODO: if it return null , must handle the error
                List<dynamic> subscription = snapshot.data;
                if (subscription.isEmpty) {
                  return Center(
                    //TODO: image tbayen anou mafama 7ata plan ma5doum
                    child: Text(
                      "Vous n'étes pas inscrit dans aucun salle de sport",
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }

                return Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Divider(
                    //   indent: 40,
                    //   endIndent: 40,
                    // ),

                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          //shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "Vous étes inscrit dans :",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                subscription[0].gymName,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo.shade700),
                              ),
                              Divider(
                                indent: 40,
                                endIndent: 40,
                              ),
                              Text(
                                "Vous avez fait un abonnement de :",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                subscription[0].subscription + " mois",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo.shade700),
                              ),
                              Divider(
                                indent: 40,
                                endIndent: 40,
                              ),
                              Text(
                                "Jours restants :",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                subscription[0].daysLeft + " Jours",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade700),
                              ),
                              Divider(
                                indent: 40,
                                endIndent: 40,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Entrées :",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Sorties :",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Container(
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: ((context, index) =>
                                          dateswidget(
                                            entrie:
                                                subscription[0].entries[index],
                                            exit: subscription[0].exits[index],
                                          )),
                                      separatorBuilder: (context, index) =>
                                          Divider(
                                            indent: 30,
                                            endIndent: 30,
                                          ),
                                      itemCount:
                                          subscription[0].entries.length),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class dateswidget extends StatelessWidget {
  dateswidget({
    super.key,
    required this.entrie,
    required this.exit,
  });
  String entrie;
  String exit;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            entrie,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
          VerticalDivider(
            //color: Colors.black,
            thickness: 2,
          ),
          Text(
            exit,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
