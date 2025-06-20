// ignore_for_file: non_constant_identifier_names

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/model/exerciseModel.dart';
import 'package:gym_app/services/Api.dart';
import 'package:video_player/video_player.dart';
// import 'package:video_player/video_player.dart';

class BodyPartDetailsScreen extends StatefulWidget {
  const BodyPartDetailsScreen({super.key, required this.exercise});
  final Exercise exercise;
  //final String ExerciceName;
  @override
  State<BodyPartDetailsScreen> createState() => _BodyPartDetailsScreenState();
}

List<String> _instructionDetails = [
  "Prenez une position de départ en vous asseyant dans la machine, après avoir réglé le siège, de manière à ce que l'angle initial entre vos épaules et votre torse soit de 80-90°. Rapprochez vos épaules.",
  "Expirez et rapprochez les poignées de la machine, après avoir ressenti une contraction des muscles de la torse",
  "Revenez à la position de départ de manière contrôlée",
  "Effectuez le nombre de répétitions requis",
  "hhhhh",
  "jjj"
];

List<String> _warningDetails = [
  "Effectuez l'exercice de manière contrôlée, sans inertie ni mouvement brusque.",
  "Contrôlez votre respiration, expirez lors d'une contraction musculaire.",
  "Gardez vos épaules rapprochées pendant toute la durée de l'exercice",
  "N'étirez pas trop vos muscles, afin de ne pas vous blesser",
  "hhehhdfh"
];

String _videoName = "video2";
String _exerciceName = "Arm chest flyes pliées à la machine";
String _exerciceDescription =
    "Il s'agit d'un exercice isolé visant à faire travailler les muscles de la poitrine. Cet exercice sollicite les muscles suivants : les torse, avec une petite aide des deltoides frontaux.";

class _BodyPartDetailsScreenState extends State<BodyPartDetailsScreen> {
  //late VideoPlayerController controller;
  final FijkPlayer player = FijkPlayer();

  @override
  void initState() {
    super.initState();
    // controller = VideoPlayerController.asset("assets/videos/$_videoName.mp4")
    // controller =
    //     VideoPlayerController.networkUrl(Uri.parse(widget.exercise.video))
    //       ..addListener(() => setState(() {}))
    //       ..setLooping(true)
    //       ..initialize().then((_) => controller.play());
    player.setLoop(20);

    //player.enterFullScreen();
    //player.isPlayable();
    player.setDataSource("${Api.baseUrl}exercise/" + widget.exercise.video,
        autoPlay: true, showCover: false);
  }

  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
    player.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Text(
          (widget.exercise.name),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // the video
                //    controller != null && controller.value.isInitialized
                //controller.value.isInitialized
                Center(
                  child: Container(
                    color: Colors.white,
                    height: 450,
                    child: FijkView(
                      fit: FijkFit.contain,
                      player: player,
                      panelBuilder:
                          (player, data, context, viewSize, texturePos) =>
                              Container(
                        color: Colors.white.withOpacity(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 460,
                              width: 65,
                              color: Colors.white,
                            ),
                            Container(
                              height: 460,
                              width: 65,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // ignore: sized_box_for_whitespace
                // : Container(
                //     height: 200,
                //     child: const Center(
                //       child: CircularProgressIndicator(),
                //     ),
                //   ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  (widget.exercise.name),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  (widget.exercise.description),
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 12),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Instruction",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.grey.shade500),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width * 1,
                //   height: 200,
                //   color: Colors.grey,
                //   child: Row(children: [],),
                // ),
                SizedBox(
                  //height: 80 * (_instructionDetails.length).toDouble(),
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) => InstructionWidget(
                          instructionIndex: (index + 1).toString(),
                          instructionDetails:
                              widget.exercise.instructions[index])),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: widget.exercise.instructions.length),
                ),

                const SizedBox(
                  height: 20,
                ),
                const Row(children: [
                  SizedBox(
                    height: 30,
                    child: Image(
                      image: AssetImage("assets/images/warningIcon.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "AVERTISSEMENTS",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  )
                ]),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      //height: (_warningDetails.length).toDouble() * 53,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 6,
                              offset: const Offset(5, 5),
                              blurRadius: 7,
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 13),
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: ((context, index) => WarningRowWidget(
                                WarningText: widget.exercise.warnings[index])),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                ),
                            itemCount: widget.exercise.warnings.length),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WarningRowWidget extends StatelessWidget {
  const WarningRowWidget({
    super.key,
    required this.WarningText,
  });
  final String WarningText;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage("assets/images/redcircleIcon.png"),
          height: 10,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            WarningText,
            style: const TextStyle(fontSize: 12),
          ),
        )
      ],
    );
  }
}

class InstructionWidget extends StatelessWidget {
  const InstructionWidget({
    super.key,
    required this.instructionIndex,
    required this.instructionDetails,
  });
  final String instructionIndex;
  final String instructionDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        //shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
      ),
      //color: Colors.red,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: Text(instructionIndex),
        ),
        title: Text(
          instructionDetails,
          style: const TextStyle(fontSize: 11),
        ),
      ),
    );
  }
}
