import 'package:poke_api/src/config/theme/spacing.dart';
import 'package:poke_api/src/controllers/homeController/home_controller.dart';
import 'package:poke_api/src/utils/pkm_generation.dart';
import 'package:poke_api/src/views/exports.dart';
import 'package:poke_api/src/views/home/widgets/poke_chips/widgets/chips.dart';
import 'package:poke_api/src/views/widgets/twen_animaiton.dart';

class PokeChips extends ConsumerWidget {
  const PokeChips({super.key});

  void getOtherPokemonsRegion(PokemonGeneration generation, ref) {
    final homeController = ref.read(homeControllerProvider.notifier);
    homeController.getPokemons(generation: generation);
  }

  @override
  Widget build(BuildContext context, ref) {
    final homeController = ref.read(homeControllerProvider.notifier);
    final home = ref.watch(homeControllerProvider);

    return TwenAnimationType(
      type: AnimationType.translate,
      direction: AnimationDirection.left,

      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.x3,
          vertical: AppSizes.x4,
        ),
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: AppSizes.x2,
          children: List.generate(homeController.generationsName.length, (
            index,
          ) {
            final name = homeController.generationsName[index];
            final isCurrentRegion =
                home.currentGeneration == PokemonGeneration.values[index];

            return ChipAction(
              text: name,
              isCurrent: isCurrentRegion,
              onTap: () {
                final gen = PokemonGeneration.values[index];
                getOtherPokemonsRegion(gen, ref);
              },
            );
          }),
        ),
      ),
    );
  }
}
