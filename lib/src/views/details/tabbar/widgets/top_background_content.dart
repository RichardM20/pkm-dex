import 'package:poke_api/src/config/theme/spacing.dart';
import 'package:poke_api/src/controllers/detailCotroller/detail_pkm_controller.dart';
import 'package:poke_api/src/utils/pklm_sprites.dart';
import 'package:poke_api/src/utils/pkm_background_color_type.dart';
import 'package:poke_api/src/utils/pkm_number_pokedex.dart';
import 'package:poke_api/src/views/details/tabbar/widgets/titles.dart';
import 'package:poke_api/src/views/exports.dart';
import 'package:poke_api/src/views/home/widgets/poke_card/widgets/pokemon_type.dart';
import 'package:poke_api/src/views/widgets/poke_image.dart';

class PkmTopDetailContent extends ConsumerWidget {
  const PkmTopDetailContent({super.key});

  final double height = 200;
  final double bigHeight = 400;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(detailPkmProvider);
    final pokemon = state.pokemonDetails;

    if (state.isLoading) {
      return SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      color: pkmTypeBackground(pokemon?.pkmExtraData?.types),
      child: Stack(
        children: [
          Positioned(
            right: -height,
            bottom: -20,
            child: PokeImage(
              isLocal: true,
              opacity: 0.07,
              source: 'assets/pokeball_background.png',
              width: bigHeight,
              height: bigHeight,
            ),
          ),
          Positioned(
            left: -70,
            top: -75,
            child: PokeImage(
              isLocal: true,
              opacity: 0.2,
              source: 'assets/pokeball_background.png',
              width: height,
              height: height,
            ),
          ),
          Center(
            child: Hero(
              tag: 'hero-${pokemon?.pkmExtraData?.id}',
              child: PokeImage(
                height: height - 20,
                source: getSprite(
                  sprites: pokemon?.pkmExtraData?.sprites,
                  animated: true,
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 59,
            child: Column(
              spacing: AppSizes.x2,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DetailsTitle(
                  title: pokemon?.pkmExtraData?.name ?? '',
                  color: Colors.white,
                ),
                PokemonTypeContent(types: pokemon?.pkmExtraData?.types),
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: 30,
            child: Column(
              spacing: AppSizes.x2,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DetailsTitle(
                  title: '#${formatPokedexNumber(pokemon?.pkmExtraData?.id)}',
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
