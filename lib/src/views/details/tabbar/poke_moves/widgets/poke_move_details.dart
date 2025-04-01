import 'package:poke_api/src/config/theme/spacing.dart';
import 'package:poke_api/src/controllers/detailCotroller/detail_pkm_controller.dart';
import 'package:poke_api/src/utils/pkm_background_color_type.dart';
import 'package:poke_api/src/utils/pkm_description.dart';
import 'package:poke_api/src/utils/text_mejora_formats.dart';
import 'package:poke_api/src/views/exports.dart';
import 'package:poke_api/src/views/widgets/row_texts.dart';

class MoveDetails extends ConsumerWidget {
  const MoveDetails({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final pokemon = ref.watch(detailPkmProvider).pokemonDetails;
    final pkmMoves = pokemon?.moveDetails;
    return Column(
      spacing: AppSizes.x2,
      children: [
        GestureDetector(
          onTap: () {
            ref.read(detailPkmProvider.notifier).resetMoveDetails();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: AppSizes.x2,
            children: [
              Icon(Icons.arrow_back_ios_new_rounded, size: 14),
              Text(capitalize(pkmMoves?.name), style: GoogleFonts.poppins()),
            ],
          ),
        ),
        Text(
          getPokemonDescription([], entriesMove: pkmMoves?.flavorTextEntries),
        ),
        RowTexts(
          title: 'Type',
          value: pkmMoves?.type?.name ?? '',
          color: pkmMoveBackground(pkmMoves?.type),
        ),
        RowTexts(
          title: 'Damage Class',
          value: pkmMoves?.damageClass?.name ?? 'Unknown',
        ),
        RowTexts(
          title: 'Accuracy',
          value: pkmMoves?.accuracy?.toString() ?? '0',
        ),
        RowTexts(title: 'Power', value: pkmMoves?.power?.toString() ?? '0'),
        RowTexts(title: 'PP', value: pkmMoves?.pp?.toString() ?? '0'),
        RowTexts(
          title: 'Priority',
          value: pkmMoves?.priority?.toString() ?? '0',
        ),
        RowTexts(
          title: 'Effect Chance',
          value: pkmMoves?.effectChance?.toString() ?? '0',
        ),
        RowTexts(
          title: 'Effect',
          value: pkmMoves?.effectEntries?.first.effect ?? 'Unknown',
        ),
        RowTexts(
          title: 'Effect Description',
          value: pkmMoves?.effectEntries?.first.shortEffect ?? 'Unknown',
        ),
      ],
    );
  }
}
