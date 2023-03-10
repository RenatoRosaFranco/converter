import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

final request = Uri(
    scheme: 'https',
    host: 'api.hgbrasil.com',
    path: '/finance',
    queryParameters: {
      'format': 'json',
      'key': 'b6a9c994'
   }
);

void main() async {
  http.Response response = await http.get(request);
  print(json.decode(response.body)['results']['currencies']['USD']);

  print(response.body);

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
