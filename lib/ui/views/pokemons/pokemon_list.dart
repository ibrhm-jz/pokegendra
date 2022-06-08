// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pokegendra/data/db/pokemon_db_repository.dart';
import 'package:pokegendra/data/db/teams_db_repository.dart';
import 'package:pokegendra/data/models/pokemon_model.dart';
import 'package:pokegendra/data/models/team_model.dart';
import 'package:pokegendra/data/repository/pokemon_repository.dart';
import 'package:pokegendra/ui/views/pokemons/pokemon_info.dart';
import 'package:pokegendra/ui/widgets/default_toast.dart';
import 'package:pokegendra/ui/widgets/dialog_add_team.dart';
import 'package:pokegendra/utils/utils.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PokemonList extends StatefulWidget {
  PokemonList({Key? key});

  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  List<PokemonModel> pokemones = [];
  List<PokemonModel> pokemoneAdd = [];
  bool isSelected = false;
  IconData IconSelect = Icons.add;
  final TextEditingController nameTeamController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    getPokemons();
  }

  getPokemons() async {
    PokemonRepository pokemonRepository = PokemonRepository();
    final response = await pokemonRepository.getPokemons();
    setState(() {
      pokemones = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Pokedex'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/teams');
                },
                icon: const Icon(Icons.ballot))
          ],
        ),
        backgroundColor: Colors.grey[100],
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: pokemones.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          if (!isSelected) {
                            showMaterialModalBottomSheet(
                              context: context,
                              enableDrag: false,
                              isDismissible: true,
                              builder: (context) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 200,
                                child: infoPokemon(
                                  pokemon: pokemones[i],
                                ),
                              ),
                            );
                          } else {
                            setState(() {
                              var exist = isDataExist(pokemones[i]);
                              if (!exist) {
                                if (pokemoneAdd.length > 5) {
                                  showToast(
                                      'Solo se pueden agregar 6 pokemones');
                                } else {
                                  pokemoneAdd.add(pokemones[i]);
                                }
                              } else {
                                pokemoneAdd.remove(pokemones[i]);
                              }
                            });
                          }
                        },
                        child: Card(
                          color: isSelected
                              ? (!isDataExist(pokemones[i])
                                  ? Colors.grey
                                  : Colors.green)
                              : pokemones[i].color,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(pokemones[i].imageUrl),
                              Text(
                                capitalize(pokemones[i].name!),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(1.0, 2.0),
                                      blurRadius: 8.0,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: isSelected,
              child: FloatingActionButton(
                onPressed: () async {
                  if (pokemoneAdd.isEmpty || pokemoneAdd.length < 6) {
                    PokemonDbRepository pokemonDbRepository =
                        PokemonDbRepository();
                    showToast('Tienes que agregar 6 pokemones');
                    final responsePokemons =
                        await pokemonDbRepository.getPokemons();
                  } else {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return DialogAddTeam(
                            onPressed: () async {
                              if (nameTeamController.text.isNotEmpty) {
                                try {
                                  PokemonDbRepository pokemonDbRepository =
                                      PokemonDbRepository();
                                  TeamDbRepository teamDbRepository =
                                      TeamDbRepository();
                                  final response =
                                      await teamDbRepository.insertTeam(
                                    TeamModel(name: nameTeamController.text),
                                  );
                                  for (var item in pokemoneAdd) {
                                    PokemonModel pokemon = PokemonModel(
                                      imagen: item.imageUrl,
                                      name: item.name,
                                      teamId: response,
                                      pokemonId: int.parse(item.id.toString()),
                                    );
                                    await pokemonDbRepository
                                        .insertPokemon(pokemon);
                                  }
                                  pokemoneAdd = [];
                                  nameTeamController.clear();
                                  Navigator.pop(context);
                                  setState(() {
                                    isSelected = !isSelected;
                                    showToast('Se creo tu equipo');
                                  });
                                } catch (e) {}
                              } else {
                                showToast('Debes agregar un nombre de equipo');
                              }
                            },
                            controller: nameTeamController);
                      },
                    );
                  }
                },
                child: const Icon(Icons.chevron_right),
              ),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  isSelected = !isSelected;
                  pokemoneAdd.clear();
                });
              },
              child: Icon(isSelected ? Icons.clear : Icons.add),
            ),
          ],
        ));
  }

  bool isDataExist(PokemonModel pokemon) {
    var data = pokemoneAdd.where((item) => (item.id == pokemon.id));
    if (data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
