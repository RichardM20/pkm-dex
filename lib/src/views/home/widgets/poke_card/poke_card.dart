import 'package:poke_api/src/config/navigation/navigation.dart';
import 'package:poke_api/src/config/navigation/routes.dart';
import 'package:poke_api/src/config/theme/spacing.dart';
import 'package:poke_api/src/controllers/detailCotroller/detail_pkm_controller.dart';
import 'package:poke_api/src/models/pokemon_model.dart';
import 'package:poke_api/src/utils/pklm_sprites.dart';
import 'package:poke_api/src/utils/pkm_background_color_type.dart';
import 'package:poke_api/src/utils/text_mejora_formats.dart';
import 'package:poke_api/src/views/exports.dart';
import 'package:poke_api/src/views/home/widgets/poke_card/widgets/circles_background.dart';
import 'package:poke_api/src/views/home/widgets/poke_card/widgets/pokemon_type.dart';
import 'package:poke_api/src/views/widgets/poke_image.dart';

class PokeCard extends ConsumerWidget {
  const PokeCard({super.key, required this.pokemon});

  final Pokemon pokemon;
  final double _size = 185;

  Widget information() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.x4,
        vertical: AppSizes.x3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSizes.x1,
        children: [
          Text(
            capitalize(pokemon.name ?? ''),
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          PokemonTypeContent(types: pokemon.types ?? []),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () {
        Navigation.pushToDetailPage(context, Routes.detail);
        ref.read(detailPkmProvider.notifier).setPokemonExtraData(pokemon);
      },
      child: Container(
        constraints: BoxConstraints(minHeight: _size, minWidth: _size),
        decoration: BoxDecoration(
          color: pkmTypeBackground(pokemon.types ?? []),
          borderRadius: BorderRadius.circular(4),
        ),
        clipBehavior: Clip.none,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CirclesBackground(),
            information(),
            Positioned(
              right: -5,
              bottom: -5,
              child: Hero(
                tag: 'hero-${pokemon.id}',
                child: PokeImage(
                  source: getSprite(sprites: pokemon.sprites, animated: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
