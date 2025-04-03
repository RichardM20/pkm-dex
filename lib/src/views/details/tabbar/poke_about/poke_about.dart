import 'package:poke_api/src/config/theme/spacing.dart';
import 'package:poke_api/src/controllers/detailCotroller/detail_pkm_controller.dart';
import 'package:poke_api/src/utils/pkm_description.dart';
import 'package:poke_api/src/utils/pkm_genera.dart';
import 'package:poke_api/src/views/details/tabbar/widgets/titles.dart';
import 'package:poke_api/src/views/exports.dart';
import 'package:poke_api/src/views/widgets/row_texts.dart';
import 'package:poke_api/src/views/widgets/twen_animaiton.dart';

class PokeAboutContent extends ConsumerWidget {
  const PokeAboutContent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final pokemon = ref.watch(detailPkmProvider).pokemonDetails;
    return TwenAnimationType(
      direction: AnimationDirection.down,
      type: AnimationType.translate,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getPokemonDescription(pokemon?.pokemon?.flavorTextEntries),
              style: GoogleFonts.poppins(fontSize: AppSizes.fontx3),
            ),
            SizedBox(height: AppSizes.x3),
            RowTexts(
              title: 'Species',
              value: getGenera(pokemon?.pokemon?.genera),
            ),
            RowTexts(
              title: 'Height',
              value: '${pokemon?.pkmExtraData?.height} m',
            ),
            RowTexts(
              title: 'Weight',
              value: '${pokemon?.pkmExtraData?.weight} kg',
            ),
            SizedBox(height: AppSizes.x3),
            DetailsTitle(title: 'Breeding', size: AppSizes.fontx3),
            SizedBox(height: AppSizes.x1),
            RowTexts(
              title: 'Hatchability',
              value: '${pokemon?.pokemon?.hatchCounter} steps',
            ),
            RowTexts(
              title: 'Egg Groups',
              value:
                  pokemon?.pokemon?.eggGroups?.map((e) => e.name).join(', ') ??
                  '',
            ),
            RowTexts(
              title: 'Habitat',
              value: pokemon?.pokemon?.habitat?.name ?? 'Unknown',
            ),
            RowTexts(
              title: 'Shape',
              value: pokemon?.pokemon?.shape?.name ?? 'Unknown',
            ),
          ],
        ),
      ),
    );
  }
}
