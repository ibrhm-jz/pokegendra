import 'package:flutter/cupertino.dart';
import 'package:pokegendra/constants/constants.dart';
import 'package:pokegendra/utils/utils.dart';

class PokemonModel {
  String? id;
  String? name;
  String? url;
  bool select = false;
  String? imagen;
  int? teamId;
  int? pokemonId;

  Color? get color => colorsPokemon[getRandom(colorsPokemon.length)];
  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  String get imageBack =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/$id.png";
  String get imageBackShiny =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/$id.png";
  String get imageFrontShiny =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/$id.png";
  PokemonModel(
      {this.name, this.url, this.id, this.imagen, this.teamId, this.pokemonId});
  PokemonModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    imagen =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  }
  Map<String, dynamic> toJson() => {};
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'teamId': teamId,
      'imagen':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/' +
              pokemonId.toString() +
              '.png',
      'pokemonId': pokemonId,
    };
  }
}
