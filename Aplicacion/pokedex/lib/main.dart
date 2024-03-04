import 'package:flutter/material.dart';
import 'package:pokedex/Views/details_view.dart';
import 'package:pokedex/Views/principal_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: PrincipalView(),
      // home: DetailsView(
      //   nombre: 'Gengar',
      //   numero: '094',
      //   imagen: 'http://www.serebii.net/pokemongo/pokemon/094.png',
      //   tipo: 'Ghost',
      //   altura: '1.5 m',
      //   peso: '40.5 kg',
      //   color: Colors.green,
      // ),
    );
  }
}
