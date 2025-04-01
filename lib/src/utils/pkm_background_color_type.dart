import 'package:flutter/material.dart';
import 'package:poke_api/src/models/pokemon_model.dart';
import 'package:poke_api/src/models/pokemon_move_details.dart';

Color pkmTypeBackground(List<PokemonType>? types) {
  if (types == null || types.isEmpty) return Colors.white;

  final pkmTypes = types.map((type) => type.type!.name).toList();

  return _getColor(pkmTypes.first);
}

Color pkmMoveBackground(ContestType? type) {
  if (type == null || type.name == null) return Colors.white;

  return _getColor(type.name);
}

Color _getColor(String? type) {
  switch (type) {
    case 'normal':
      return Colors.grey[400]!;
    case 'fire':
      return const Color.fromARGB(255, 208, 68, 13);
    case 'water':
      return const Color.fromARGB(255, 35, 163, 232);
    case 'grass':
      return const Color.fromARGB(255, 68, 211, 145);
    case 'electric':
      return const Color.fromARGB(255, 255, 230, 8);
    case 'ice':
      return Colors.cyan[300]!;
    case 'fighting':
      return const Color.fromARGB(255, 200, 170, 159);
    case 'poison':
      return const Color.fromARGB(255, 101, 18, 173);
    case 'ground':
      return Colors.orange[300]!;
    case 'flying':
      return Colors.blueGrey[300]!;
    case 'psychic':
      return const Color.fromARGB(255, 249, 66, 127);
    case 'bug':
      return Colors.lightGreen[300]!;
    case 'rock':
      return const Color.fromARGB(255, 168, 151, 100);
    case 'ghost':
      return Colors.deepPurple[300]!;
    case 'dragon':
      return const Color.fromARGB(255, 255, 145, 55);
    case 'dark':
      return Colors.black54;
    case 'steel':
      return Colors.blueGrey[400]!;
    case 'fairy':
      return const Color.fromARGB(255, 255, 122, 184);
    default:
      return Colors.white;
  }
}
