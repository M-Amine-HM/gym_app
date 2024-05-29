import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          child: Column(
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
                          "Amine Gym",
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
                          "1 mois",
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
                          "20 Jours",
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Entrées :",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Sorties :",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
                                    dateswidget()),
                                separatorBuilder: (context, index) => Divider(
                                      indent: 30,
                                      endIndent: 30,
                                    ),
                                itemCount: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class dateswidget extends StatelessWidget {
  const dateswidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "20-05 09:05",
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
          VerticalDivider(
            //color: Colors.black,
            thickness: 2,
          ),
          Text(
            "20-05 10:35",
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
