import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_api/src/services/poke_api.dart';

@GenerateMocks([http.Client])
void main() {
  const String baseUrl = 'https://pokeapi.co/api/v2';
  late PokeApi pokeApi;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient((request) async => http.Response('{}', 200));
    pokeApi = PokeApi();
  });

  void mockHttpResponse(String url, int statusCode, String response) {
    when(
      mockClient.get(Uri.parse(url)),
    ).thenAnswer((_) async => http.Response(response, statusCode));
  }

  group('PokeApi Tests - Success', () {
    test('returns a Pokémon when the response is 200', () async {
      const pokemonId = 1;
      final response = jsonEncode({
        "id": 1,
        "name": "bulbasaur",
        "height": 7,
        "weight": 69,
        "types": [
          {
            "slot": 1,
            "type": {"name": "grass"},
          },
        ],
      });

      mockHttpResponse('$baseUrl/pokemon/$pokemonId', 200, response);

      final pokemon = await pokeApi.getPokemon(pokemonId: pokemonId);
      expect(pokemon, isNotNull);
      expect(pokemon!.name, equals('bulbasaur'));
    });

    test('returns Pokémon details when the response is 200', () async {
      const pokemonName = 'bulbasaur';
      final response = jsonEncode({
        "id": 1,
        "name": "bulbasaur",
        "flavor_text_entries": [
          {
            "flavor_text": "A strange seed was planted on its back.",
            "language": {"name": "en"},
          },
        ],
      });

      mockHttpResponse('$baseUrl/pokemon-species/$pokemonName', 200, response);

      final details = await pokeApi.getPokemonDetails(pkmName: pokemonName);
      expect(details, isNotNull);
      expect(details!.name, equals('bulbasaur'));
    });

    test('returns move details when the response is 200', () async {
      const moveUrl = '$baseUrl/move/1/';
      final response = jsonEncode({
        "id": 1,
        "name": "pound",
        "power": 40,
        "pp": 35,
        "type": {"name": "normal"},
      });

      mockHttpResponse(moveUrl, 200, response);

      final moveDetails = await pokeApi.getMoveDetails(url: moveUrl);
      expect(moveDetails, isNotNull);
      expect(moveDetails!.name, equals('pound'));
    });
  });

  group('PokeApi Tests - Error Cases', () {
    void testErrorCase(String url, Future Function() apiCall) {
      mockHttpResponse(url, 404, 'Not Found');
      expect(apiCall(), completion(isNull));
    }

    test('returns null when Pokémon is not found (404)', () {
      testErrorCase(
        '$baseUrl/pokemon/99999',
        () => pokeApi.getPokemon(pokemonId: 99999),
      );
    });

    test('returns null when Pokémon details are not found (404)', () {
      testErrorCase(
        '$baseUrl/pokemon-species/nonexistent',
        () => pokeApi.getPokemonDetails(pkmName: 'nonexistent'),
      );
    });

    test('returns null when move details are not found (404)', () {
      testErrorCase(
        '$baseUrl/move/99999/',
        () => pokeApi.getMoveDetails(url: '$baseUrl/move/99999/'),
      );
    });
  });
}
