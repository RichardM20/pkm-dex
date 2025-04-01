import 'package:poke_api/src/controllers/detailCotroller/detail_pkm_controller.dart';
import 'package:poke_api/src/models/pokemon_move_table.dart';
import 'package:poke_api/src/utils/pkm_background_color_type.dart';
import 'package:poke_api/src/views/details/tabbar/poke_moves/widgets/table/widgets/poke_table_row.dart';
import 'package:poke_api/src/views/exports.dart';

class PokeTableMoves extends ConsumerWidget {
  final String? learnMethodFilter;
  final bool sortByLevel;
  final ValueChanged<String>? onMovePressed;

  const PokeTableMoves({
    super.key,
    this.learnMethodFilter,
    this.sortByLevel = true,
    this.onMovePressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(detailPkmProvider).pokemonDetails;
    final pkmMoves = pokemon?.pkmExtraData?.moves;

    if (pkmMoves == null || pkmMoves.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<PokemonMove> moves =
        pkmMoves
            .where((move) => move.versionGroupDetails?.isNotEmpty ?? false)
            .map((move) => PokemonMove.fromMoveData(move))
            .toList();

    final filteredMoves =
        learnMethodFilter != null
            ? moves
                .where(
                  (move) =>
                      move.method.toLowerCase() ==
                      learnMethodFilter!.toLowerCase(),
                )
                .toList()
            : moves;

    if (sortByLevel) {
      filteredMoves.sort((a, b) => a.level.compareTo(b.level));
    }

    if (filteredMoves.isEmpty) {
      return const SizedBox.shrink();
    }

    final headerMove = PokemonMove(
      name: 'Move',
      method: 'Method',
      level: 0,
      displayLevel: 'Level',
    );

    final backgroundColor = pkmTypeBackground(pokemon?.pkmExtraData?.types);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
            columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(3)},
            children: [
              MoveTableRow(
                move: headerMove,
                isHeader: true,
                headerColor: backgroundColor,
                onMovePressed: null,
              ),

              ...filteredMoves.map(
                (move) =>
                    MoveTableRow(move: move, onMovePressed: onMovePressed),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
