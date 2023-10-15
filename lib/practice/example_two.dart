import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_api/model/photos_model.dart';

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<PhotoModel> photoList = [];

  Future<List<PhotoModel>> getPhotos() async {
    final resposne = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    var data = jsonDecode(resposne.body.toString());
    if (resposne.statusCode == 200) {
      for (Map i in data) {
        PhotoModel photoModel = PhotoModel(title: i['title'], url: i['url']);
        photoList.add(photoModel);
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Api'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context, AsyncSnapshot<List<PhotoModel>>snapshot) {
                  return ListView.builder(
                      itemCount: photoList.length,
                      itemBuilder: (context, index) {
                        return
                        ListTile(
                          leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data![index].url.toString()),),
                          title: Text(snapshot.data![index].title.toString(),style: TextStyle(color: Colors.black),),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}
