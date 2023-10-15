import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/post_model.dart';

class ExampleOne extends StatefulWidget {
  const ExampleOne({super.key});

  @override
  State<ExampleOne> createState() => _ExampleOneState();
}

class _ExampleOneState extends State<ExampleOne> {
  List<PostModel> postList = [];

  Future<List<PostModel>> getPost() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Post Data'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPost(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Loading');
                  } else {
                    return ListView.builder(
                        itemCount: postList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            semanticContainer: true,
                            child: ListTile(
                              leading: Text(postList[index].id.toString()),
                              title: Text(postList[index].title),
                              subtitle: Text(
                                postList[index].userId.toString(),
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
