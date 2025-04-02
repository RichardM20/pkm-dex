import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_api/src/controllers/homeController/home_controller.dart';
import 'package:poke_api/src/controllers/homeController/home_controller_state.dart';
import 'package:poke_api/src/models/pokemon_model.dart';
import 'package:poke_api/src/services/poke_api.dart';
import 'package:poke_api/src/views/home/pokemon_home.dart';
import 'package:poke_api/src/views/home/widgets/poke_appbar.dart';
import 'package:poke_api/src/views/home/widgets/poke_card/poke_card.dart';
import 'package:poke_api/src/views/home/widgets/poke_list.dart';
import 'package:poke_api/src/views/widgets/poke_error_data.dart';

import 'pokemon_home_test.mocks.dart';

@GenerateMocks([PokeApi])
void main() {
  late MockPokeApi mockPokeApi;
  late List<Pokemon> mockPokemonList;

  setUp(() {
    mockPokeApi = MockPokeApi();

    mockPokemonList = [
      Pokemon(
        id: 1,
        name: 'Bulbasaur',
        height: 7,
        weight: 69,
        sprites: Sprites(frontDefault: 'https://example.com/bulbasaur.png'),
        types: [PokemonType(type: Species(name: 'grass'))],
      ),
      Pokemon(
        id: 2,
        name: 'Ivysaur',
        height: 10,
        weight: 130,
        sprites: Sprites(frontDefault: 'https://example.com/bulbasaur.png'),
        types: [PokemonType(type: Species(name: 'grass'))],
      ),
    ];
  });

  group('PokemonHome', () {
    testWidgets('Display all widget', (tester) async {
      await tester.pumpWidget(
        ProviderScope(child: MaterialApp(home: PokemonHome())),
      );

      expect(find.byType(PokeAppbar), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(PokeList), findsWidgets);
    });
  });

  group('PokemonHome - PokeList', () {
    testWidgets('Should show loading state initially and then Pokemon cards', (
      WidgetTester tester,
    ) async {
      final homeControllerProviderOverride =
          StateNotifierProvider<HomeController, HomeState>(
            (ref) => HomeController(mockPokeApi),
          );

      when(
        mockPokeApi.getPokemon(pokemonId: 1),
      ).thenAnswer((_) async => mockPokemonList[0]);
      when(
        mockPokeApi.getPokemon(pokemonId: 2),
      ).thenAnswer((_) async => mockPokemonList[1]);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            homeControllerProvider.overrideWithProvider(
              homeControllerProviderOverride,
            ),
          ],
          child: const MaterialApp(home: PokemonHome()),
        ),
      );

      await tester.pump();

      await tester.pump(const Duration(seconds: 3));

      expect(find.byType(PokeCard), findsWidgets);
    });

    testWidgets('Should show error widget when API fails', (
      WidgetTester tester,
    ) async {
      final homeControllerProviderOverride =
          StateNotifierProvider<HomeController, HomeState>(
            (ref) => HomeController(mockPokeApi),
          );

      when(
        mockPokeApi.getPokemon(pokemonId: anyNamed('pokemonId')),
      ).thenThrow(Exception('API error'));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            homeControllerProvider.overrideWithProvider(
              homeControllerProviderOverride,
            ),
          ],
          child: const MaterialApp(home: PokemonHome()),
        ),
      );

      await tester.pump(const Duration(seconds: 3));

      expect(find.byType(PokeError), findsOneWidget);
    });
  });
}
