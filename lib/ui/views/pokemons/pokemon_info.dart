// ignore_for_file: camel_case_types, use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokegendra/data/models/pokemonInfo_model.dart';
import 'package:pokegendra/data/models/pokemon_model.dart';
import 'package:pokegendra/data/repository/pokemon_repository.dart';
import 'package:pokegendra/ui/widgets/default_image.dart';
import 'package:pokegendra/ui/widgets/text_utils.dart';
import 'package:pokegendra/utils/utils.dart';

class infoPokemon extends StatefulWidget {
  final PokemonModel? pokemon;
  // ignore: prefer_const_constructors_in_immutables
  infoPokemon({Key? key, required this.pokemon});

  @override
  _infoPokemonState createState() => _infoPokemonState();
}

class _infoPokemonState extends State<infoPokemon> {
  PokemonInfoModel? infoPokemon;
  bool isLoad = true;
  @override
  void initState() {
    super.initState();
    getInfoPokemon();
  }

  getInfoPokemon() async {
    PokemonRepository pokemonRepository = PokemonRepository();
    final response =
        await pokemonRepository.getPokemonInfo(widget.pokemon!.id.toString());
    print(response);
    setState(() {
      infoPokemon = response;
      isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  titleText(
                    widget.pokemon!.name.toString(),
                  ),
                  Center(
                    child: defaultImage(widget.pokemon!.imageUrl),
                  ),
                  Row(
                    children: [
                      defaultImage(widget.pokemon!.imageBack, width: 80),
                      defaultImage(widget.pokemon!.imageFrontShiny, width: 80),
                      defaultImage(widget.pokemon!.imageBackShiny, width: 80),
                      defaultImage(widget.pokemon!.imageUrl, width: 80),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: subtitleText('Acerca de'),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: doubleNormalText('Altura : ',
                        (infoPokemon!.height! / 10).toString() + ' m'),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: doubleNormalText(
                      'Peso : ',
                      (infoPokemon!.weight! / 10).toString() + ' kg',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: doubleNormalText(
                        'Puntos : ',
                        (infoPokemon!.experience!).toString() + ' pts',
                      )),
                ],
              ),
            ),
    );
  }
}
