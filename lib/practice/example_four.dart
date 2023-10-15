import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_api/model/userModels.dart';

import '../util/ReusableRow.dart';

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  List<UsersModel> userList = [];
  Future<List<UsersModel>> getUserData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UsersModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
              future: getUserData(),
              builder: (context, AsyncSnapshot<List<UsersModel>> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              ReusableRow(
                                title: 'Name',
                                value: snapshot.data![index].name.toString(),
                              ),
                              ReusableRow(
                                title: 'UserName',
                                value:
                                    snapshot.data![index].username.toString(),
                              ),
                              ReusableRow(
                                title: 'Email',
                                value: snapshot.data![index].email.toString(),
                              ),
                              ReusableRow(
                                title: 'Address',
                                value: snapshot.data![index].address!.city
                                        .toString() +
                                    snapshot.data![index].address!.geo!.lat
                                        .toString(),
                              ),
                            ],
                          ),
                        );
                      });
                }
              }),
        )
      ],
    );
  }
}
