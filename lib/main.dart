import 'package:flutter/material.dart';
import 'package:pokegendra/ui/views/default/default_home.dart';
import 'package:pokegendra/ui/views/pokemons/pokemon_list.dart';
import 'package:pokegendra/ui/views/teams/teams.dart';
import 'package:pokegendra/ui/views/teams/teams_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: PokemonList(),
      initialRoute: '/default',
      routes: {
        '/default': (BuildContext context) => DafaultHome(),
        '/home': (BuildContext context) => PokemonList(),
        '/teams': (BuildContext context) => Teams(),
      },
    );
  }
}
