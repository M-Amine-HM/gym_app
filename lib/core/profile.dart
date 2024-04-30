import 'package:flutter/material.dart';
import 'package:gym_app/auth/firstPage.dart';
import 'package:gym_app/core/community.dart';
import 'package:gym_app/core/updateProfile.dart';
import 'package:gym_app/home.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:gym_app/services/Api.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.oneUser}) : super(key: key);
  final User oneUser;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  List<User> userdata = [];
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
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profil", style: Theme.of(context).textTheme.headline4),
      ),
      body: SingleChildScrollView(
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
                        child: const Image(
                            image: AssetImage("assets/images/AminePhoto.jpg"))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xffffe501)),
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
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
                      theUser = userdata[0];

                      return Column(
                        children: [
                          Text(theUser.name,
                              style: Theme.of(context).textTheme.headline4),
                          //email field
                          Text(theUser.email,
                              style: Theme.of(context).textTheme.bodyText2),
                          //nameAndemail(),
                          //email(),
                          const SizedBox(height: 10),
                          Text(
                              "sexe: ${theUser.sexe} height: ${(theUser.height).toString()} weight: ${(theUser.phoneNumber).toString()} "),
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
                                  backgroundColor: Color(0xffffe501),
                                  side: BorderSide.none,
                                  shape: const StadiumBorder()),
                              child: const Text("Modifier Profile",
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                        ],
                      );
                    }
                  }),

              //name field

              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Calendrier",
                  icon: LineAwesomeIcons.calendar,
                  onPress: () {}),
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
                  title: "Statistiques",
                  icon: LineAwesomeIcons.chalkboard,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Mesures",
                  icon: LineAwesomeIcons.horizontal_sliders,
                  onPress: () {}),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Informations",
                  icon: LineAwesomeIcons.info,
                  onPress: () {}),
              ProfileMenuWidget(
                title: "Logout",
                icon: LineAwesomeIcons.alternate_sign_out,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
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
            theUser = userdata[0];

            return Text(userdata[0].email.toString());
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
                Text((userdata[0].name),
                    style: Theme.of(context).textTheme.headline4),
                //email field
                Text("Email: ${(userdata[0].email).toString()}",
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
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? Color(0xffffe501) : Colors.black;

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
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
