import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'model/user_data_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Call Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'API Call Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<UserData> listOfUsers = [];

  Future<List<UserData>> getDataFromAPI() async {
    Response response =
        await Dio().get("https://jsonplaceholder.typicode.com/posts");
    List<UserData> usersList = userDataFromJson(jsonEncode(response.data));
    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: listOfUsers.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(listOfUsers[index].title ?? ""),
          subtitle: Text(listOfUsers[index].body ?? ""),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          listOfUsers = await getDataFromAPI();
          setState(() {});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.download),
      ),
    );
  }
}
