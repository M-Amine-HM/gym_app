import 'package:flutter/material.dart';

// int a = 0;
// //List ab = List.generate(6, (index) => false);
// List<List<dynamic>> ggenerateListOfLists(
//     int numberOfLists, int lengthOfEachList, dynamic defaultValue) {
//   // Generate a list of lists
//   return List.generate(
//     numberOfLists,
//     (_) => List.generate(
//       lengthOfEachList,
//       (_) =>
//           defaultValue, // Here, you can specify the default value of each element in the inner list
//     ),
//   );
// }

late int nbrserr;
late List<List> sseriesCompletedChecked;

// List sseriesCompletedChecked = ggenerateListOfLists(
//   6,
//   1,
//   false,
// );

late List<List> ab;

class CheckedProvider extends ChangeNotifier {
  String userName;
  List seriesChecked;
  CheckedProvider(
      {this.userName =
          "name", //defaul value //watch access l doones //read : use the provider to use its function
      List<bool>? seriesChecked})
      : seriesChecked = seriesChecked ?? ab;
  void changeChecked(
      {required bool checked, required int i, required int j}) async {
    seriesChecked[i][j] = checked;

    //userName = newUserName;

    notifyListeners(); //the entire app unsderstand that the data has been changed
  }

  void updateSeriesChecked(List<List> newSeriesChecked) {
    seriesChecked = newSeriesChecked;
    notifyListeners(); // Notify listeners that the entire list has been replaced
  }
}
