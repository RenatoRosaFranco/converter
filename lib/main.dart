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
    home: const Home(),
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

  final realController  = TextEditingController();
  final dolarController = TextEditingController();
  final euroController  = TextEditingController();

  void _realChanged(String text) {
    print(text);
  }

  void _dolarChanged(String text) {
    print(text);
  }

  void _euroChanged(String text) {
    print(text);
  }

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
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                          Icons.monetization_on,
                          size: 150.0, color:
                          Colors.amber
                      ),
                      buildTextField('Reais', 'R\$', realController, _realChanged),
                      const Divider(),
                      buildTextField('Dólares', 'US\$', dolarController, _dolarChanged),
                      const Divider(),
                      buildTextField('Euros', '€', euroController, _euroChanged)
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

Widget buildTextField(String label, String prefix, TextEditingController controller, action) {
  return TextField(
    controller: controller,
    onChanged: action,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.amber),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.amber
            )
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.amber
            )
        ),
        prefixText: prefix,
        hintStyle: const TextStyle(
            color: Colors.amber
        )
    ),
    style: const TextStyle(
        color: Colors.amber,
        fontSize: 25.0
    ),
  );
}