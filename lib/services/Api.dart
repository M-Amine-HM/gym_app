//all api methods

// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

//import 'package:crudtest/model/product_model.dart';
import 'package:gym_app/model/exerciseModel.dart';
import 'package:gym_app/model/planModel.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:http/http.dart' as http;

class Api {
  static const String ipAdress = "192.168.1.12";
  static const baseUrl = "http://$ipAdress:2000/api/";

  //static String ipAdress = "192.168.81.218";
  static addUser(Map pdata) async {
    print(pdata);
    //ali mawjouda fl post fl nodeJS
    var url = Uri.parse(baseUrl + "add_user");
    try {
      final res = await http.post(url, body: pdata);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
        //
      } else {
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }

//add plan
  static addPlan(Map<String, dynamic> planData) async {
    // Map<dynamic, dynamic> planData = plan.toMap();

    // Print the data (optional)
    print(planData);
    //ali mawjouda fl post fl nodeJS
    var url = Uri.parse(baseUrl + "add_plan");
    try {
      //var data = jsonEncode(planData);
      //print(data);
      Map<String, dynamic> a = {
        'planName': "hasta el final",
        'nbrExercises': "exercises nbrs",
        'exercises': "a bb cc",
        'nbrsSeries': "exes",
      };
      final res = await http.post(url, body: planData);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
        //
      } else {
        //
      }
    } catch (e) {
      print(e.toString() + " erreur add plan function ");
    }
  }

  //add plan
  static addPlanCompleted(Map<String, String> planData) async {
    // Map<dynamic, dynamic> planData = plan.toMap();

    // Print the data (optional)
    print(planData);
    //ali mawjouda fl post fl nodeJS
    var url = Uri.parse(baseUrl + "addCompletedPlan");
    try {
      //var data = jsonEncode(planData);
      //print(data);
      // Map<String, dynamic> a = {
      //   'planName': "hasta el final",
      //   'nbrExercises': "exercises nbrs",
      //   'exercises': "a bb cc",
      //   'nbrsSeries': "exes",
      // };
      final res = await http.post(url, body: planData);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
        //
      } else {
        //
      }
    } catch (e) {
      print(e.toString() + " erreur add planCompleted function ");
    }
  }

  static deletePlan(id) async {
    //List<Product> products = [];
    //print(pdata);
    //ali mawjouda fl get fl nodeJS
    var url = Uri.parse(baseUrl + "deletePlan/$id");
    try {
      final res = await http.delete(url);

      if (res.statusCode == 200) {
        //data ali bch tji ml serveur
        var data = jsonDecode(res.body.toString());
        print(data);
        //n7b ali donnne bch tjini ml serer n7otha fi lista bch najm naffichaha fl app

        //tretruni l lista bch nafffichah

        //
      } else {
        print("failed delete plan");
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getPlanByName(name) async {
    //List<Product> products = [];
    List<Plan> plan = [];
    //print(pdata);
    //ali mawjouda fl get fl nodeJS
    var url = Uri.parse(baseUrl + "get_plan_byName/$name");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        //data ali bch tji ml serveur
        var data = jsonDecode(res.body.toString());
        //print(data);
        //n7b ali donnne bch tjini ml serer n7otha fi lista bch najm naffichaha fl app
        data['plan'].forEach(
          (value) => {
            plan.add(
              Plan(
                id: value['_id'],
                planName: value['planName'],
                nbrExercises: value['nbrExercises'],
                exercises: value['exercises'],
                nbrsSeries: value['nbrsSeries'],
              ),
              //id: value['id'].toString()),
            ),
          },
        );
        print(plan);
        //tretruni l lista bch nafffichah
        return plan;
        //
      } else {
        print("erreur lors la fonctions getByPlanName");
        return [];
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static updatePlan(id, body) async {
    //ali mawjouda fl get fl nodeJS
    var url = Uri.parse(baseUrl + "updatePlan/$id");
    try {
      final res = await http.put(url, body: body);
      List<Plan> plan = [];
      Plan? plan1;
      if (res.statusCode == 200) {
        //data ali bch tji ml serveur
        var data = jsonDecode(res.body.toString());
        //print(data);
        //n7b ali donnne bch tjini ml serer n7otha fi lista bch najm naffichaha fl app
        // plan1!.id = data['plan']._id;
        // plan1.planName = data['plan'].planName;
        // plan1.nbrExercises = data['plan'].nbrExercises;
        // plan1.exercises = data['plan'].exercises;
        // plan1.nbrsSeries = data['plan'].nbrsSeries;
        data['plan'].forEach(
          (value) => {
            plan.add(
              Plan(
                id: value['_id'],
                planName: value['planName'],
                nbrExercises: value['nbrExercises'],
                exercises: value['exercises'],
                nbrsSeries: value['nbrsSeries'],
              ),
              //id: value['id'].toString()),
            ),
          },
        );
        print(plan1);

        //tretruni l lista bch nafffichah
        return plan[0];
        //
      } else {
        print("erreur lors la fonctions getByPlanName");
        return [];
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getPlans() async {
    //List<Product> products = [];
    List<Plan> plan = [];
    //print(pdata);
    //ali mawjouda fl get fl nodeJS
    var url = Uri.parse(baseUrl + "get_plans");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        //data ali bch tji ml serveur
        var data = jsonDecode(res.body.toString());
        //print(data);
        //n7b ali donnne bch tjini ml serer n7otha fi lista bch najm naffichaha fl app
        data['plans'].forEach(
          (value) => {
            plan.add(
              Plan(
                id: value['_id'],
                planName: value['planName'],
                nbrExercises: value['nbrExercises'],
                exercises: value['exercises'],
                nbrsSeries: value['nbrsSeries'],
              ),
              //id: value['id'].toString()),
            ),
          },
        );
        print(plan);
        //tretruni l lista bch nafffichah
        return plan;
        //
      } else {
        print("erreur lors la fonctions getPlan");
        return [];
        //
      }
    } catch (e) {
      print(e.toString() + "erreur lors la fonctions getPlan");
    }
  }

  static addImage(File image) async {
    var imageURL;
    // print(pdata);
    //ali mawjouda fl post fl nodeJS
    var url = Uri.parse(baseUrl + "uploadImage");
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('profile', image.path));

    try {
      // final res = await http.post(url, body: [image]);
      var res = await request.send();
      if (res.statusCode == 200) {
        var responseData = await res.stream.bytesToString();
        var data = jsonDecode(responseData);
        print(data);
        imageURL = data["profile_url_mobile"];
        return imageURL;

        // var data = jsonDecode(res.body.toString());
        // print(data);
        // imageURL = data["profile_url_mobile"];
        // return imageURL;
        //
      } else {
        return "error";
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getUsers() async {
    //List<Product> products = [];
    List<User> users = [];
    //print(pdata);
    //ali mawjouda fl get fl nodeJS
    var url = Uri.parse(baseUrl + "get_users");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        //data ali bch tji ml serveur
        var data = jsonDecode(res.body.toString());
        //print(data);
        //n7b ali donnne bch tjini ml serer n7otha fi lista bch najm naffichaha fl app
        data['users'].forEach(
          (value) => {
            users.add(
              User(
                  name: value['name'],
                  email: value['email'],
                  password: value['password'],
                  sexe: value['sexe'],
                  height: value['height'],
                  weight: value['weight'],
                  id: value['_id'],
                  phoneNumber: value['phoneNumber'],
                  adress: value['adress'],
                  image: value['image']),
              //id: value['id'].toString()),
            ),
          },
        );
        //tretruni l lista bch nafffichah
        return users;
        //
      } else {
        return [];
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getUserById(id) async {
    //List<Product> products = [];
    List<User> user = [];
    //print(pdata);
    //ali mawjouda fl get fl nodeJS
    var url = Uri.parse(baseUrl + "get_user/$id");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        //data ali bch tji ml serveur
        var data = jsonDecode(res.body.toString());
        //print(data);
        //n7b ali donnne bch tjini ml serer n7otha fi lista bch najm naffichaha fl app
        data['user'].forEach(
          (value) => {
            user.add(
              User(
                  name: value['name'],
                  email: value['email'],
                  password: value['password'],
                  sexe: value['sexe'],
                  height: value['height'],
                  weight: (value['weight']),
                  id: value['_id'],
                  phoneNumber: value['phoneNumber'],
                  adress: value['adress'],
                  image: value['image']),
              //id: value['id'].toString()),
            ),
          },
        );
        //tretruni l lista bch nafffichah
        return user;
        //
      } else {
        return [];
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getUserByEmail(email) async {
    //List<Product> products = [];
    List<User> user = [];
    //print(pdata);
    //ali mawjouda fl get fl nodeJS
    var url = Uri.parse(baseUrl + "get_user_byEmail/$email");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        //data ali bch tji ml serveur
        var data = jsonDecode(res.body.toString());
        //print(data);
        //n7b ali donnne bch tjini ml serer n7otha fi lista bch najm naffichaha fl app
        data['user'].forEach(
          (value) => {
            user.add(
              User(
                  name: value['name'],
                  email: value['email'],
                  password: value['password'],
                  sexe: value['sexe'],
                  height: value['height'],
                  weight: value['weight'],
                  id: value['_id'],
                  phoneNumber: value['phoneNumber'],
                  adress: value['adress'],
                  image: value['image']),
              //id: value['id'].toString()),
            ),
          },
        );
        print(user);
        //tretruni l lista bch nafffichah
        return user;
        //
      } else {
        print("erreur lors la fonctions getByEmail");
        return [];
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getExercisesByBodyPart(bodyPart) async {
    //List<Product> products = [];
    List<Exercise> exercises = [];
    //print(pdata);
    //ali mawjouda fl get fl nodeJS
    var url = Uri.parse(baseUrl + "getExercisesByBodyPart/$bodyPart");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        //data ali bch tji ml serveur
        var data = jsonDecode(res.body.toString());
        //print(data);
        //n7b ali donnne bch tjini ml serer n7otha fi lista bch najm naffichaha fl app
        data['exercises'].forEach(
          (value) => {
            exercises.add(
              Exercise(
                bodyPart: value['bodyPart'],
                name: value['name'],
                image: value['image'],
                video: value['video'],
                description: value['description'],
                instructions: value['instructions'],
                id: value['_id'],
                warnings: value['warnings'],
              ),
              //id: value['id'].toString()),
            ),
          },
        );
        print(exercises);
        //tretruni l lista bch nafffichah
        return exercises;
        //
      } else {
        print("erreur lors la fonctions getExercisesBybodyPart");
        return [];
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getExercisesByPlan(planName) async {
    //List<Product> products = [];
    List<Exercise> exercises = [];
    //print(pdata);
    //ali mawjouda fl get fl nodeJS
    var url = Uri.parse(baseUrl + "getExercisesByPlan/$planName");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        //data ali bch tji ml serveur
        var data = jsonDecode(res.body.toString());
        //print(data);
        //n7b ali donnne bch tjini ml serer n7otha fi lista bch najm naffichaha fl app
        data['exercises'].forEach(
          (value) => {
            exercises.add(
              Exercise(
                bodyPart: value['bodyPart'],
                name: value['name'],
                image: value['image'],
                video: value['video'],
                description: value['description'],
                instructions: value['instructions'],
                id: value['_id'],
                warnings: value['warnings'],
              ),
              //id: value['id'].toString()),
            ),
          },
        );
        print(exercises);
        //tretruni l lista bch nafffichah
        return exercises;
        //
      } else {
        print("erreur lors la fonctions getExercisesBybodyPart");
        return [];
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getExercisesByName(name) async {
    //List<Product> products = [];
    List<Exercise> exercises = [];
    //print(pdata);
    //ali mawjouda fl get fl nodeJS
    var url = Uri.parse(baseUrl + "getExercisesByName/$name");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        //data ali bch tji ml serveur
        var data = jsonDecode(res.body.toString());
        //print(data);
        //n7b ali donnne bch tjini ml serer n7otha fi lista bch najm naffichaha fl app
        data['exercises'].forEach(
          (value) => {
            exercises.add(
              Exercise(
                bodyPart: value['bodyPart'],
                name: value['name'],
                image: value['image'],
                video: value['video'],
                description: value['description'],
                instructions: value['instructions'],
                id: value['_id'],
                warnings: value['warnings'],
              ),
              //id: value['id'].toString()),
            ),
          },
        );
        print(exercises);
        //tretruni l lista bch nafffichah
        return exercises;
        //
      } else {
        print("erreur lors la fonctions getExercisesBybodyPart");
        return [];
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getExercises() async {
    //List<Product> products = [];
    List<Exercise> exercises = [];
    //print(pdata);
    //ali mawjouda fl get fl nodeJS
    var url = Uri.parse(baseUrl + "get_exercises");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        //data ali bch tji ml serveur
        var data = jsonDecode(res.body.toString());
        //print(data);
        //n7b ali donnne bch tjini ml serer n7otha fi lista bch najm naffichaha fl app
        data['exercises'].forEach(
          (value) => {
            exercises.add(
              Exercise(
                bodyPart: value['bodyPart'],
                name: value['name'],
                image: value['image'],
                video: value['video'],
                description: value['description'],
                instructions: value['instructions'],
                id: value['_id'],
                warnings: value['warnings'],
              ),
              //id: value['id'].toString()),
            ),
          },
        );
        print(exercises);
        //tretruni l lista bch nafffichah
        return exercises;
        //
      } else {
        print("erreur lors la fonctions getExercises");
        return [];
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static getUsersByNames(name) async {
    //List<Product> products = [];
    List<User> user = [];
    //print(pdata);
    //ali mawjouda fl get fl nodeJS
    var url = Uri.parse(baseUrl + "get_users_byName/$name");
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        //data ali bch tji ml serveur
        var data = jsonDecode(res.body.toString());
        //print(data);
        //n7b ali donnne bch tjini ml serer n7otha fi lista bch najm naffichaha fl app
        data['users'].forEach(
          (value) => {
            user.add(
              User(
                  name: value['name'],
                  email: value['email'],
                  password: value['password'],
                  sexe: value['sexe'],
                  height: value['height'],
                  weight: value['weight'],
                  id: value['_id'],
                  phoneNumber: value['phoneNumber'],
                  adress: value['adress'],
                  image: value['image']),
              //id: value['id'].toString()),
            ),
          },
        );
        print(user);
        //tretruni l lista bch nafffichah
        return user;
        //
      } else {
        print("erreur lors la fonctions getByName");
        return [];
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static updateUser(id, body) async {
    //List<Product> products = [];
    //print(pdata);
    //ali mawjouda fl get fl nodeJS
    var url = Uri.parse(baseUrl + "update/$id");
    try {
      final res = await http.put(url, body: body);

      if (res.statusCode == 200) {
        //data ali bch tji ml serveur
        var data = jsonDecode(res.body.toString());
        print(data);

        //
      } else {
        print("failed updated");
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static deleteUser(id) async {
    //List<Product> products = [];
    //print(pdata);
    //ali mawjouda fl get fl nodeJS
    var url = Uri.parse(baseUrl + "deleteUser/$id");
    try {
      final res = await http.delete(url);

      if (res.statusCode == 200) {
        //data ali bch tji ml serveur
        var data = jsonDecode(res.body.toString());
        print(data);
        //n7b ali donnne bch tjini ml serer n7otha fi lista bch najm naffichaha fl app

        //tretruni l lista bch nafffichah

        //
      } else {
        print("failed delete");
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
