import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HttpTest extends StatefulWidget {
  const HttpTest({super.key});

  @override
  State<HttpTest> createState() => _HttpTestState();
}

class _HttpTestState extends State<HttpTest> {
  ScrollController? scrollController;
  bool loading = true;
  List list = [];
  getData() async {
    var response =
        await get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    var repoBody = jsonDecode(response.body);
    list.addAll(repoBody);
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController!.addListener(() {
      print(scrollController!.offset);
    });
    getData();
    super.initState();
  }

  @override
  void dispose() {
    scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Test Api"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: PostSearchDelegate(list),
              );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.deepPurple,
              size: 30,
            ),
          ),
          PopupMenuButton(
              iconSize: 20,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.deepPurple,
                size: 30,
              ),
              color: Colors.white,
              itemBuilder: (context) => [
                    const PopupMenuItem(
                      child: Text("New group"),
                    ),
                    const PopupMenuItem(
                      child: Text("New chats"),
                    ),
                    const PopupMenuItem(
                      child: Text("Settings"),
                    )
                  ])
        ],
      ),
      body: Column(
        children: [
          MaterialButton(
            color: Colors.deepPurple,
            textColor: Colors.white,
            padding: const EdgeInsets.all(10),
            minWidth: double.infinity,
            onPressed: () {
              scrollController!.animateTo(
                scrollController!.position.maxScrollExtent, // => 428571428572
                duration: const Duration(seconds: 1),
                curve: Curves.easeIn,
              );
            },
            child: const Icon(Icons.arrow_downward, size: 30),
          ),
          loading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(list[index]['id'].toString()),
                          ),
                          title: Text(
                            list[index]['title'].toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.deepPurple,
                            ),
                          ),
                          subtitle: Text(list[index]['body'].toString()),
                        ),
                      );
                    },
                  ),
                ),
          MaterialButton(
            minWidth: double.infinity,
            color: Colors.deepPurple,
            textColor: Colors.white,
            padding: const EdgeInsets.all(10),
            onPressed: () {
              scrollController!.animateTo(
                scrollController!.position.minScrollExtent, // => 0
                duration: const Duration(seconds: 1),
                curve: Curves.easeIn,
              );
            },
            child: const Icon(
              Icons.arrow_upward,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class PostSearchDelegate extends SearchDelegate {
  final List<dynamic> posts;

  PostSearchDelegate(this.posts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.red),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.blue),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = posts
        .where((item) =>
            item['title'].toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            " Title: ${results[index]['title']}",
            style: const TextStyle(fontSize: 20, color: Colors.deepPurple),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filterSuggestions = posts
        .where((item) =>
            item['title'].toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filterSuggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filterSuggestions[index]['title']),
          onTap: () {
            query = filterSuggestions[index]['title'];
            showResults(context);
          },
        );
      },
    );
  }
}
