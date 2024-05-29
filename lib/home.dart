import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/core/Exercices.dart';
import 'package:gym_app/core/Rapport.dart';
//import 'package:gym_app/core/plan.dart';
import 'package:gym_app/core/plans.dart';
import 'package:gym_app/core/profile.dart';
import 'package:gym_app/model/userModel.dart';
//import 'package:gym_app/globals.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  Home({super.key, required this.oneUser});
  final User oneUser;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // int s = 0;
  // final List<String> _nomsScreen = [
  //   "Exercices",
  //   "Plan",
  //   "Rapport",
  //   "Profile",
  //   "Poitrine"
  // ];
  // final List<Widget> _screens = [
  //   const ExercicesScreen(),
  //   const PlanScreen(),
  //   const ProfileScreen(),
  //   const RapportScreen(),
  //   const BodyPartScreen(),
  //   const BodyPartDetailsScreen(),
  // ];
  int screenH = 0;

  //int screenS = 0;

  // @override
  // void initState() {
  //   screenS = s;
  //   super.initState();
  // }

  // @override
  // void setState(VoidCallback fn) {
  //   screenS = s;
  //   // TODO: implement setState
  //   super.setState(fn);
  // }

  // void screenChanger(int screen) {
  //   setState(() {
  //     screenS = screen;
  //     print("$screenS home");
  //   });
  // }

  // Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
  //   0: GlobalKey<NavigatorState>(),
  //   1: GlobalKey<NavigatorState>(),
  //   2: GlobalKey<NavigatorState>(),
  // };
  // int _selectedIndex = 0;
  // void onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
          border: null,
          //border: Border.symmetric(vertical: BorderSide(width: 2)),
          height: 52,
          backgroundColor: Colors.grey.shade200,
          activeColor: Colors.black,

          //iconSize: 15,
          items: [
            bottomNavBar("nav11", "nav11_filled", "Exercices"),
            bottomNavBar("nav22", "nav22_filled", "Plan"),
            bottomNavBar("nav3", "nav3_filled", "Rapport"),
            bottomNavBar("nav4", "nav4_filled", "Profile"),
          ]),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            {
              screenH = 0;
              return CupertinoTabView(
                builder: (context) {
                  return const CupertinoPageScaffold(child: ExercicesScreen());
                },
              );
            }
          case 1:
            {
              screenH = 1;
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(
                      child: PlansScreen(
                    theuser: widget.oneUser,
                  ));
                },
              );
            }
          case 2:
            {
              screenH = 2;
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(
                      child: RapportScreen(
                    theuser: widget.oneUser,
                  ));
                },
              );
            }
          case 3:
            {
              screenH = 3;
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(
                      child: ProfileScreen(
                    oneUser: widget.oneUser,
                  ));
                },
              );
            }
        }

        return Container(
          color: Colors.red,
        );
      },
    );
  }

  BottomNavigationBarItem bottomNavBar(unselectedIcon, selectedIcon, label) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image(
            image: AssetImage("assets/images/$unselectedIcon.png"),
            height: 25,
          ),
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.black),
          )
        ],
      ),
      activeIcon: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image(
            image: AssetImage("assets/images/$selectedIcon.png"),
            height: 25,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
            ),
          )
        ],
      ),
      //label: "Rapport",
    );
  }
}
  // buildNavigator() {
  //   return Navigator(
  //       key: navigatorKeys[_selectedIndex],
  //       onGenerateRoute: (RouteSettings settings) {
  //         return MaterialPageRoute(
  //             builder: (_) => _screens.elementAt(_selectedIndex));
  //       });
  // }



// SafeArea(
//         child: Scaffold(
//       appBar: AppBar(
//         // titleTextStyle:
//         //     TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//         title: Text(
//           _nomsScreen[screenH],
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: _screens[s],
//       // buildNavigator(),
//       bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           selectedFontSize: 13,
//           selectedItemColor: Colors.black,
//           unselectedFontSize: 13,
//           unselectedItemColor: Colors.black,
//           currentIndex: screenH,
//           onTap: (value) {
//             screenChanger(value);
//             screenH = value;
//             //onItemTapped(value);
//           },
//           backgroundColor: Colors.white,
//           items: [
//             BottomNavigationBarItem(
//               //backgroundColor: Colors.black,
//               icon: Image(
//                 image: screenH == 0
//                     ? const AssetImage("assets/images/nav1.png")
//                     : const AssetImage("assets/images/nav1.png"),
//                 height: 25,
//               ),
//               label: "Exercices",
//             ),
//             BottomNavigationBarItem(
//               //backgroundColor: Colors.red,
//               icon: Image(
//                 image: screenH == 1
//                     ? const AssetImage("assets/images/nav2.png")
//                     : const AssetImage("assets/images/nav2.png"),
//                 height: 25,
//               ),
//               label: "Plan ",
//             ),
//             BottomNavigationBarItem(
//                 icon: Image(
//                   image: screenH == 2
//                       ? const AssetImage("assets/images/nav3.png")
//                       : const AssetImage("assets/images/nav3.png"),
//                   height: 25,
//                 ),
//                 label: "Rapport"),
//             BottomNavigationBarItem(
//                 icon: Image(
//                   image: screenH == 3
//                       ? const AssetImage("assets/images/nav4.png")
//                       : const AssetImage("assets/images/nav4.png"),
//                   height: 25,
//                 ),
//                 label: "Profile")
//           ]),
//     ));
