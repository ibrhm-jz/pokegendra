import 'package:flutter/material.dart';
import 'package:pokegendra/data/db/pokemon_db_repository.dart';
import 'package:pokegendra/data/models/pokemon_model.dart';
import 'package:pokegendra/ui/widgets/default_image.dart';
import 'package:pokegendra/ui/widgets/text_utils.dart';

class TeamsDetail extends StatefulWidget {
  final int? id;
  TeamsDetail({Key? key, required this.id});

  @override
  _TeamsDetailState createState() => _TeamsDetailState();
}

class _TeamsDetailState extends State<TeamsDetail> {
  List<PokemonModel> pokemones = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIntegrantes();
  }

  Future getIntegrantes() async {
    PokemonDbRepository pokemonDbRepository = PokemonDbRepository();
    final response = await pokemonDbRepository.getPokemonsByTeamId(widget.id);
    setState(() {
      pokemones = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrantes de equipos'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: pokemones.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                        pokemones[i].imagen.toString(),
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    title: normalText(pokemones[i].name.toString()),
                  ),
                  Divider(),
                ],
              );
            }),
      ),
    );
  }
}
