import 'package:pokegendra/data/db/db.dart';
import 'package:pokegendra/data/models/pokemon_model.dart';
import 'package:sqflite/sqflite.dart';

class PokemonDbRepository {
  DB db = DB();
  Future<int> insertPokemon(PokemonModel pokemonModel) async {
    Database database = await db.openDb();
    return await database.insert("pokemones", pokemonModel.toMap());
  }

  Future<int> deletePokemon(PokemonModel pokemonModel) async {
    Database database = await db.openDb();
    return await database
        .delete("pokemones", where: "id = ?", whereArgs: [pokemonModel.id]);
  }

  Future<int> updatePokemon(PokemonModel pokemonModel) async {
    Database database = await db.openDb();
    return await database.update("pokemones", pokemonModel.toMap(),
        where: "id = ?", whereArgs: [pokemonModel.id]);
  }

  Future<List<PokemonModel>> getPokemons() async {
    Database database = await db.openDb();
    final List<Map<String, dynamic>> pokemones =
        await database.query('pokemones');
    return List.generate(
      pokemones.length,
      (i) => PokemonModel(
        id: pokemones[i]['id'].toString(),
        name: pokemones[i]['name'],
        imagen: pokemones[i]['imagen'],
        teamId: pokemones[i]['teamid'],
        pokemonId: pokemones[i]['pokemonId'],
      ),
    );
  }

  Future<List<PokemonModel>> getPokemonsByTeamId(teamId) async {
    Database database = await db.openDb();
    final List<Map<String, dynamic>> pokemones = await database
        .query('pokemones', where: "teamId = ?", whereArgs: [teamId]);
    return List.generate(
      pokemones.length,
      (i) => PokemonModel(
        id: pokemones[i]['id'].toString(),
        name: pokemones[i]['name'],
        imagen: pokemones[i]['imagen'],
        teamId: pokemones[i]['teamId'],
        pokemonId: pokemones[i]['pokemonId'],
      ),
    );
  }
}
