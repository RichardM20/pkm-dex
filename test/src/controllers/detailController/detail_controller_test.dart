import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_api/src/controllers/detailCotroller/detail_pkm_controller.dart';
import 'package:poke_api/src/controllers/detailCotroller/detail_pkm_controller_state.dart';
import 'package:poke_api/src/controllers/homeController/home_controller.dart';
import 'package:poke_api/src/models/pokemon_detail_model.dart';
import 'package:poke_api/src/models/pokemon_model.dart';
import 'package:poke_api/src/models/pokemon_move_details.dart';

import 'detail_controller_test.mocks.dart';

void main() {
  final String url = 'https://pokeapi.co/api/v2/move';

  late MockPokeApi mockPokeApi;
  late DetailPkmController detailPkmController;
  late ProviderContainer container;

  setUp(() {
    mockPokeApi = MockPokeApi();

    container = ProviderContainer(
      overrides: [pokeApiProvider.overrideWithValue(mockPokeApi)],
    );

    detailPkmController = container.read(detailPkmProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  group('DetailPkmController Tests', () {
    test('Initial state should have default values', () {
      final state = detailPkmController.state;

      expect(state.isLoading, true);
      expect(state.isError, false);
      expect(state.pokemonDetails, isNull);
      expect(state.isLoadingMoves, true);
      expect(state.isErrorMoves, false);
    });

    test('setPokemonExtraData should update the state with Pokemon data', () {
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

      detailPkmController.setPokemonExtraData(mockPokemon);

      expect(
        detailPkmController.state.pokemonDetails?.pkmExtraData,
        mockPokemon,
      );
    });

    test(
      'getPkmDetails should fetch pokemon details and update state when successful',
      () async {
        final mockPokemonExtra = Pokemon(
          id: 1,
          name: 'bulbasaur',
          height: 7,
          weight: 69,
          types: [],
          sprites: Sprites(frontDefault: ''),
          stats: [],
          moves: [],
        );

        detailPkmController.setPokemonExtraData(mockPokemonExtra);

        final mockPokemonDetails = PkmDetails(
          id: 1,
          name: 'bulbasaur',
          flavorTextEntries: [
            FlavorTextEntry(
              flavorText:
                  'A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokémon.',
            ),
          ],
        );

        when(
          mockPokeApi.getPokemonDetails(pkmName: 'bulbasaur'),
        ).thenAnswer((_) async => mockPokemonDetails);

        await detailPkmController.getPkmDetails();

        verify(mockPokeApi.getPokemonDetails(pkmName: 'bulbasaur')).called(1);

        expect(detailPkmController.state.isLoading, false);
        expect(detailPkmController.state.isError, false);
        expect(
          detailPkmController.state.pokemonDetails?.pokemon,
          mockPokemonDetails,
        );
        expect(
          detailPkmController.state.pokemonDetails?.pkmExtraData,
          mockPokemonExtra,
        );
      },
    );

    test('getPkmDetails should handle errors correctly', () async {
      final mockPokemonExtra = Pokemon(
        id: 1,
        name: 'bulbasaur',
        height: 7,
        weight: 69,
        types: [],
        sprites: Sprites(frontDefault: ''),
        stats: [],
        moves: [],
      );

      detailPkmController.setPokemonExtraData(mockPokemonExtra);

      when(
        mockPokeApi.getPokemonDetails(pkmName: 'bulbasaur'),
      ).thenThrow(Exception('Network error'));

      await detailPkmController.getPkmDetails();

      expect(detailPkmController.state.isLoading, false);
      expect(detailPkmController.state.isError, true);
    });

    test(
      'getPkmMoveDetails should fetch move details and update state when successful',
      () async {
        final mockMoveDetails = PkmMoveDetails(
          id: 1,
          name: 'tackle',
          accuracy: 100,
          power: 40,
          pp: 35,
          type: ContestType(name: 'normal'),
          damageClass: ContestType(name: 'physical'),
          effectEntries: [
            EffectEntry(
              effect: 'Inflicts regular damage with no additional effect.',
              shortEffect: 'Inflicts regular damage.',
            ),
          ],
        );

        final moveUrl = '$url/1/';

        when(
          mockPokeApi.getMoveDetails(url: moveUrl),
        ).thenAnswer((_) async => mockMoveDetails);

        await detailPkmController.getPkmMoveDetails(url: moveUrl);

        verify(mockPokeApi.getMoveDetails(url: moveUrl)).called(1);

        expect(detailPkmController.state.isLoadingMoves, false);
        expect(detailPkmController.state.isErrorMoves, false);
        expect(
          detailPkmController.state.pokemonDetails?.moveDetails,
          mockMoveDetails,
        );
      },
    );

    test('getPkmMoveDetails should handle errors correctly', () async {
      final moveUrl = '$url/999/';

      when(
        mockPokeApi.getMoveDetails(url: moveUrl),
      ).thenThrow(Exception('Network error'));

      await detailPkmController.getPkmMoveDetails(url: moveUrl);

      expect(detailPkmController.state.isLoadingMoves, false);
      expect(detailPkmController.state.isErrorMoves, true);
    });

    test('resetState should reset the entire state to default values', () {
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

      detailPkmController.setPokemonExtraData(mockPokemon);

      detailPkmController.resetState();

      expect(detailPkmController.state.isLoading, true);
      expect(detailPkmController.state.isError, false);
      expect(detailPkmController.state.pokemonDetails, isNull);
      expect(detailPkmController.state.isLoadingMoves, true);
      expect(detailPkmController.state.isErrorMoves, false);
    });

    test('resetMoveDetails should reset only the move details', () async {
      final mockPokemonExtra = Pokemon(
        id: 1,
        name: 'bulbasaur',
        height: 7,
        weight: 69,
        types: [],
        sprites: Sprites(frontDefault: ''),
        stats: [],
        moves: [],
      );

      final mockPokemonDetails = PkmDetails(
        id: 1,
        name: 'bulbasaur',
        flavorTextEntries: [
          FlavorTextEntry(
            flavorText: 'A strange seed was planted on its back at birth.',
          ),
        ],
      );

      final mockMoveDetails = PkmMoveDetails(
        id: 1,
        name: 'tackle',
        accuracy: 100,
        power: 40,
        pp: 35,
        type: ContestType(name: 'normal'),
        damageClass: ContestType(name: 'physical'),
        effectEntries: [
          EffectEntry(
            effect: 'Inflicts regular damage with no additional effect.',
            shortEffect: 'Inflicts regular damage.',
          ),
        ],
      );

      detailPkmController = DetailPkmController(mockPokeApi)
        ..state = PkmDetailState(
          pokemonDetails: PkmAllDetailsData(
            pokemon: mockPokemonDetails,
            pkmExtraData: mockPokemonExtra,
            moveDetails: mockMoveDetails,
          ),
          isLoading: false,
          isLoadingMoves: false,
        );

      detailPkmController.resetMoveDetails();

      expect(
        detailPkmController.state.pokemonDetails?.pokemon,
        mockPokemonDetails,
      );
      expect(
        detailPkmController.state.pokemonDetails?.pkmExtraData,
        mockPokemonExtra,
      );
      expect(detailPkmController.state.pokemonDetails?.moveDetails, isNull);
      expect(detailPkmController.state.isLoadingMoves, false);
      expect(detailPkmController.state.isErrorMoves, false);
    });
  });
}
