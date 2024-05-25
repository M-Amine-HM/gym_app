import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/auth/firstPage.dart';
import 'package:gym_app/core/community.dart';
import 'package:gym_app/core/salleDeSport.dart';
import 'package:gym_app/core/updateProfile.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:gym_app/services/Api.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

//TODO: l page m9asma 3ala zoz l backgroud gris , w kl botton l icon mta3ha mlawen
// 7ata modifier Profile
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.oneUser}) : super(key: key);
  final User oneUser;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  List? userdata = [];
  User theUser = User();

  // @override
  // void initState() async{
  //   super.initState();

  //   userdata= await Api.getUserByEmail((widget.oneUser.email));
  //   theUser=userdata[0];
  // }

//dynamic getTheUser= Api.getUserByEmail(widget.oneUser.email);

  // List<User> getTheUserdata() {
  //   dynamic getTheUser() {
  //     return Api.getUserByEmail(widget.oneUser.email);
  //   }

  //   return getTheUser();
  // }

  //AsyncSnapshot<dynamic> i=AsyncSnapshot.nothing();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        centerTitle: true,
        title: Text(
          "Profil",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: widget.oneUser.image == ""
                            ? Image.asset("assets/images/noPerson.png")
                            : Image.network(
                                "${Api.baseUrl}profile/${widget.oneUser.image}")
                        // const Image(
                        //   image: AssetImage("assets/images/AminePhoto.jpg"),
                        // ),
                        ),
                  ),
                  // Positioned(
                  //   bottom: 0,
                  //   right: 0,
                  //   child: Container(
                  //     width: 35,
                  //     height: 35,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(100),
                  //         color: Color(0xffffe501)),
                  //     child: const Icon(
                  //       LineAwesomeIcons.alternate_pencil,
                  //       color: Colors.black,
                  //       size: 20,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                  future: Api.getUserByEmail((widget.oneUser.email).toString()),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      userdata = snapshot.data;
                      theUser = userdata![0];

                      return Column(
                        children: [
                          Text(
                            theUser.name,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                          //style: Theme.of(context).textTheme.headline4),
                          //email field
                          Text(
                            theUser.email,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          //style: Theme.of(context).textTheme.bodyText2),
                          //nameAndemail(),
                          //email(),
                          const SizedBox(height: 10),
                          // Text(
                          //     "sexe: ${theUser.sexe} height: ${(theUser.height).toString()} weight: ${(theUser.phoneNumber).toString()} "),
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                                // userdata = Api.getUserByEmail(widget.oneUser.email),

                                //print(userdata[0]),
                                setState(() {});
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateProfileScreen(
                                      theUser: theUser,
                                      userEmail: widget.oneUser.email,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo[600],
                                  side: BorderSide.none,
                                  shape: const StadiumBorder()),
                              child: const Text("Modifier Profile",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ],
                      );
                    }
                  }),

              //name field

              const SizedBox(height: 30),
              // const Divider(),
              //const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  //shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),

                    // const Divider(
                    //   height: 0,
                    //   thickness: 0.5,
                    //   indent: 40,
                    //   endIndent: 40,
                    // ),
                    ProfileMenuWidget(
                        title: "Communité",
                        icon: LineAwesomeIcons.user_friends,
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => coummunityScreen()),
                          );
                        }),
                    ProfileMenuWidget(
                        title: "Salle de Sport",
                        icon: LineAwesomeIcons.dumbbell,
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => salleDeSportScreen()));
                        }),
                    // const Divider(
                    //   height: 0,
                    //   thickness: 0.5,
                    //   indent: 40,
                    //   endIndent: 40,
                    // ),

                    // const Divider(
                    //   height: 0,
                    //   thickness: 0.5,
                    //   indent: 40,
                    //   endIndent: 40,
                    // ),

                    // ProfileMenuWidget(
                    //     title: "Mesures",
                    //     icon: LineAwesomeIcons.horizontal_sliders,
                    //     onPress: () {}),
                    ProfileMenuWidget(
                        title: "Informations sur l'App",
                        icon: LineAwesomeIcons.info,
                        onPress: () {}),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              //const Divider(),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  //shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),

                    // const Divider(
                    //   height: 0,
                    //   thickness: 0.5,
                    //   indent: 40,
                    //   endIndent: 40,
                    // ),
                    ProfileMenuWidget(
                      title: "Logout",
                      icon: LineAwesomeIcons.alternate_sign_out,
                      textColor: Colors.red,
                      fontWeight: FontWeight.w500,
                      endIcon: false,
                      onPress: () {
                        //TODO: na9esa toast bch y9lu mathabet t7eb to5rej
                        Navigator.of(context, rootNavigator: true)
                            .pushAndRemoveUntil(
                                CupertinoPageRoute(
                                    builder: (context) => FirstPage()),
                                (route) => false);
                        //TODO: logout take the user to first page
                        // User user = User();
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => FirstPage(

                        //             )),
                        //     (route) => false);

                        //Navigator.pop(context);
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstPage()));
                      },
                    ),
                    ProfileMenuWidget(
                        title: "Supprimer le Compte",
                        icon: LineAwesomeIcons.alternate_trash_1,
                        textColor: Colors.red,
                        fontWeight: FontWeight.w500,
                        endIcon: false,
                        onPress: () {}),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<dynamic> email() {
    return FutureBuilder(
        future: Api.getUserByEmail((widget.oneUser.email).toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            userdata = snapshot.data;
            theUser = userdata![0];

            return Text(userdata![0].email.toString());
          }
        });
  }

  FutureBuilder<dynamic> nameAndemail() {
    return FutureBuilder(
        future: Api.getUserByEmail((widget.oneUser.email).toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            userdata = snapshot.data;

            return Column(
              children: [
                Text(
                  (userdata![0].name),
                ),
                //email field
                Text("Email: ${(userdata![0].name).toString()}",
                    style: Theme.of(context).textTheme.bodyText2),
              ],
            );
          }
        });
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
    this.fontWeight,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    // var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    //var iconColor = isDark ? Color(0xffffe501) : Colors.black;
    var iconColor = Colors.black;
    return ListTile(
      //contentPadding: EdgeInsets.only(bottom: 5, left: 20, right: 20, top: 5),
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: textColor, fontWeight: fontWeight),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(LineAwesomeIcons.angle_right,
                  size: 18.0, color: Colors.grey))
          : null,
    );
  }
}
