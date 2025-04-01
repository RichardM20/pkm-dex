import 'package:poke_api/src/controllers/homeController/home_controller_state.dart';
import 'package:poke_api/src/models/pokemon_model.dart';
import 'package:poke_api/src/services/poke_api.dart';
import 'package:poke_api/src/utils/pkm_generation.dart';
import 'package:poke_api/src/views/exports.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController(this._pokeApi) : super(HomeState());

  final PokeApi _pokeApi;

  final generationsLength = PokemonGenerationUtils.getGenerations();
  final generationsName = PokemonGenerationUtils.getGenerationsNames();

  void setRequestComplete(double requestProgress) {
    state = state.copyWith(requestProgress: requestProgress);
  }

  Future<void> _getPokemons({required PokemonGeneration generation}) async {
    List<Pokemon> pokemons = [];
    int begin = PokemonGenerationUtils.getGenerationLimit(generation);
    int cont = 0;

    for (int i = begin; i <= generation.limit; i++) {
      final pokemon = await _pokeApi.getPokemon(pokemonId: i);
      if (pokemon == null) continue;

      pokemons.add(pokemon);
      cont++;
      state = state.copyWith(requestCompleted: cont);
      state = state.copyWith(
        pokemons: {
          ...state.pokemons,
          generation: [...pokemons],
        },
        requestProgress: cont / generation.limit,
      );
    }
  }

  Future<void> getPokemons({required PokemonGeneration generation}) async {
    if (state.pokemons[generation]?.isNotEmpty == true) {
      state = state.copyWith(currentGeneration: generation);
      return;
    }

    state = state.copyWith(
      isLoading: true,
      isError: false,
      currentGeneration: generation,
    );

    try {
      await _getPokemons(generation: generation);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, isError: true);
    }
  }
}

final homeControllerProvider = StateNotifierProvider<HomeController, HomeState>(
  (ref) {
    final pokeApi = ref.watch(pokeApiProvider);
    return HomeController(pokeApi);
  },
);

final pokeApiProvider = Provider((ref) => PokeApi());
