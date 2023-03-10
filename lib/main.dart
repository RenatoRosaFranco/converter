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
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white
    ),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double dolar;
  late double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text(
          '\$ Conversor \$',
          style: TextStyle(
            color: Colors.black,
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
                final Map data = snapshot.data!;

                // dolar = data["results"]["currencies"]["USD"]["buy"];
                // euro = data["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      Icon(Icons.monetization_on, size: 150.0, color: Colors.amber),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Reais',
                          labelStyle: TextStyle(color: Colors.amber),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.amber
                            )
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.amber
                            )
                          ),
                          hintStyle: TextStyle(
                            color: Colors.amber
                          ),
                          prefixText: "R\$",
                        ),
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25.0
                        ),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Dólares',
                          labelStyle: TextStyle(color: Colors.amber),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.amber
                            )
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.amber
                            )
                          ),
                          prefixText: "US\$",
                          hintStyle: TextStyle(
                            color: Colors.amber
                          )
                        ),
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0
                        ),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Euros',
                          labelStyle: TextStyle(color: Colors.amber),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.amber
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.amber
                            )
                          ),
                          prefixText: "€",
                          hintStyle: TextStyle(
                            color: Colors.amber
                          )
                        ),
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0
                        ),
                      )
                    ],
                  ),
                );
              }
          }
        }),
    );
  }
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body)["results"]["currencies"]["USD"];
}


