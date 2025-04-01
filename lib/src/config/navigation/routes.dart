import 'package:flutter/material.dart';
import 'package:poke_api/src/views/details/pokemon_details.dart';
import 'package:poke_api/src/views/home/pokemon_home.dart';

abstract class Routes {
  static const home = '/pokemon-home';
  static const detail = '/pokemon-details';

  static String get initialRoute => home;

  static Map<String, WidgetBuilder> get routes => {
    home: (context) => const PokemonHome(),
    detail: (context) => const PokemonDetails(),
  };
}
