import 'package:poke_api/src/controllers/detailCotroller/detail_pkm_controller_state.dart';
import 'package:poke_api/src/controllers/homeController/home_controller.dart';
import 'package:poke_api/src/models/pokemon_detail_model.dart';
import 'package:poke_api/src/models/pokemon_model.dart';
import 'package:poke_api/src/models/pokemon_move_details.dart';
import 'package:poke_api/src/services/poke_api.dart';
import 'package:poke_api/src/views/exports.dart';

class DetailPkmController extends StateNotifier<PkmDetailState> {
  DetailPkmController(this._pokeApi) : super(PkmDetailState());

  final PokeApi _pokeApi;

  Future<void> _updateStateWithDetails({
    PkmDetails? pokemon,
    Pokemon? pkmExtraData,
    PkmMoveDetails? moveDetails,
    bool? isLoading,
    bool? isError,
    bool? isLoadingMoves,
    bool? isErrorMoves,
  }) async {
    state = state.copyWith(
      pokemonDetails: PkmAllDetailsData(
        pokemon: pokemon ?? state.pokemonDetails?.pokemon,
        moveDetails: moveDetails ?? state.pokemonDetails?.moveDetails,
        pkmExtraData: pkmExtraData ?? state.pokemonDetails?.pkmExtraData,
      ),
      isErrorMoves: isErrorMoves ?? state.isErrorMoves,
      isLoadingMoves: isLoadingMoves ?? state.isLoadingMoves,
      isError: isError ?? state.isError,
      isLoading: isLoading ?? state.isLoading,
    );
  }

  Future<void> getPkmDetails() async {
    await _updateStateWithDetails(isLoading: true, isError: false);
    try {
      final pokemon = await _pokeApi.getPokemonDetails(
        pkmName: state.pokemonDetails?.pkmExtraData?.name ?? '',
      );

      await Future.delayed(const Duration(seconds: 1));
      await _updateStateWithDetails(
        pokemon: pokemon,
        isLoading: false,
        isError: false,
      );
    } catch (e) {
      await _updateStateWithDetails(isError: true, isLoading: false);
    }
  }

  Future<void> getPkmMoveDetails({required String url}) async {
    await _updateStateWithDetails(isLoadingMoves: true, isErrorMoves: false);
    try {
      final moveDetails = await _pokeApi.getMoveDetails(url: url);

      await _updateStateWithDetails(
        moveDetails: moveDetails,
        isLoadingMoves: false,
        isErrorMoves: false,
      );
    } catch (e) {
      await _updateStateWithDetails(isErrorMoves: true, isLoadingMoves: false);
    }
  }

  void setPokemonExtraData(Pokemon? pkmExtraData) {
    _updateStateWithDetails(pkmExtraData: pkmExtraData);
  }

  void resetState() {
    state = PkmDetailState();
  }

  void resetMoveDetails() {
    state = state.copyWith(
      isLoadingMoves: false,
      isErrorMoves: false,
      pokemonDetails: PkmAllDetailsData(
        pokemon: state.pokemonDetails?.pokemon,
        moveDetails: null,
        pkmExtraData: state.pokemonDetails?.pkmExtraData,
      ),
    );
  }
}

final detailPkmProvider =
    StateNotifierProvider<DetailPkmController, PkmDetailState>(
      (ref) => DetailPkmController(ref.read(pokeApiProvider)),
    );
