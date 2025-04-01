import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:poke_api/src/models/pokemon_detail_model.dart';
import 'package:poke_api/src/models/pokemon_model.dart';
import 'package:poke_api/src/models/pokemon_move_details.dart';

class PokeApi {
  static final String _endPoint = 'https://pokeapi.co/api/v2';
  static final String _pokemon = '$_endPoint/pokemon';
  static final pkmDetail = '$_endPoint/pokemon-species';

  Future<Pokemon?> getPokemon({required pokemonId}) async {
    final uri = Uri.parse('$_pokemon/$pokemonId');

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final pokemon = Pokemon.fromJson(data);
      return pokemon;
    } else {
      return null;
    }
  }

  Future<PkmDetails?> getPokemonDetails({required pkmName}) async {
    final uri = Uri.parse('$pkmDetail/$pkmName');

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final pokemon = PkmDetails.fromJson(data);
      return pokemon;
    } else {
      return null;
    }
  }

  Future<PkmMoveDetails?> getMoveDetails({required url}) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PkmMoveDetails.fromJson(data);
    } else {
      return null;
    }
  }
}
