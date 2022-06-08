import 'package:pokegendra/data/api.dart';
import 'package:pokegendra/data/models/pokemonInfo_model.dart';
import 'package:pokegendra/data/models/pokemon_model.dart';

class PokemonRepository {
  Api api = Api();
  Future getPokemons() async {
    try {
      Map<String, String> params = {
        'limit': 150.toString(),
      };
      final response = await api.get(
        'api/v2/pokemon',
        params: params,
      );
      List<PokemonModel> lista = [];
      for (var item in response.data["results"]) {
        String value = item['url'];
        String id = value.replaceAll('https://pokeapi.co/api/v2/pokemon/', '');
        String udid = id.replaceAll('/', '').trim();
        lista.add(PokemonModel(id: udid, name: item['name'], url: item['url']));
      }
      return lista;
    } catch (e) {}
  }

  Future getPokemonInfo(String idPokemon) async {
    try {
      final response = await api.get('api/v2/pokemon/' + idPokemon);
      PokemonInfoModel pokemonInfo = PokemonInfoModel.fromJson(response.data);
      return pokemonInfo;
    } catch (e) {
      print(e);
    }
  }

  Future getPokemonSpecie(String idPokemon) async {
    try {
      final response = await api.get('api/v2/pokemon/' + idPokemon);
      print(response.data);
    } catch (e) {}
  }
}
