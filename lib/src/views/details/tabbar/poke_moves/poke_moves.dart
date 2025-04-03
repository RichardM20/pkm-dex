import 'package:poke_api/src/config/theme/spacing.dart';
import 'package:poke_api/src/controllers/detailCotroller/detail_pkm_controller.dart';
import 'package:poke_api/src/views/details/tabbar/poke_moves/widgets/poke_move_details.dart';
import 'package:poke_api/src/views/details/tabbar/poke_moves/widgets/table/poke_moves_table.dart';
import 'package:poke_api/src/views/exports.dart';
import 'package:poke_api/src/views/widgets/twen_animaiton.dart';

class PokeMovesContent extends ConsumerWidget {
  const PokeMovesContent({super.key});

  Widget _buildPokeTableMoves(WidgetRef ref) {
    return Column(
      children: [
        PokeTableMoves(
          learnMethodFilter: "level-up",
          sortByLevel: true,
          onMovePressed: (url) {
            ref.read(detailPkmProvider.notifier).getPkmMoveDetails(url: url);
          },
        ),
        PokeTableMoves(
          learnMethodFilter: "machine",
          sortByLevel: false,
          onMovePressed: (url) {
            ref.read(detailPkmProvider.notifier).getPkmMoveDetails(url: url);
          },
        ),

        PokeTableMoves(
          learnMethodFilter: "tutor",
          sortByLevel: false,
          onMovePressed: (url) {
            ref.read(detailPkmProvider.notifier).getPkmMoveDetails(url: url);
          },
        ),
        PokeTableMoves(
          learnMethodFilter: "egg",
          sortByLevel: false,
          onMovePressed: (url) {
            ref.read(detailPkmProvider.notifier).getPkmMoveDetails(url: url);
          },
        ),
      ],
    );
  }

  Widget _animatedLayoutBuilder(
    Widget? currentChild,
    List<Widget> previousChildren,
  ) {
    return Column(
      children: [
        if (previousChildren.isNotEmpty) ...previousChildren,
        if (currentChild != null) currentChild,
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(detailPkmProvider).pokemonDetails;
    final pkmMoves = pokemon?.moveDetails;

    return TwenAnimationType(
      direction: AnimationDirection.up,
      type: AnimationType.translate,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.x2),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          layoutBuilder: _animatedLayoutBuilder,
          child:
              pkmMoves == null
                  ? _buildPokeTableMoves(ref)
                  : const MoveDetails(),
        ),
      ),
    );
  }
}
