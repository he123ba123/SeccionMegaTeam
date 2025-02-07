import 'package:flutter/material.dart';

class SearchTest extends StatefulWidget {
  const SearchTest({super.key});

  @override
  State<SearchTest> createState() => _SearchTestState();
}

class _SearchTestState extends State<SearchTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Test"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchTestDelegate());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}

class SearchTestDelegate extends SearchDelegate {
  List cities = [
    'cairo',
    'mansoura',
    'damitta',
    'alexanderia',
    'aswan',
    'luxor'
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      // Widget
      IconButton(
        icon: const Icon(
          Icons.close,
          color: Colors.red,
        ),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // return Widget
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.blue,
      ),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Center(
          child: Column(
        children: [
          SizedBox(
              child: Text(
            "Result : $query",
            style: const TextStyle(
                color: Colors.deepPurple,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          )),
        ],
      )),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List filternames =
        cities.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
        itemCount: query == "" ? cities.length : filternames.length,
        itemBuilder: (context, i) {
          return InkWell(
              onTap: () {
                showResults(context);
              },
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: query == ""
                      ? Text(
                          "${cities[i]}",
                          style: const TextStyle(fontSize: 20),
                        )
                      : Text(
                          "${filternames[i]}",
                          style: const TextStyle(fontSize: 20),
                        )));
        });
  }
}
