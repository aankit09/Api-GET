import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_api/model/album_list.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<AlbumModel> albumList = [];
  Future<List<AlbumModel>> getAlbumRecord() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
       albumList.add(AlbumModel.fromJson(i));
      }
      return albumList;
    } else {
      return albumList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getAlbumRecord(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('Loading');
                  }else{
                    return ListView.builder(
                          itemCount: albumList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              semanticContainer: true,
                              child: ListTile(
                                leading: Text(albumList[index].id.toString()),
                                title: Text(albumList[index].userId.toString()),
                                subtitle: Text(
                                  albumList[index].title.toString(),
                                ),
                              ),
                            );
                          });
                  }
                }),
          )
        ],
      ),
    );
  }
}
