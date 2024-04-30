import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/core/model/movie_model.dart';

class coummunityScreen1 extends StatefulWidget {
  const coummunityScreen1({super.key});

  @override
  State<coummunityScreen1> createState() => _coummunityScreenState();
}

class _coummunityScreenState extends State<coummunityScreen1> {
  //list of movies
  static List<MovieModel> main_movies_list = [
    MovieModel("amine", 1994, 9.3,
        "https://m.media-amazon.com/images/I/71MEh-s3p7L.__AC_SX300_SY300_QL70_FMwebp_.jpg"),
    MovieModel("b", 1994, 9.3,
        "https://m.media-amazon.com/images/I/71MEh-s3p7L.__AC_SX300_SY300_QL70_FMwebp_.jpg"),
    MovieModel("aminehm", 1994, 9.3,
        "https://m.media-amazon.com/images/I/71MEh-s3p7L.__AC_SX300_SY300_QL70_FMwebp_.jpg"),
    MovieModel("medamine", 1994, 9.3,
        "https://m.media-amazon.com/images/I/71MEh-s3p7L.__AC_SX300_SY300_QL70_FMwebp_.jpg"),
    MovieModel("mohamedamine", 1994, 9.3,
        "https://m.media-amazon.com/images/I/71MEh-s3p7L.__AC_SX300_SY300_QL70_FMwebp_.jpg"),
    MovieModel("aminos", 1994, 9.3,
        "https://m.media-amazon.com/images/I/71MEh-s3p7L.__AC_SX300_SY300_QL70_FMwebp_.jpg"),
    MovieModel("moahmed", 1994, 9.3,
        "https://m.media-amazon.com/images/I/71MEh-s3p7L.__AC_SX300_SY300_QL70_FMwebp_.jpg"),
  ];
//list we are going to display and filter
  List<MovieModel> display_list = List.from(main_movies_list);
  void updateList(String value) {
    // this is the function tjat will filter our list
    //serach function
    setState(() {
      display_list = main_movies_list
          .where((element) =>
              element.movie_title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Community",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search for a user",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) => updateList(value),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[400],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  hintText: "eg : Amine",
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.grey.shade900),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              //text in case there is no result
              child: display_list.length == 0
                  ? Center(
                      child: Text(
                        "No Result found",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: display_list.length,
                      itemBuilder: (context, index) => ListTile(
                        contentPadding: EdgeInsets.all(8),
                        title: Text(
                          display_list[index].movie_title!,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${display_list[index].movie_release_year!}",
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        trailing: Text(
                          "${display_list[index].rating}",
                          style: TextStyle(color: Colors.amber),
                        ),
                        leading:
                            Image(image: AssetImage("assets/images/abdos.jpg")),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Apple',
    'Banana',
    'Pear',
    'Watermelons',
    'Oranges',
    'Blueberries',
    'Strawberries',
    'Raspberries',
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
