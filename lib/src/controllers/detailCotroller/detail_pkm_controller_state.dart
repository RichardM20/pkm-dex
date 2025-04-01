import 'package:poke_api/src/models/pokemon_detail_model.dart';
import 'package:poke_api/src/models/pokemon_model.dart';
import 'package:poke_api/src/models/pokemon_move_details.dart';

class PkmAllDetailsData {
  final PkmDetails? pokemon;
  final Pokemon? pkmExtraData;
  final PkmMoveDetails? moveDetails;

  PkmAllDetailsData({this.pokemon, this.pkmExtraData, this.moveDetails});

  PkmAllDetailsData copyWith({
    PkmDetails? pokemon,
    Pokemon? pkmExtraData,
    PkmMoveDetails? moveDetails,
  }) {
    return PkmAllDetailsData(
      pokemon: pokemon ?? this.pokemon,
      pkmExtraData: pkmExtraData ?? this.pkmExtraData,
      moveDetails: moveDetails ?? this.moveDetails,
    );
  }
}

class PkmDetailState {
  final PkmAllDetailsData? pokemonDetails;
  final bool isLoading;
  final bool isError;
  final bool isLoadingMoves;
  final bool isErrorMoves;

  PkmDetailState({
    this.pokemonDetails,
    this.isLoading = true,
    this.isError = false,
    this.isLoadingMoves = true,
    this.isErrorMoves = false,
  });

  PkmDetailState copyWith({
    PkmAllDetailsData? pokemonDetails,
    bool? isLoading,
    bool? isError,
    bool? isLoadingMoves,
    bool? isErrorMoves,
  }) {
    return PkmDetailState(
      pokemonDetails: pokemonDetails ?? this.pokemonDetails,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isLoadingMoves: isLoadingMoves ?? this.isLoadingMoves,
      isErrorMoves: isErrorMoves ?? this.isErrorMoves,
    );
  }
}
