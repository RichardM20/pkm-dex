import 'package:poke_api/src/models/pokemon_model.dart';
import 'package:poke_api/src/utils/pkm_generation.dart';

class HomeState {
  final Map<PokemonGeneration, List<Pokemon>> pokemons;
  final PokemonGeneration currentGeneration;
  final double requestProgress;
  final int requestCompleted;
  final bool isLoading;
  final bool isError;

  HomeState({
    this.requestCompleted = 0,
    this.requestProgress = 0,
    this.pokemons = const {},
    this.isLoading = false,
    this.currentGeneration = PokemonGeneration.first,
    this.isError = false,
  });

  HomeState copyWith({
    bool? isLoading,
    bool? isError,
    Map<PokemonGeneration, List<Pokemon>>? pokemons,
    double? requestProgress,
    PokemonGeneration? currentGeneration,
    int? requestCompleted,
  }) {
    return HomeState(
      requestCompleted: requestCompleted ?? this.requestCompleted,
      requestProgress: requestProgress ?? this.requestProgress,
      currentGeneration: currentGeneration ?? this.currentGeneration,
      pokemons: pokemons ?? this.pokemons,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
