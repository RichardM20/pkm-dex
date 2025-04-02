import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_api/src/controllers/homeController/home_controller.dart';
import 'package:poke_api/src/controllers/homeController/home_controller_state.dart';
import 'package:poke_api/src/models/pokemon_model.dart';
import 'package:poke_api/src/services/poke_api.dart';
import 'package:poke_api/src/utils/pkm_generation.dart';

import 'home_controller.test.mocks.dart';

@GenerateMocks([PokeApi])
void main() {
  late MockPokeApi mockPokeApi;
  late HomeController homeController;
  late ProviderContainer container;

  setUp(() {
    mockPokeApi = MockPokeApi();

    container = ProviderContainer(
      overrides: [pokeApiProvider.overrideWithValue(mockPokeApi)],
    );

    homeController = container.read(homeControllerProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  group('HomeController Tests', () {
    test('Initial state should have default values', () {
      final state = homeController.state;

      expect(state.isLoading, false);
      expect(state.isError, false);
      expect(state.pokemons, isEmpty);
      expect(state.currentGeneration, PokemonGeneration.first);
      expect(state.requestProgress, 0);
      expect(state.requestCompleted, 0);
    });

    test('setRequestComplete should update requestProgress', () {
      homeController.setRequestComplete(0.5);

      expect(homeController.state.requestProgress, 0.5);
    });

    test(
      'getPokemons should return early if pokemons for generation already exist',
      () async {
        final initialPokemons = {
          PokemonGeneration.second: [
            Pokemon(
              id: 152,
              name: 'chikorita',
              height: 9,
              weight: 64,
              types: [],
              sprites: Sprites(frontDefault: ''),
              stats: [],
              moves: [],
            ),
          ],
        };

        homeController = HomeController(mockPokeApi)
          ..state = HomeState(
            pokemons: initialPokemons,
            currentGeneration: PokemonGeneration.first,
          );

        await homeController.getPokemons(generation: PokemonGeneration.second);

        verifyNever(mockPokeApi.getPokemon(pokemonId: 152));

        expect(
          homeController.state.currentGeneration,
          PokemonGeneration.second,
        );
        expect(homeController.state.pokemons, initialPokemons);
        expect(homeController.state.isLoading, false);
      },
    );

    test(
      'getPokemons should fetch pokemons and update state when successful',
      () async {
        final mockPokemon = Pokemon(
          id: 1,
          name: 'bulbasaur',
          height: 7,
          weight: 69,
          types: [],
          sprites: Sprites(frontDefault: ''),
          stats: [],
          moves: [],
        );

        when(
          mockPokeApi.getPokemon(pokemonId: 1),
        ).thenAnswer((_) async => mockPokemon);

        await homeController.getPokemons(generation: PokemonGeneration.first);

        verify(mockPokeApi.getPokemon(pokemonId: 1)).called(1);

        expect(homeController.state.isLoading, false);
        expect(homeController.state.currentGeneration, PokemonGeneration.first);
        expect(homeController.state.pokemons[PokemonGeneration.first], [
          mockPokemon,
        ]);
        expect(homeController.state.requestCompleted, 1);
        expect(
          homeController.state.requestProgress,
          1 / PokemonGeneration.first.limit,
        );
      },
    );

    test('getPokemons should handle errors correctly', () async {
      when(
        mockPokeApi.getPokemon(pokemonId: -9999),
      ).thenThrow(Exception('Network error'));

      await homeController.getPokemons(generation: PokemonGeneration.first);

      expect(homeController.state.isLoading, false);
      expect(homeController.state.isError, true);
      expect(homeController.state.currentGeneration, PokemonGeneration.first);
    });

    test(
      'generationsLength and generationsName should return correct values',
      () {
        expect(
          homeController.generationsLength,
          PokemonGenerationUtils.getGenerations(),
        );
        expect(
          homeController.generationsName,
          PokemonGenerationUtils.getGenerationsNames(),
        );
      },
    );
  });
}
