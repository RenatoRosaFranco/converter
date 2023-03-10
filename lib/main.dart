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
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text(
          '\$ Conversor \$',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text(
                  'Carregando Dados...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25.0
                  ),
                ),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Erro ao Carregar Dados',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25.0
                    ),
                  ),
                );
              } else {
                return Container(
                  color: Colors.green,
                );
              }
          }
        }),
    );
  }
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body)['results']['currencies']['USD'];
}


