import 'package:flutter/material.dart';
import 'package:gym_app/core/planOnGoing.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlansScreen> {
  final List<Widget> _screens = [
    Container(
      color: Colors.grey.shade200,
      child: PlanContainerWidget(),
    ),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.blue,
    )
  ];

  late int screenS;
  @override
  void initState() {
    screenS = 0;
    super.initState();
  }

  void screenChanger(int screen) {
    setState(() {
      screenS = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        //shadowColor: Colors.grey.shade50,
        title: const Text(
          "Plan",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //TODO: Design des boutons et les couleurs
                ElevatedButton(
                  onPressed: () {
                    screenChanger(0);
                  },
                  child: Text(
                    "Mes Plans",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    screenChanger(1);
                  },
                  child: Text(
                    "Plans Prédéfinis",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    screenChanger(2);
                  },
                  child: Text(
                    "Plans amis",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 5,
            // ),
            Expanded(child: _screens[screenS])
          ],
        ),
      ),
    );
  }
}

class PlanContainerWidget extends StatelessWidget {
  const PlanContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: Size((MediaQuery.of(context).size.width * 0.55), 45),
              ),
              onPressed: () {},
              label: Text(
                "Créer un Plan",
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: ((context, index) => PlanWidget()),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 13,
                    ),
                itemCount: 5),
          ),
        ],
      ),
    );
  }
}

class PlanWidget extends StatelessWidget {
  const PlanWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OnGoingPlanScreen()));
      },
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
                          "Nom de Plan",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w700),
                          //softWrap: true,
                        ),
                        Text(
                          "Nombre des Exercices",
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
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.red,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: ((context, index) => ExNameAndNbrSetsRow()),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExNameAndNbrSetsRow extends StatelessWidget {
  const ExNameAndNbrSetsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "Nom de l'exercice",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Text(
            "Nbrs Series",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
